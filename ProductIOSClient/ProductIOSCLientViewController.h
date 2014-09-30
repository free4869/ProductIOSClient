//
//  ProductIOSCLientViewController.h
//  ProductIOSClient
//
//  Created by Shao Wei on 6/28/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ProductCell.h"
#import "GDataXMLNode.h"
#import "QueryOperation.h"
#import "WBQueryOperation.h"
#import "MapViewController.h"
#import "BMapViewController.h"
#import "ProductMap.h"
#import "LocationAnnotation.h"
#import "iflyMSC.framework/Headers/IFlySpeechRecognizer.h"
#import "iflyMSC.framework/Headers/IFlySpeechSynthesizer.h"


@interface ProductIOSCLientViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, IFlySpeechRecognizerDelegate, IFlySpeechSynthesizerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *chatViewTable;
@property (strong, nonatomic) IBOutlet UITextField *responseTextField;
@property (strong, nonatomic) NSMutableArray *chatArray;
@property (strong, nonatomic) NSMutableString *broadcastMessage;
@property (strong, nonatomic) NSMutableString *messageStringBuf;
@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (strong, nonatomic) MapViewController *mvController;
@property (strong, nonatomic) BMapViewController *bmvController;
@property (strong, nonatomic) UIButton *recordView;
@property (strong, nonatomic) UIView *voiceRecorderView;
@property (strong, nonatomic) UIAlertView *waitingAlertView;
@property (strong, nonatomic) UITabBar *bottomTabBar;
@property (nonatomic) BOOL isQueryCanceled;

@property (strong, nonatomic) IFlySpeechRecognizer *iflyRecognizer;
@property (strong, nonatomic) IFlySpeechSynthesizer *iflySynthesizer;

@end
