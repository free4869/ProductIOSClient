//
//  AnswerQueryOperation.h
//  iAnswer
//
//  Created by Di Wang on 11-09-02.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CoreLocation.h>

#import "HTMLNode.h"
#import "HTMLParser.h"

@interface AnswerQueryOperation : NSOperation{
    //inputs 
    NSString* questionCorrectQuery;
    NSString* fineQuestion_;
    NSString* repeatQuery_;
    NSData *speexData_;
    id delegate_; 
    enum {TRUEKNOWLEDGE, YAHOOANSWER, QUANTA, LAOMA, QANSWERS, TRANSLATION, WATANSWER} qaEngine;
    int qaEngineIndex;
    enum {QUERYTEXT, AUDIOINPUT, FINETEXT, REPEAT} operationMode_;
    NSMutableData* respondData;
    
    NSString* quantaRlt_;
}

@property(retain, nonatomic) NSString *questionCorrectQuery;
@property(retain, nonatomic) NSString *fineQuestion_;
@property(retain, nonatomic) NSString *repeatQuery_;
@property(retain, nonatomic) NSData *speexData_;
@property(retain, nonatomic) NSString* quantaRlt_;

- (id)initWithQuestionCorrectQuery:(NSString*) aQuestionCorrectQuery target:(id)target engineIndex:(int)index;
- (id)initWithAudio:(NSData*) speexData target:(id)target engineIndex:(int)index;
- (id)initWithFineQuesion:(NSString*) question target:(id)target engineIndex:(int)index;
- (id)initWithAudioAndRepeatQuery:(NSData*) speexData repeatQuery:(NSString*) repeatQuery target:(id)target engineIndex:(int)index;

-(void)queryQuanta:(NSString*) question;
-(void)queryQuantaPhoneNumber:(NSString*) question;
-(BOOL)verticalAnswering:(NSString*) question;
-(NSString*)queryLaoMa:(NSString*) question;
-(NSString*)queryQAnswer:(NSString *)question;
-(NSString*)queryEnglishCQA:(NSString*) question;
-(NSString*)queryChineseVertical:(NSString*) question;
-(NSString*)queryLocalTrueK:(NSString*) question;

+(CLLocation*)getCurrentLocation;
+(NSString*)filterQAnswer:(NSString*) answer;

-(BOOL)processCall:(NSString*)questionRlt;
-(NSString*)queryVerticalAnswer:(NSString*) question isPhoneSearch:(int)phoneSearch;

+(NSString*)queryWatAnswer:(NSString*) question;
+(NSString*)googleTranslate:(NSString*)input;
+(NSString*)queryGoogleCalc:(NSString*) question;
-(NSString*)rewriteTranslateResult:(NSString*)input;

@end
