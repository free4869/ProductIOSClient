//
//  iAnswerViewController.m
//  iAnswer
//
//  Created by Di Wang on 11-09-08.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import "iAnswerViewController.h"

#import "IAnswerUtilities.h"
#import "AnswerQueryOperation.h"
#import <AVFoundation/AVFoundation.h>
#import "SpeexEncoder.h"


unsigned char SpeechKitApplicationKey0[] = { 0xa0, 0x71, 0xf1, 0x80, 0x35, 0xb3, 0xd5, 0xf0, 0xef, 0xb2, 0x1a, 0x57, 0x5e, 0xca, 0x78, 0x77, 0xdc, 0xa2, 0x1b, 0xae, 0x2a, 0xc2, 0xbe, 0x5a, 0x2a, 0x46, 0x90, 0xd3, 0xd4, 0xd1, 0xd6, 0x74, 0x42, 0xc7, 0xf5, 0x77, 0x7b, 0xca, 0x68, 0x6a, 0x7c, 0x82, 0xc1, 0xda, 0x4d, 0x3a, 0x51, 0x29, 0xdc, 0x6c, 0xd8, 0x07, 0x2e, 0x96, 0x61, 0x59, 0xdd, 0xf1, 0x2c, 0xb1, 0xc2, 0x03, 0x26, 0x04 };

const unsigned char SpeechKitApplicationKey1[] = {0xa3, 0x30, 0xd0, 0xec, 0x1f, 0xe7, 0xc7, 0xb0, 0xbd, 0x3e, 0x07, 0x62, 0xc5, 0x68, 0xcb, 0xcc, 0x14, 0x3a, 0x78, 0x94, 0x6b, 0x0a, 0x6c, 0x95, 0xc8, 0x72, 0xe0, 0x6f, 0x87, 0x91, 0xa6, 0x2a, 0xc1, 0x76, 0x16, 0xe0, 0x5e, 0xde, 0x90, 0x1b, 0x1c, 0x97, 0x7d, 0xe1, 0x00, 0x48, 0xad, 0x14, 0x82, 0x26, 0xa9, 0xee, 0x30, 0x15, 0x83, 0xf8, 0x88, 0x64, 0x68, 0x0f, 0xf5, 0x0e, 0x3a, 0xb6};

const unsigned char SpeechKitApplicationKey2[] = {0x55, 0xf9, 0x98, 0x43, 0x59, 0x08, 0xcf, 0x0a, 0xed, 0x01, 0xc0, 0x58, 0x8e, 0xcb, 0xc2, 0x71, 0xae, 0x83, 0x4c, 0x54, 0x66, 0x0f, 0x7f, 0x15, 0x75, 0x6b, 0x91, 0x96, 0xb3, 0x95, 0x80, 0x09, 0x8f, 0x19, 0x4c, 0xe8, 0x21, 0x1b, 0xf3, 0x0e, 0x1c, 0xb3, 0x66, 0xaa, 0x7e, 0x28, 0x1b, 0x2d, 0xab, 0x67, 0x81, 0x11, 0x76, 0x00, 0x27, 0xec, 0x6c, 0xb8, 0x82, 0x1f, 0x4e, 0x02, 0x28, 0xdd};

const unsigned char SpeechKitApplicationKey3[] = {0xd4, 0x87, 0xdc, 0x35, 0x31, 0x5f, 0x8f, 0xec, 0x00, 0xa9, 0xf6, 0x4f, 0x1f, 0x3a, 0xde, 0x00, 0x7e, 0x72, 0x55, 0xcf, 0xa8, 0x67, 0xe9, 0x7f, 0x5b, 0x61, 0x48, 0x5f, 0xee, 0x90, 0xdd, 0xc2, 0x17, 0xb9, 0xf7, 0x49, 0x18, 0x87, 0x35, 0x18, 0x30, 0x2b, 0x67, 0x4f, 0x65, 0x45, 0x50, 0xe3, 0xb7, 0xa5, 0xb2, 0x5f, 0x0c, 0x9c, 0xdf, 0x67, 0xfd, 0x27, 0xc7, 0xeb, 0xb7, 0xa4, 0xad, 0xce};


unsigned char SpeechKitApplicationKey[] = { 0xa0, 0x71, 0xf1, 0x80, 0x35, 0xb3, 0xd5, 0xf0, 0xef, 0xb2, 0x1a, 0x57, 0x5e, 0xca, 0x78, 0x77, 0xdc, 0xa2, 0x1b, 0xae, 0x2a, 0xc2, 0xbe, 0x5a, 0x2a, 0x46, 0x90, 0xd3, 0xd4, 0xd1, 0xd6, 0x74, 0x42, 0xc7, 0xf5, 0x77, 0x7b, 0xca, 0x68, 0x6a, 0x7c, 0x82, 0xc1, 0xda, 0x4d, 0x3a, 0x51, 0x29, 0xdc, 0x6c, 0xd8, 0x07, 0x2e, 0x96, 0x61, 0x59, 0xdd, 0xf1, 0x2c, 0xb1, 0xc2, 0x03, 0x26, 0x04 };


#define H_CONTROL_ORIGIN CGPointMake(20, 70)
#define H_CONTROL_FRAME CGRectMake(20, 70, 20, 20)
#define APPID @"4e439878" // appid for iphone问答系统，清华大学，朱小燕老师，请勿修改！
#define ENGINE_URL @"http://dev.voicecloud.cn/index.htm"


@implementation iAnswerViewController

@synthesize askButton;
@synthesize repeatButton;
@synthesize questionTextField;
@synthesize webViewAnswerExtractor;
@synthesize answerWebview;
@synthesize langSelector;
@synthesize lastQuery;
@synthesize recordingView;
@synthesize quntaAnswer;
//@synthesize bestEffortAtLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    //[audioPlayerListen_ release];
    //[audioPlayerDone_ release];
    [operationQueue_ release], operationQueue_ = nil;
    [questionTextField release];
    [askButton release];
    [langSelector release];
    [repeatButton release];
    [answerWebview release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
    
    if([iAnswerViewController isExpired]){
        exit(0);
    }
    
    [super viewDidLoad];
    
    int apiNum = arc4random() % 4;
    switch (apiNum) {
        case 0:
            memcpy(SpeechKitApplicationKey, SpeechKitApplicationKey0, 64);
            [SpeechKit setupWithID:@"NMDPTRIAL_digowang20110531143611"
                              host:@"sandbox.nmdp.nuancemobility.net"
                              port:443];
            
            break;
        case 1:
            memcpy(SpeechKitApplicationKey, SpeechKitApplicationKey1, 64);
            [SpeechKit setupWithID:@"NMDPTRIAL_tangyang20110531144027"
                              host:@"sandbox.nmdp.nuancemobility.net"
                              port:443];
            break;
        case 2:
            memcpy(SpeechKitApplicationKey, SpeechKitApplicationKey2, 64);
            [SpeechKit setupWithID:@"NMDPTRIAL_dragon4iphone20110617173503"
                              host:@"sandbox.nmdp.nuancemobility.net"
                              port:443];
            break;
        case 3:
            memcpy(SpeechKitApplicationKey, SpeechKitApplicationKey3, 64);
            [SpeechKit setupWithID:@"NMDPTRIAL_dragon4iphone320110617175546"
                              host:@"sandbox.nmdp.nuancemobility.net"
                              port:443];
            break;
    }
    
	SKEarcon* earconCancel	= [SKEarcon earconWithName:@"earcon_cancel.wav"];
	[SpeechKit setEarcon:earconCancel forType:SKCancelRecordingEarconType];
    
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"earcon_listening" ofType:@"wav"];  
    NSURL *fileUrl = [NSURL URLWithString:filePath];
        
    isRepeat = NO;
    isPartialAnswered = NO;
    isPreprocessed = NO;
    
    aqRecorder = new AQRecorder();
    aqRecorder->delegate_ = self;
    
    [self langSelector].selectedSegmentIndex = 0;
    
    operationQueue_ = [[NSOperationQueue alloc] init];
       
    //init XunFei
    NSString *initParam = [[NSString alloc] initWithFormat:@"server_url=%@,appid=%@",ENGINE_URL,APPID];
    iFlyRecognizeControl = [[IFlyRecognizeControl alloc]initWithOrigin:H_CONTROL_ORIGIN theInitParam:initParam];
    [self.view addSubview:iFlyRecognizeControl];
    [iFlyRecognizeControl setEngine:@"sms" theEngineParam:nil theGrammarID:nil];
    [iFlyRecognizeControl setSampleRate:16000];
    iFlyRecognizeControl.delegate = self;    
    [initParam release];                        
    
  
    NSString* compileDate = [NSString stringWithUTF8String:__DATE__];
    [NSString stringWithFormat:@"Built: %s %s", __DATE__, __TIME__];
    [self appendAnswer:[NSString stringWithFormat:@"Built: %s %s", __DATE__, __TIME__]];
    
    
    CN_ASR = ASR_NUANCE;
    
    
}

- (void)viewDidUnload
{
    [self setQuestionTextField:nil];
    [self setAskButton:nil];
    [self setLangSelector:nil];
    [self setRepeatButton:nil];
    [self setAnswerWebview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField { 
        
    if (theTextField == questionTextField) {
        [questionTextField resignFirstResponder]; 
        
        if(transactionState_ == TS_SPEAKING){
            [vocalizer cancel];
            transactionState_ = TS_IDLE;
            [askButton setTitle:@"Ask" forState:UIControlStateNormal];
        }
        else if(transactionState_ == TS_RECORDING){
            ;//do nothing
        }else{
            isRepeat = NO;
            isPartialAnswered = NO;
            isPreprocessed = NO;
            [self sendQuestionToQaEngine:[questionTextField text]];
        }
        
    }
    return YES;
}



#pragma mark -
#pragma mark SMS and Dial by voice


- (void)dialContactPhone:(NSString*)phoneNumber
{
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
        [[UIApplication sharedApplication] openURL:URL];
        [self resetAll];
        
}

- (void)dialPhone:(NSString*)phoneNumberInfo
{
    
    [self displayAnswer:phoneNumberInfo];
    return;
    
    NSArray *lines = [phoneNumberInfo componentsSeparatedByString:@"\r\n"];      
    //NSString* number;
    
    if([lines count]<1){
        NSLog(@"error dialPhone line # ");
    }
    
    if ([[lines objectAtIndex:0] hasPrefix:@"Phone:"]) {
        [self resetAll];
        [answerWebview loadHTMLString:[IAnswerUtilities makeHTMLStringHuge:phoneNumberInfo] baseURL:nil];
	}else{
		NSString* answer = [[lines objectAtIndex:0] substringFromIndex:7];
		[self resetAll];
		[self appendAnswer:answer];
	}
}


- (void)sendSMSbyVoice:recipientList:(NSArray *)recipients
{
    ; 
}

- (void)sendSMS:(NSArray*)bodyAndContact
{
    if ([bodyAndContact count] != 2) {
        NSLog(@"Error sendSMS #");
        return;
    }
    
    NSString* bodyOfMessage = [bodyAndContact objectAtIndex:0];
    NSArray* recipients = [bodyAndContact objectAtIndex:1];
    [self sendSMS:bodyOfMessage recipientList:recipients];
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;    
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    } 
    [self resetAll];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent") ;
    else 
        NSLog(@"Message failed") ; 
}


#pragma mark -
#pragma mark Local Helper Functions


+(BOOL)isExpired
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *expireDate = [dateFormatter dateFromString:@"2012-7-30"];
    NSDate *currentDate = [NSDate date];
    NSComparisonResult result = [currentDate compare:expireDate];
    if(result == NSOrderedDescending){
        return YES;
    }else{
        return NO;
    }
}


-(void)setAnswer:(NSString*) answerString
{
    answerText = answerString;
    [answerWebview loadHTMLString:[IAnswerUtilities makeHTMLString:answerString] baseURL:nil];
    
}

-(void)appendPreprocess:(NSString*) answerString
{
        [preprocessResult_ appendFormat:@"<p>%@<\p>",answerString];
        [answerWebview loadHTMLString:[IAnswerUtilities makeHTMLString:preprocessResult_] baseURL:nil];   
}

-(void)appendAnswer:(NSString*) answerString
{
    answerText = answerString;
    
    if(transactionState_ == TS_TK_NA){
        answerString = [NSString stringWithFormat:@"&nbsp %@", answerString];
    }
    
    
    if ([self langSelector].selectedSegmentIndex == 1 || [self langSelector].selectedSegmentIndex == 2 ) {
        answerString = [NSString stringWithFormat:@"%@ <br /> %@%@%@", answerString,
                     @"<a href=\"http://m160.cs.uwaterloo.ca/correction/test.jsp?type=4&input=", 
                     [IAnswerUtilities makeEscapeString:answerString], @"\">翻译成中文</a>"];
    }
    
    if (isPartialAnswered || isPreprocessed) {
        
        if(isPartialAnswered //&& [self langSelector].selectedSegmentIndex==0 
           && [answerString rangeOfString:@"Sorry,"].location != NSNotFound){
            return;
        }
        
        NSString* combined = [NSString stringWithFormat:@"%@ <p> %@<\p>", preprocessResult_, answerString];
        [answerWebview loadHTMLString:[IAnswerUtilities makeHTMLString:combined] baseURL:nil];
    }else {
        [answerWebview loadHTMLString:[IAnswerUtilities makeHTMLString:answerString] baseURL:nil];
    }
}

-(void)resetAll
{
    [vocalizer cancel];
    [self setAnswer:@""];
    [operationQueue_ cancelAllOperations];
    [askButton setTitle:@"Ask" forState:UIControlStateNormal];
    transactionState_ = TS_IDLE;
}

-(void)resetBackground
{
    [vocalizer cancel];
    [operationQueue_ cancelAllOperations];
    [askButton setTitle:@"Ask" forState:UIControlStateNormal];
    transactionState_ = TS_IDLE;
}

-(BOOL)cancelAll
{    
    if(transactionState_ == TS_SPEAKING){
        [vocalizer cancel];
        [askButton setTitle:@"Ask" forState:UIControlStateNormal];
    }else if(transactionState_ == TS_RECORDING){
        ;//do nothing
    }else if(transactionState_ == TS_PROCESSING){
        ;
    }else if(transactionState_ == TS_QUERYING){
        [self resetBackground];
    }else if(aqRecorder->IsRunning()){
        aqRecorder->StopRecord();
    }else if(transactionState_ == TS_IDLE){
        [self resetBackground];
        //nothing to cancel
        return NO;
    }
    
    //canceled something
    //why not
    [self resetBackground];
    return YES;
}

-(void)showRecordingView
{
    //show recording alert view
    [self.view addSubview:recordingView];
    recordingView.backgroundColor = [UIColor clearColor];
    recordingView.center = self.view.superview.center;
    CALayer *viewLayer = self.recordingView.layer;
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.35555555;
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:0.6],
                        [NSNumber numberWithFloat:1.1],
                        [NSNumber numberWithFloat:.9],
                        [NSNumber numberWithFloat:1],
                        nil];
    animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:0.6],
                          [NSNumber numberWithFloat:0.8],
                          [NSNumber numberWithFloat:1.0], 
                          nil];    
    [viewLayer addAnimation:animation forKey:@"transform.scale"];
}

-(void)fadeoutRecordingView
{
    //fade out
    CALayer *viewLayer = self.recordingView.layer;
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.35;
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:1.0],
                        [NSNumber numberWithFloat:0.0],
                        nil];
    animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:0.35],
                          nil];    
    animation.delegate = self;
    [viewLayer addAnimation:animation forKey:@"alpha"];
    [self.recordingView removeFromSuperview];

}

-(void)startRecord
{
        
    [repeatButton setHidden:YES];
    
    if(langSelector.selectedSegmentIndex == 0){ //use google speech
        
        [self showRecordingView];
        aqRecorder->StartRecord(); 
        NSLog(@"%@",@"AQR start recording");
        [askButton setTitle:@"Finish" forState:UIControlStateNormal];
        
    }else{ //use Xunfei
            
        switch (CN_ASR) {
            case ASR_NUANCE:
                if(voiceSearch)
                    [voiceSearch release];
                
                transactionState_ = TS_RECORDING;
                voiceSearch = [[SKRecognizer alloc] initWithType:SKDictationRecognizerType
                                                       detection:SKLongEndOfSpeechDetection
                                                        language:@"cn_ma" 
                                                        delegate:self];
                break;
                
            default:
                if([iFlyRecognizeControl start]) {
                    [questionTextField setText:@""];
                } else {
                    [questionTextField setText:@"Xun Fei fails to load."];
                }  
                break;
        }
            
                                                   
    }
    
}



- (IBAction)clickRepeat:(id)sender {
    
    NSLog(@"clickRepeat");
    NSLog(@"lastQuery:%@", lastQuery);
    
    isRepeat = YES;
    [self cancelAll];
    [self startRecord];
    [repeatButton setHidden:YES];
}


-(IBAction)stopRec:(id)sender{
    [self cancelAll];
}

// Entrance Function
- (IBAction)findAnswer:(id)sender {
    
    if (![self cancelAll]){
        isRepeat = NO;
        [self resetAll];
        [self startRecord];
    }    
}

- (void)sendQuestionToQaEngine:(NSString *)question
{        
    [self sendQuestionToQaEngine:question withEngine:[langSelector selectedSegmentIndex]];
}

- (void)sendQuestionToQaEngine:(NSString *)question withEngine:(int)engineIndex
{
    [self setQuntaAnswer:nil];
    isPartialAnswered = NO;
    isPreprocessed = NO;
    [operationQueue_ cancelAllOperations];
    
    if(preprocessResult_ != nil){
        [preprocessResult_ release], preprocessResult_ = nil;
    }
    preprocessResult_ = [[NSMutableString alloc] init];
    
    [askButton setTitle:@"Cancel" forState:UIControlStateNormal];
    transactionState_ = TS_QUERYING;
    
    
    
    AnswerQueryOperation* aQueryOperation = [[AnswerQueryOperation alloc] initWithFineQuesion:question
                                                                                       target:self 
                                                                                  engineIndex:engineIndex];
    [operationQueue_ addOperation:aQueryOperation];
    [aQueryOperation release];
}

- (void)speakAnswerText
{
    NSString *langCode ;
    switch (langSelector.selectedSegmentIndex) {
        case 0:
        case 2:
            langCode = @"en_US";
            break;
        case 1:
            langCode = @"zh_CN";
            break;
        default:
            langCode = @"en_US";
            break;
    } 
    
    [self speakAnswerText:langCode];
}
 
- (void)speakAnswerText:(NSString*)languageCode
{
    if(transactionState_ != TS_SPEAKING){
                
        if([answerText length] == 0){
            return;
        }
        
        if([answerText rangeOfString:@"Sorry, "].location != NSNotFound){
            [askButton setTitle:@"Ask" forState:UIControlStateNormal];
            return;
        }
        
        if (lastSpeakedText_ == nil) {
            lastSpeakedText_ = [answerText retain];
        }else if([lastSpeakedText_ isEqualToString:answerText]){
            [self resetBackground];
            return;
        }else{
            [lastSpeakedText_ release], lastSpeakedText_ = nil;
            lastSpeakedText_ = [answerText retain];
        }
        
        transactionState_ = TS_SPEAKING;
        
        if(vocalizer)
            [vocalizer autorelease];
        
        vocalizer = [[SKVocalizer alloc] initWithLanguage:languageCode delegate:self]; 
		
        
        NSString* readableText = [answerText stringByReplacingOccurrencesOfString:@"<br/>" withString:@"."];
		// Speaks the string text
        [vocalizer speakString:readableText];
        [askButton setTitle:@"Stop" forState:UIControlStateNormal];
		
    }
}

# pragma mark AQRecorder delegate method:
- (void)recordQueueStopped:(NSNotification *)note
{
    [self fadeoutRecordingView];
       
    NSLog(@"AQR stoped");
    [self setAnswer:@"Querying ..."];
    [askButton setTitle:@"Cancel" forState:UIControlStateNormal];
    transactionState_ = TS_QUERYING;
        
    [operationQueue_ cancelAllOperations];
    [self setQuntaAnswer:nil];
    isPartialAnswered = NO;
    isPreprocessed = NO;
    if(preprocessResult_ != nil){
        [preprocessResult_ release], preprocessResult_ = nil;
    }
    preprocessResult_ = [[NSMutableString alloc] init];
    
    AnswerQueryOperation* aQueryOperation;
    if(isRepeat){
        aQueryOperation = [[AnswerQueryOperation alloc] initWithAudioAndRepeatQuery:[aqRecorder->speexEncoder_ encodedAudio_] 
                                                                        repeatQuery:lastQuery
                                                                             target:self 
                                                                        engineIndex:[langSelector selectedSegmentIndex]]; 
    }else{
        aQueryOperation = [[AnswerQueryOperation alloc] initWithAudio:[aqRecorder->speexEncoder_ encodedAudio_] 
                                                                                 target:self 
                                                                            engineIndex:[langSelector selectedSegmentIndex]];
    }
    [operationQueue_ addOperation:aQueryOperation];
    [aQueryOperation release];
}


#pragma mark AnswerQueryOperation delegate methods:


-(void) displayPersonPhonePicker:(NSArray*)people
{
    ABRecordRef person = (ABRecordRef)[people objectAtIndex:0];
    ABPersonViewController *picker = [[[ABPersonViewController alloc] init] autorelease];
    picker.personViewDelegate = self;
    picker.displayedPerson = person;
    // Allow users to edit the person’s information
    picker.allowsEditing = YES;
    [self.navigationController pushViewController:picker animated:YES];
}

-(void) operationTimeOut
{
    if (transactionState_ == TS_QUERYING) {
        transactionState_ = TS_TK_NA;;
        if(quntaAnswer!=nil){
            [self displayAnswer:quntaAnswer];
        }else{
            [self resetAll];
        }
    }
}

-(void)extractAnswerFromHTMLAndJS:(NSArray*)htmlAndJs
{

    if ([htmlAndJs count] != 2) {
        NSLog(@"Error extractAnswerFromHTMLAndJS #");
        return;
    }
    
    NSString* htmlString = [htmlAndJs objectAtIndex:0];
    NSString* jsString = [htmlAndJs objectAtIndex:1];
    
    javaScriptString_ = jsString;
    
    if (webViewAnswerExtractor!=nil) {
        [webViewAnswerExtractor release], webViewAnswerExtractor=nil;
    }
    webViewAnswerExtractor = [[UIWebView alloc] init];
    [webViewAnswerExtractor setDelegate:self];
    [webViewAnswerExtractor loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.evi.com"]];
    //NSLog(htmlString);
    //transactionState_ = TS_IDLE;
    return;
}

-(void)displayAnswerWebview:(NSString*)html
{
    if([answerText rangeOfString:@"<font"].location == NSNotFound){
        html = [IAnswerUtilities makeHTMLString:html];
    }
    
    [self resetBackground];    
    [answerWebview loadHTMLString:html baseURL:nil];
}

-(void)displayAnswer:(NSString*)plainText
{
    

    [self appendAnswer:plainText];
    
    if([answerText rangeOfString:@"<p>"].location == NSNotFound
       && [answerText rangeOfString:@"</a>"].location == NSNotFound
       && [answerText rangeOfString:@"http://"].location == NSNotFound){
        [self speakAnswerText];
    }else{
        [self resetBackground];
    }
}

-(void)setQuestionText:(NSString*) qText
{
    [[self questionTextField] setText:qText];
    
    if ([[self langSelector] selectedSegmentIndex] == 0) {
        [repeatButton setHidden:NO];
    }
}

-(void)setPartialAnswer:(NSString*) result
{
    isPartialAnswered = YES;
    [self appendPreprocess:result];
}

-(void)setQuestionPreprocessResult:(NSString*) result
{
    isPreprocessed = YES;
    [self appendPreprocess:result];
}

-(void)queryCanceled
{    
    [self resetAll];
}
   
-(void)setTKRlt:(NSString*)answer
{
    if(!answer){
        if(transactionState_ != TS_SPEAKING){
            transactionState_ = TS_TK_NA;
            if (quntaAnswer!=nil) { 
                [self displayAnswer: quntaAnswer ];
            }
        }
    }else{
        [self appendAnswer:answer];
        if(transactionState_ != TS_SPEAKING){
            //transactionState_ = TS_IDLE;
            [self speakAnswerText:@"en_US"];
        }
    }
}

-(void)setQuntaRlt:(NSString*)answer
{
    [self setQuntaAnswer:answer];
    if(transactionState_ == TS_TK_NA){ 
        [self displayAnswer:answer];
    }
}


#pragma mark -
#pragma mark Dragon delegate methods:

- (void)vocalizer:(SKVocalizer *)vocalizer willBeginSpeakingString:(NSString *)text {    
    transactionState_ = TS_SPEAKING;
    [askButton setTitle:@"Stop" forState:UIControlStateNormal];
}

- (void)vocalizer:(SKVocalizer *)vocalizer willSpeakTextAtCharacter:(NSUInteger)index ofString:(NSString *)text {
}

- (void)vocalizer:(SKVocalizer *)vocalizer didFinishSpeakingString:(NSString *)text withError:(NSError *)error {
    [self resetBackground];
}


- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    [self showRecordingView];
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    [self fadeoutRecordingView];
}



- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results
{
    NSLog(@"Got results.");
    transactionState_ = TS_IDLE;
    
    int numOfResults = [results.results count]; 
    if (numOfResults <= 0) {
        return;
    }
    
    NSString *qString = [results firstResult];
    [self setQuestionText:qString];
    
    NSString* cleanString = [qString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if([cleanString length]==0){
        //
	}else {
        [self sendQuestionToQaEngine:cleanString];
	}
    
    
    if (results.suggestion) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Suggestion"
                                                        message:results.suggestion
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];        
        [alert show];
        [alert release];
        
    }
    if (voiceSearch) {
        [voiceSearch release];       
    }
	voiceSearch = nil;
    
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    NSLog(@"Got error.");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];        
    [alert show];
    [alert release];
    if (suggestion) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Suggestion"
                                                        message:suggestion
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];        
        [alert show];
        [alert release];
        
    }
    
    if(voiceSearch)
        [voiceSearch release];
	voiceSearch = nil;
    transactionState_ = TS_IDLE;
}


#pragma mark -
#pragma mark web view delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
        
    NSString *extractedAnwser = [webView stringByEvaluatingJavaScriptFromString:javaScriptString_];
    
    if (extractedAnwser == nil ) {
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No Answer",@"No Answer")
                                   message:@"No answer found."
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }

    NSString *isNoAnwser = [webView stringByEvaluatingJavaScriptFromString:@"document.querySelector('div.tk_no_answer, div.tk_not_answered, div.tk_not_understood').textContent"];
    
    //Got answer text
    NSString *whiteTrimmedAnwser =[extractedAnwser stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *trimmedAnwser = [whiteTrimmedAnwser stringByReplacingOccurrencesOfString:@"see the full page" withString:@""];
    
    trimmedAnwser = [IAnswerUtilities filterErrorCharacters:trimmedAnwser];
    
    // for laoma
    NSString *sorryString = @"很抱歉";
    if ([whiteTrimmedAnwser length]>[sorryString length]) 
    if([[whiteTrimmedAnwser substringToIndex:[sorryString length]] isEqualToString:sorryString]){
        trimmedAnwser = @"很抱歉, 目前还不能理解您的查询。";
    }
    
    /// XXX not used anymore !!!
    if([isNoAnwser length]!=0){
         if(transactionState_ != TS_SPEAKING){
             transactionState_ = TS_TK_NA;
             if (quntaAnswer!=nil) { 
                [self displayAnswer: quntaAnswer ];
            }
        }
    }else if([trimmedAnwser length]==0){
    }else{
        [self appendAnswer:trimmedAnwser];
        if(transactionState_ != TS_SPEAKING){
            [self speakAnswerText:@"en_US"];
        }
    }
}

#pragma mark -
#pragma mark XunFei delegate
//  recognize ending.
- (void)onRecognizeEnd:(IFlyRecognizeControl *)FlyRecognizeControl theError:(int)error
{
   
    NSLog(@"getUpflow:%d,getDownflow:%d",[FlyRecognizeControl getUpflow],[FlyRecognizeControl getDownflow]);
    
    NSString* cleanString = [[questionTextField text] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if([cleanString length]==0){
        //
	}else {
        [self sendQuestionToQaEngine:cleanString];
	}
}

- (void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
{

    NSMutableString* questionStringBuf = [NSMutableString stringWithString:[questionTextField text]];
    [questionStringBuf appendString:[[resultArray objectAtIndex:0] objectForKey:@"NAME"]];
    
    
    [[self questionTextField] setText:[questionStringBuf copy]];
}


@end
