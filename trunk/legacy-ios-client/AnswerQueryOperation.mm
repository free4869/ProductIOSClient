//
//  AnswerQueryOperation.m
//  iAnswer
//
//  Created by Di Wang on 11-09-02.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import "AnswerQueryOperation.h"
#import "IAnswerUtilities.h"
#import "SBJson.h"

#import "TargetConditionals.h"

@implementation AnswerQueryOperation

@synthesize questionCorrectQuery, speexData_, fineQuestion_,repeatQuery_, quantaRlt_;

static CLLocation* lastLocation = nil;
static NSTimeInterval locationBirthday;

- (id)initWithQuestionCorrectQuery:(NSString*) aQuestionCorrectQuery target:(id)target engineIndex:(int)index
{
    self = [super init];
    if (self) {
        // Initialization fields
        [self setQuestionCorrectQuery:aQuestionCorrectQuery];
        [self setSpeexData_:nil];
        delegate_ = target;
        qaEngineIndex = index;
        operationMode_ = QUERYTEXT;
    }
    return self;   
}

- (id)initWithAudio:(NSData*) speexData target:(id)target engineIndex:(int)index
{
    self = [super init];
    if (self) {
        // Initialization fields
        [self setQuestionCorrectQuery:nil];
        [self setSpeexData_:speexData];
        delegate_ = target;
        qaEngineIndex = index;
        operationMode_ = AUDIOINPUT;
    }
    
    return self;   
}

- (id)initWithAudioAndRepeatQuery:(NSData*) speexData repeatQuery:(NSString*) repeatQuery target:(id)target engineIndex:(int)index;
{
    self = [super init];
    if (self) {
        // Initialization fields
        [self setQuestionCorrectQuery:nil];
        [self setRepeatQuery_:repeatQuery];
        [self setSpeexData_:speexData];
        delegate_ = target;
        qaEngineIndex = index;
        operationMode_ = REPEAT;
    }
    
    return self;   
}


- (id)initWithFineQuesion:(NSString*) question target:(id)target engineIndex:(int)index
{
    self = [super init];
    if (self) {
        // Initialization fields
        [self setQuestionCorrectQuery:nil];
        [self setSpeexData_:nil];
        [self setFineQuestion_:question];
        delegate_ = target;
        qaEngineIndex = index;
        operationMode_ = FINETEXT;
    }
    
    return self;   
}

- (void)dealloc {
    [questionCorrectQuery release], questionCorrectQuery = nil;
    if (operationMode_ == AUDIOINPUT) {
        [speexData_ release], speexData_ = nil;
    }
    [super dealloc];
}

+(CLLocation*)getCurrentLocation
{

    // try use cache data
    if (lastLocation) {
        NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - locationBirthday;
        if (duration < 3600) {
            return lastLocation;
        }
    }
    
#if TARGET_IPHONE_SIMULATOR
    CLLocation* defaultLocation = [[CLLocation alloc] initWithLatitude:43.4704 longitude:-80.5423];
    return defaultLocation;
#elif TARGET_OS_IPHONE
    //fetch new data
    CLLocationManager *manager = [[CLLocationManager alloc] init];    
    [manager startUpdatingLocation];
    do{
        [NSThread sleepForTimeInterval:0.25];
    }while (![manager location]);
    
    CLLocation *location = [manager location];
    [manager stopUpdatingHeading];
    [manager release];

    locationBirthday = [NSDate timeIntervalSinceReferenceDate];
    if (lastLocation) {
        [lastLocation release], lastLocation = nil;
    }
    lastLocation = [location copy];
    return location;
#endif
    
}


-(void)queryGoogleSpeechRecognizer
{
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    
    NSURL *theURL = [NSURL URLWithString:@"https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=en-US&maxresults=3"];
    
    // lang=zh-CN 
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f];
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setValue:@"audio/x-speex-with-header-byte; rate= 16000" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:[self speexData_]];
    
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    NSString *theResponseString = [[NSString alloc] initWithData:theResponseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",theResponseString);
    [theResponseString release];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonObject = [jsonParser objectWithData:theResponseData]; 
    [jsonParser release];
    jsonParser = nil;
    
    NSArray *hypotheses = [jsonObject objectForKey:@"hypotheses"];
    
    int numHypotheses = [hypotheses count];
    
    NSString* q0 = [NSString string];
    NSString* q1 = [NSString string];
    NSString* q2 = [NSString string];
    float p0 = -1 ;
    
    switch (numHypotheses) {
        case 3:
            q2 = [(NSDictionary*)[hypotheses objectAtIndex:2] objectForKey:@"utterance"];
        case 2:
            q1 = [(NSDictionary*)[hypotheses objectAtIndex:1] objectForKey:@"utterance"];
        case 1:
            q0 = [(NSDictionary*)[hypotheses objectAtIndex:0] valueForKey:@"utterance"];
            p0 = [[(NSDictionary*)[hypotheses objectAtIndex:0] valueForKey:@"confidence"] floatValue];
            break;
        default:
            [self cancel];
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(queryCanceled) withObject:nil waitUntilDone:NO];
            return; 
    }
    
    NSString *queryFormat;
   
    NSString* originalQuestion = q0;
    q0 = [IAnswerUtilities makeEscapeString:q0];
    q1 = [IAnswerUtilities makeEscapeString:q1];
    q2 = [IAnswerUtilities makeEscapeString:q2];
    
    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
    NSLog(@"speech duration %f", duration);
    
    //make api query
    if(operationMode_ == REPEAT){
        queryFormat = @"%@&q4=%@&q5=%@&q6=%@";
        [self setQuestionCorrectQuery:[NSString stringWithFormat:queryFormat, repeatQuery_, q0, q1,q2]]; 
    }else{
        
        start = [NSDate timeIntervalSinceReferenceDate];
        if([self verticalAnswering:originalQuestion]){
            duration = [NSDate timeIntervalSinceReferenceDate] - start;
            NSLog(@"verticalAnswering duration %f", duration);
            return;
        }
                
        queryFormat = @"http://m160.cs.uwaterloo.ca/correction/questionCorrection.jsp?type=0&q1=%@&q2=%@&q3=%@&mode=0&p1=%f";
        
        [self setQuestionCorrectQuery:[NSString stringWithFormat:queryFormat, q0, q1,q2,p0]];
        [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setLastQuery:) withObject:questionCorrectQuery waitUntilDone:NO];
    }
    
    NSLog(@"Question Correct Query : %@", questionCorrectQuery);
}

- (void)main {
    
    if(qaEngineIndex == 1){
        if (operationMode_ != FINETEXT) {
            NSLog(@"ERROR: not FINETEXT on QAnswer");
        }
        NSString* result = nil;
        
        result = [self queryLaoMa:fineQuestion_];
        if (result) {
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuestionText:) withObject:fineQuestion_ waitUntilDone:YES];
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswerWebview:) withObject:result waitUntilDone:YES]; 
            return;
        }
        
        
        result = [self queryChineseVertical:fineQuestion_];
        if (result) {
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuestionText:) withObject:fineQuestion_ waitUntilDone:NO];
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswerWebview:) withObject:result waitUntilDone:NO]; 
            return;
        }
        
        result = [self queryQAnswer:fineQuestion_];
        if (result) {
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuestionText:) withObject:fineQuestion_ waitUntilDone:NO];
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswerWebview:) withObject:result waitUntilDone:NO];
            return;
        }
        
        qaEngineIndex = 2;
    }
    
    
    if (operationMode_ == AUDIOINPUT || operationMode_ == REPEAT) {
        [self queryGoogleSpeechRecognizer];
    }else if(operationMode_ == FINETEXT){
        if(qaEngineIndex==0 && [self verticalAnswering:[self fineQuestion_]]){  
            return;
        }
    }
    
    if([self isCancelled]) return; 
    
    NSString *questionCorrRlt;
    if(operationMode_ != FINETEXT){
        questionCorrRlt = [IAnswerUtilities getTrimedStringFromQuery:questionCorrectQuery];
        if (!questionCorrRlt) {
            NSLog(@"Question Correct fails");
        }else{
            NSLog(@"Question Correct Result : %@", questionCorrRlt);
        }
              
        
        NSArray *chunks = [questionCorrRlt componentsSeparatedByString: @"##"];
        NSString* CorrRltQuestion = [[chunks objectAtIndex:1] stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if([self processCall:questionCorrRlt]){
            return;
        }
        
        questionCorrRlt = CorrRltQuestion;
        
    }else{
        questionCorrRlt = fineQuestion_;
    }
    
    //check point
    if([self isCancelled]) 
        return;
    
    [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuestionText:) withObject:questionCorrRlt waitUntilDone:NO];

    //Chinese to English translation
    NSString *questionTranslateRlt;
    if(qaEngineIndex == 2){ //translation
        
        NSString *queryFormat = @"http://m160.cs.uwaterloo.ca/correction/test.jsp?type=1&q1=%@";
        NSString *questionTranslateQuery = [NSString stringWithFormat:queryFormat,fineQuestion_];
        NSString *qStringEncoded = [questionTranslateQuery stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        questionTranslateRlt = [IAnswerUtilities getTrimedStringFromQuery:qStringEncoded];
        if (!questionTranslateRlt) {
            NSLog(@"Question Translate fails");
        }else{
            NSLog(@"Question Translate Result : %@", questionTranslateRlt);
            NSArray *chunks = [questionTranslateRlt componentsSeparatedByString: @"#"];
            if ([chunks count] == 3) {
                questionCorrRlt = [chunks objectAtIndex:2];
                questionCorrRlt = [questionCorrRlt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                NSString* transRltReadable = [NSString stringWithFormat:
                                              @"Original Question: %@<br />Google translation: %@<br />Our translation: %@",
                                              [chunks objectAtIndex:0], [chunks objectAtIndex:1], [chunks objectAtIndex:2]];
                
                
                [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuestionPreprocessResult:) withObject:transRltReadable waitUntilDone:YES];
                
                if([self verticalAnswering:questionCorrRlt]){ //do vertical 
                    return;
                }
                
            }else{
               NSLog(@"Wrong Question Translate Result Format."); 
            }
        }
    }
    
    //:::::::-------- send question to QA engine ---------------//
    
    NSString *delimiter;
    NSString *queryFormat;
    
    switch (qaEngineIndex) {

        case 2:
        case 0:
            qaEngine = TRUEKNOWLEDGE;
            delimiter = @"_";
            queryFormat = @"http://www.evi.com/q/%@";
            break;
        case 1:
            qaEngine = QANSWERS;
            delimiter = @"";
            queryFormat = @"http://www.qanswers.net:80/cqa/search.do?method=search&encoding=utf8&keyword=%@";
            break;
            
        case -4:
            qaEngine = WATANSWER;
            delimiter = @"+";
            queryFormat = @"http://m160.cs.uwaterloo.ca/templateqa/shortAnswer.jsp?q=%@";
            break;
        case -1:
            qaEngine = YAHOOANSWER;
            delimiter = @"+";
            queryFormat = @"http://answers.yahooapis.com/AnswersService/V1/questionSearch?type=resolved&appid=gxbP0ZLV34GtdN2AAIeoPIazqielw.W6lvs2uMp5PMbv7r5Ehck_Ldy_whjLrg--&results=1&query=%@";
            break;
        case -2:
            qaEngine = LAOMA;
            delimiter = @" ";
            queryFormat = @"http://www.laoma.com/nls_web/mysearch/result?word=%@&service=all&focusService=all";
            break;
        case -3:
            qaEngine = QUANTA; //old quanta
            delimiter = @"+";
            queryFormat = @"http://m160.cs.uwaterloo.ca/quanta/result.jsp?question=%@&radio1=yahoo";
            break;
            
        default:
            qaEngine = TRUEKNOWLEDGE;
            delimiter = @"_";
            queryFormat = @"http://www.evi.com//q/%@";
            NSLog(@"Warning: qaEngine select default.");
            break;
    }
    
    
    ////------------ WatAnswer -------
    if (qaEngine == TRUEKNOWLEDGE || qaEngine == TRANSLATION) {
        
        NSString* watAnswerRlt = [AnswerQueryOperation queryWatAnswer:questionCorrRlt];
        if (watAnswerRlt) { 
            NSString* vqaStart = @"VQA#";
            if ([watAnswerRlt length]>[vqaStart length])
                if([[watAnswerRlt substringToIndex:[vqaStart length]] isEqualToString:vqaStart]){
                    [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswer:)
                                                           withObject:[watAnswerRlt substringFromIndex:[vqaStart length]] waitUntilDone:NO];
                    return;
                }
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setPartialAnswer:) withObject:watAnswerRlt waitUntilDone:NO];
        }
        
        NSString* gCalcRlt = [AnswerQueryOperation queryGoogleCalc:questionCorrRlt];
        if (gCalcRlt) {
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswer:) withObject:gCalcRlt waitUntilDone:NO];
            return;
        }
                
    }
    ////------------ WatAnswer ------- end ----------
    
    ////------------ Quanta ------- start ----------
    [self setQuantaRlt_:nil];
    NSThread* quantaThread = [[NSThread alloc] initWithTarget:self selector:@selector(queryQuanta:) object:questionCorrRlt];
    [quantaThread start];
    
    ////------------ Quanta ------- end ----------
    
   
    ////------------ Eng CQA ------- start ----------
    NSString* qcqaRlt = [self queryEnglishCQA:questionCorrRlt];
    if (qcqaRlt) {
        [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswer:) withObject:qcqaRlt waitUntilDone:NO];
        return;
    }
    ////------------ Eng CQA ------- end ----------
    
    
    
    NSString *trimmedQuestion =[questionCorrRlt stringByTrimmingCharactersInSet:
                                [NSCharacterSet punctuationCharacterSet]];
    NSString *qStringDeli = [trimmedQuestion stringByReplacingOccurrencesOfString:@" " withString:delimiter];
    NSString *qStringEncoded = [qStringDeli stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    //make api query
    NSString *queryUrlString = [NSString stringWithFormat:queryFormat, qStringEncoded];
    NSLog(@"queryUrlString : %@",queryUrlString);

    NSError* error;
    NSString* htmlString;
    
    //TimeOut
    [self performSelector:@selector(cancelOnTimeOut) withObject:nil afterDelay:30];
    
    if(qaEngine == QANSWERS || qaEngine == LAOMA){
        htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:queryUrlString] encoding:NSUTF8StringEncoding error:&error];
    }else if(qaEngine == TRUEKNOWLEDGE){
        NSString* tkRlt = [self queryLocalTrueK:questionCorrRlt];
        
        if(![self isCancelled]){//check point
            [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setTKRlt:) withObject:tkRlt waitUntilDone:YES];
        }
        return;
        
    }else{
        htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:queryUrlString]];
    }                                     
    
    if (qaEngine == QANSWERS) {
        [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswerWebview:) 
                                               withObject: [AnswerQueryOperation filterQAnswer:htmlString] waitUntilDone:NO]; 
    }else if(qaEngine == WATANSWER || qaEngine == TRUEKNOWLEDGE ){
        ;
    }else{
        
        NSString* jsString;
        switch (qaEngine) {
            case QUANTA:
                jsString = @"document.getElementsByTagName('h1')[0].textContent";
                break;
                
            case LAOMA:
                jsString = @"document.getElementsByTagName('table')[3].textContent";
                break; 
                
            default:
                jsString = [NSString string];
                break;
        }
        
        NSArray* htmlAndJs = [[NSArray alloc] initWithObjects:htmlString, jsString,nil]; 
        
        //check point
        if([self isCancelled]) return;
        
        [(NSObject*)delegate_ performSelectorOnMainThread:@selector(extractAnswerFromHTMLAndJS:) withObject:htmlAndJs waitUntilDone:NO];
        
        while ([quantaThread isExecuting]) {
            [NSThread sleepForTimeInterval:1];
            if ([self isCancelled]) {
                [quantaThread cancel];
                return;
            }
        }
    }
}

-(NSString*)queryLocalTrueK:(NSString*) question
{
    NSString* encodedQuestion = [question stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]; 
    NSString *queryFormat = @"http://m160.cs.uwaterloo.ca:8073/web/tkAnswer.jsp?q=%@";
    NSString *query = [NSString stringWithFormat:queryFormat,encodedQuestion];
    NSLog(@"queryLocalTrueK:%@",query);
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    NSString *watAnswerRlt = [IAnswerUtilities getTrimedStringFromQuery:query];
    NSTimeInterval   duration = [NSDate timeIntervalSinceReferenceDate] - start;
    NSLog(@"queryLocalTrueK duration %f", duration);
    if([watAnswerRlt rangeOfString:@"Sorry, we"].location != NSNotFound){
        return nil;
    }else{
        return watAnswerRlt;
    }
}


-(NSString*)queryChineseVertical:(NSString*) question
{
    NSString* encodedQuestion = [question stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]; 
    CLLocation *location = [AnswerQueryOperation getCurrentLocation];
    NSString *queryFormat = @"http://m160.cs.uwaterloo.ca/internalqa/verticalAnswer.jsp?q=%@&lat=%f&lng=%f&language=chinese";
    NSString *watAnswerQuery = [NSString stringWithFormat:queryFormat,encodedQuestion,
                                [location coordinate].latitude, [location coordinate].longitude];
    NSLog(@"queryChineseVertical:%@",watAnswerQuery);
    
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    
    NSString *watAnswerRlt = [IAnswerUtilities getTrimedStringFromQuery:watAnswerQuery];
    
    NSTimeInterval   duration = [NSDate timeIntervalSinceReferenceDate] - start;
    NSLog(@"queryChineseVertical duration %f", duration);
    
    if([watAnswerRlt rangeOfString:@"No answer found."].location != NSNotFound){
        return nil;
    }else{
        return watAnswerRlt;
    }
}

-(NSString*)queryEnglishCQA:(NSString*) question
{
    NSString* queryFormat = @"http://m160.cs.uwaterloo.ca/quanta2/index.jsp?question=%@&type=1";
    
    NSString *trimmedQuestion =[question stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
    NSString *qStringEncoded = [IAnswerUtilities makeEscapeString:trimmedQuestion];
    NSString *queryUrlString = [NSString stringWithFormat:queryFormat, qStringEncoded];
    NSLog(@"queryUrlString : %@",queryUrlString);
    
    NSString* htmlString = [IAnswerUtilities getTrimedStringFromQuery:queryUrlString];
    NSLog(@"ecqa %@",htmlString);
    
    if([htmlString rangeOfString:@"Sorry, we cannot answer this"].location != NSNotFound){
        return nil;
    }else{
        return htmlString;
    }
    
}

-(NSString*)queryQAnswer:(NSString*) question
{
    NSString* queryFormat = @"http://www.qanswers.net:80/cqa/search.do?method=search&encoding=utf8&keyword=%@";
    
    NSString *trimmedQuestion =[question stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
    NSString *qStringEncoded = [trimmedQuestion stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSString *queryUrlString = [NSString stringWithFormat:queryFormat, qStringEncoded];
    NSLog(@"queryUrlString : %@",queryUrlString);
    
     
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:queryUrlString]];    
    NSString* htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if([htmlString rangeOfString:@"对不起"].location != NSNotFound){
        return nil;
    }else{
        return [AnswerQueryOperation filterQAnswer:htmlString];
    }
    
}

-(NSString*)queryLaoMa:(NSString*) question
{
    NSURL *theURL = [NSURL URLWithString:@"http://123.196.120.115:8080/robot/chat"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f];
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setValue:@"text/html; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:[question dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    NSString *theResponseString = [[NSString alloc] initWithData:theResponseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",theResponseString);
    [theResponseString release];    
    
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonObject = [jsonParser objectWithData:theResponseData]; 
    [jsonParser release];
    jsonParser = nil;
    
    NSString* status = [jsonObject objectForKey:@"status"];
    if([status isEqualToString:@"certain"]){
        NSMutableString* answer = [NSMutableString stringWithCapacity:128];
        NSArray* results = [jsonObject objectForKey:@"results"];
        for (NSDictionary *result in results) {
            [answer appendFormat:@"%@ <br/>",[result objectForKey:@"html_result"]];
        }
        return answer;
    }else{
        return nil;
    }
}


-(BOOL)verticalAnswering:(NSString*) question
{
    
    NSString *watAnswerRlt = [self queryVerticalAnswer:question isPhoneSearch:0];
    
    if (watAnswerRlt == nil) {
        NSLog(@"WatAnswer fails");
    }else{
        watAnswerRlt = [watAnswerRlt stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"verticalAnswering Result : %@", watAnswerRlt);
        
        if (![watAnswerRlt isEqualToString:@"No answer found."]) {
            
            if(![self processCall:watAnswerRlt]){
                [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswer:)
                                                       withObject:watAnswerRlt waitUntilDone:NO];
                [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuestionText:) withObject:question waitUntilDone:NO];
            }
            
            [self cancel];
            return YES;
        }
    }
    
    NSString* gCalcRlt = [AnswerQueryOperation queryGoogleCalc:question];
    if (gCalcRlt) {
        [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswer:) withObject:gCalcRlt waitUntilDone:NO];
        [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuestionText:) withObject:question waitUntilDone:NO];
        [self cancel];
        return YES;
    }

    return NO;
}

-(BOOL)processCall:(NSString*)questionRlt
{
    NSArray *chunks = [questionRlt componentsSeparatedByString: @"##"];
    if([chunks count] > 1){
        
        NSString* questionType = [[chunks objectAtIndex:0] stringByTrimmingCharactersInSet:
                                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* CorrRltQuestion = [[chunks objectAtIndex:1] stringByTrimmingCharactersInSet:
                                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuestionText:) withObject:CorrRltQuestion waitUntilDone:NO];
        
        if([questionType isEqual:@"1"] || [questionType isEqual:@"2"]){ //TEL or SMS
               
            //------------------- Search phone's address book -----------------------------
            ABAddressBookRef addressBook = ABAddressBookCreate();
            NSString* peopleName = [chunks objectAtIndex:2];
            NSArray *people = (NSArray *)ABAddressBookCopyPeopleWithName(addressBook, (CFStringRef)peopleName);
            
            if ((people != nil) && [people count])
            {
                ABRecordRef person = (ABRecordRef)[people objectAtIndex:0];
                ABMultiValueRef phones =(NSString*)ABRecordCopyValue(person, kABPersonPhoneProperty);
                NSString* mobile=@"";
                NSString* mobileLabel;
                for(CFIndex i = 0; i < ABMultiValueGetCount(phones); i++) {
                    mobileLabel = (NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
                    if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
                    {
                        [mobile release] ;
                        mobile = (NSString*)ABMultiValueCopyValueAtIndex(phones, i);
                    }
                    else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel])
                    {
                        [mobile release] ;
                        mobile = (NSString*)ABMultiValueCopyValueAtIndex(phones, i);
                        break ;
                    }
                }  
                
                NSLog(@"mobile : %@",mobile); 
                //------------------- Search phone's address book -------------- done ---------------

                if([questionType isEqual:@"1"]){
                    [(NSObject*)delegate_ performSelectorOnMainThread:@selector(dialContactPhone:) withObject:mobile waitUntilDone:YES];
                }else if([questionType isEqual:@"2"]){
                    NSString* message = [chunks objectAtIndex:3];
                    NSArray* targets = [[NSArray alloc] initWithObjects:mobile,nil];
                    NSArray* bodyAndTargets = [[NSArray alloc] initWithObjects:message,targets,nil];
                    [(NSObject*)delegate_ performSelectorOnMainThread:@selector(sendSMS:) withObject:bodyAndTargets waitUntilDone:YES];
                }
                
                NSLog(@"phone finish"); 
                [self cancel];
                return YES;
            }
            else 
            {
                NSLog(@"Not in contact list."); 
                
                if([questionType isEqual:@"2"]){
                    [(NSObject*)delegate_ performSelectorOnMainThread:@selector(displayAnswer:)
                                            withObject:[NSString stringWithFormat:@"Can't find %@ in your address book.", peopleName] 
                                            waitUntilDone:NO];
                    [self cancel];
                    return YES;
                }

                
                NSString* phoneSearchRlt = [self queryVerticalAnswer:CorrRltQuestion isPhoneSearch:1]; 
                [(NSObject*)delegate_ performSelectorOnMainThread:@selector(dialPhone:) withObject:phoneSearchRlt waitUntilDone:YES];
                return YES;
            }
        }
        
    }
    
    return NO;
}

-(void)cancelOnTimeOut
{
    if ([self isExecuting]) {
        [self cancel];
    }else{
        return;
    }    
    NSLog(@"cancelOnTimeOut");
    [(NSObject*)delegate_ performSelectorOnMainThread:@selector(operationTimeOut) withObject:nil waitUntilDone:NO];
}

+(NSString*)queryWatAnswer:(NSString*) question
{
    question = [IAnswerUtilities makeEscapeString:question];
    
   CLLocation *location = [AnswerQueryOperation getCurrentLocation];
    NSString *queryFormat = @"http://m160.cs.uwaterloo.ca/templateqa/shortAnswer.jsp?q=%@&lat=%f&lng=%f";

    NSString *watAnswerQuery = [NSString stringWithFormat:queryFormat,question,[location coordinate].latitude, [location coordinate].longitude];
    NSLog(@"%@",watAnswerQuery);
    NSString *watAnswerRlt = [IAnswerUtilities getTrimedStringFromQuery:watAnswerQuery];
    if (watAnswerRlt == nil) {
        NSLog(@"WatAnswer fails");
    }else{
        watAnswerRlt = [watAnswerRlt stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"WatAnswer Result : %@", watAnswerRlt);
        
        if ([watAnswerRlt isEqualToString:@"No answer found."]) {
            return nil;
        }else{
            return watAnswerRlt;
        }
    }
    
    return nil;
}


-(NSString*)queryVerticalAnswer:(NSString*) question isPhoneSearch:(int)phoneSearch
{
    NSString* encodedQuestion = [IAnswerUtilities makeEscapeString:question];
    
    CLLocation *location = [AnswerQueryOperation getCurrentLocation];
    
    NSString *queryFormat = @"http://m160.cs.uwaterloo.ca/internalqa/verticalAnswer.jsp?q=%@&lat=%f&lng=%f&phone=%d";
    NSString *watAnswerQuery = [NSString stringWithFormat:queryFormat,encodedQuestion,
                                [location coordinate].latitude, [location coordinate].longitude, phoneSearch];
    NSLog(@"verticalAnswering:%@",watAnswerQuery);
    
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
        
    NSString *watAnswerRlt = [IAnswerUtilities getTrimedStringFromQuery:watAnswerQuery];
    
    NSTimeInterval   duration = [NSDate timeIntervalSinceReferenceDate] - start;
    NSLog(@"queryVerticalAnswer duration %f", duration);
    
    return watAnswerRlt;
}



-(void)queryQuanta:(NSString*) question
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString* quanta = [NSString stringWithFormat:@"http://m160.cs.uwaterloo.ca/quanta2/index.jsp?question=%@", 
                                        [IAnswerUtilities makeEscapeString:question]];
    NSLog(@"quanta query : %@",quanta);
    NSURL *theURL = [NSURL URLWithString:quanta];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:200.0f];
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    NSString *answer = [[NSString alloc] initWithData:theResponseData encoding:NSUTF8StringEncoding];
    answer = [answer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"quanta answer : %@",answer);
    if (answer==nil || [answer length]==0) {
        answer = @"Sorry, no answer found.";
    }
   
	[(NSObject*)delegate_ performSelectorOnMainThread:@selector(setQuntaRlt:) withObject:[answer copy] waitUntilDone:YES];
    
    
    [answer release];
    [pool drain];
}


+(NSString*)filterQAnswer:(NSString*) answer
{
    NSRange range = [answer rangeOfString:@"<a href=http://"];
    if (range.length==0) {
        NSLog(@"filterQAnswer : NA");
        return nil;
    }else{
        NSString* answer1= [answer substringToIndex:range.location];
        NSString* answer2= [answer substringFromIndex:range.location];
        
        NSRange tmp = [answer2 rangeOfString:@"</a>"];
        answer2 = [answer2 substringFromIndex:(tmp.location+tmp.length)];
        return [answer1 stringByAppendingString:answer2];
    }

}

+(NSString*)queryGoogleCalc:(NSString*) question
{
    question = [question lowercaseString];
    question = [question stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    question = [question stringByTrimmingCharactersInSet:
                                [NSCharacterSet punctuationCharacterSet]];
    
    NSString* encodedQuestion = [IAnswerUtilities makeEscapeString:question];
    
    NSString* googleCalcUrl = [NSString stringWithFormat:@"http://www.google.com/search?gcx=w&client=safari&ie=UTF-8&q=%@",encodedQuestion];
    
    NSLog(@"googleCalcUrl:%@", googleCalcUrl);
    
    NSURL *theURL = [NSURL URLWithString:googleCalcUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f];
    [theRequest setValue:@"Mozilla/5.0" forHTTPHeaderField:@"User-Agent"];
    
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
    NSString *theResponseString = [[NSString alloc] initWithData:theResponseData encoding:NSUTF8StringEncoding];
    
    NSRange range = [theResponseString rangeOfString:@"images/icons/onebox/calculator-40.gif\"></td><td dir=\"ltr\" style=\"padding-left:.5em\"><span class=\"nobr\"><h2 class=\"r\" dir=\"ltr\" style=\"font-size:138%\">"];
    if (range.length==0) {
        NSLog(@"queryGoogleCalc : NA");
        return nil;
    }else{
        NSString* answerFollows= [theResponseString substringFromIndex:(range.location+range.length)];
        NSRange tmp = [answerFollows rangeOfString:@"</h2>"];
        
        NSString* answer = [answerFollows substringToIndex:tmp.location];
        NSLog(@"queryGoogleCalc %@", answer);
        
        [theResponseString release];
        
        return answer;
    }
    
}

    
+(NSString*)googleTranslate:(NSString*)input
{
    return nil;
}

@end
