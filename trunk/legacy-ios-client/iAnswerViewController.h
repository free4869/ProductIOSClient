//
//  iAnswerViewController.h
//  iAnswer
//
//  Created by Di Wang on 11-09-08.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>

#import <SpeechKit/SpeechKit.h>
#import "AQRecorder.h"
#import <AVFoundation/AVFoundation.h>

#import "iFlyISR/IFlyRecognizeControl.h"
//#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface iAnswerViewController : UIViewController <
                                    UITextFieldDelegate
                                    , UIWebViewDelegate
                                    , SKVocalizerDelegate
                                    , SKRecognizerDelegate
                                    , AQRecorderDelegate
                                    , IFlyRecognizeControlDelegate
                                    , MFMessageComposeViewControllerDelegate
                                    , ABPersonViewControllerDelegate
                                    //, CLLocationManagerDelegate
                                    >
{    
    
    // UI components 
    UITextField *questionTextField;
    UIButton *askButton; 
    UIButton *repeatButton;
    UIView  *recordingView;
    
    // Voice components
    SKRecognizer *voiceSearch;
    SKVocalizer *vocalizer;
    AQRecorder* aqRecorder;
    
    // XunFei
    IFlyRecognizeControl    *iFlyRecognizeControl;
    
    NSString* lastSpeakedText_;
    NSString* lastQuery;
    
    enum {
        TS_IDLE,
        TS_INITIAL,
        TS_RECORDING,
        TS_PROCESSING,
        TS_SPEAKING,
        TS_QUERYING,
        TS_PARTIAL_ANWERED,
        TS_TK_NA,
    } transactionState_;
    
    enum {
        ASR_XUNFEI, 
        ASR_GOOGLE,
        ASR_NUANCE,
    } EN_ASR_, CN_ASR;
    
    BOOL isRepeat;
    BOOL isPartialAnswered;
    BOOL isPreprocessed; 
    
    UIWebView *webViewAnswerExtractor;
    NSString* javaScriptString_;
    
    UISegmentedControl *langSelector;
    
    NSOperationQueue *operationQueue_;
    
    NSString* answerText;
    NSMutableString* preprocessResult_;
    
    NSString* quntaAnswer;
    
}

@property (nonatomic, retain) UIWebView *webViewAnswerExtractor;

@property (retain, nonatomic) IBOutlet UIWebView *answerWebview;
@property (nonatomic, retain) IBOutlet UISegmentedControl *langSelector;
@property (nonatomic, retain) IBOutlet UITextField *questionTextField;
@property (nonatomic, retain) IBOutlet UIButton *askButton;
@property (nonatomic, retain) IBOutlet UIButton *repeatButton;
@property (nonatomic, retain) IBOutlet UIView  *recordingView;

@property (nonatomic, retain) NSString* lastQuery; 
@property (retain, nonatomic) NSString* quntaAnswer;

- (IBAction)clickRepeat:(id)sender;
-(IBAction)findAnswer:(id)sender;
-(IBAction)stopRec:(id)sender; //in recording alert view

-(void)resetAll;

-(void)showRecordingView;
-(void)fadeoutRecordingView;
- (void)speakAnswerText;
- (void)speakAnswerText:(NSString*)languageCode;

- (void)sendQuestionToQaEngine:(NSString*)question;
- (void)sendQuestionToQaEngine:(NSString *)question withEngine:(int)engineIndex;

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients;
- (void)dialPhone:(NSString*)phoneNumberInfo;
- (void)dialContactPhone:(NSString*)phoneNumber;

-(void)setPartialAnswer:(NSString*) result;
-(void)setTKRlt:(NSString*)answer;
-(void)setQuntaRlt:(NSString*)answer;
-(void)startTimeOut;
-(void)displayAnswer:(NSString*)plainText;
-(void)displayAnswerWebview:(NSString*)html;

// helper
+(BOOL)isExpired;
-(void)appendAnswer:(NSString*) answerString;
-(void)setQuestionText:(NSString*) qText;
-(void)queryCanceled;
- (void)recordQueueStopped:(NSNotification *)note;
-(void)extractAnswerFromHTMLAndJS:(NSArray*)htmlAndJs;



@end
