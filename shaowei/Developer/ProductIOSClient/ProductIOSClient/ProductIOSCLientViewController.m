//
//  ProductIOSCLientViewController.m
//  ProductIOSClient
//
//  Created by Shao Wei on 6/28/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "ProductIOSCLientViewController.h"


#define MAX_DIALOG_WIDTH    270
#define FONT_HEIGHT         10
#define APPID @"4e439878"
//#define APPID @"51d4400a"
#define BMAPKEY @"2d343f9c0c905579e5f5c9ada10b2b5c"
#define ENGINE_URL @"http://dev.voicecloud.cn/index.htm"
#define H_CONTROL_ORIGIN CGPointMake(20, 70)



@interface ProductIOSCLientViewController ()

@property (nonatomic, strong) NSMutableArray *expandIndex;
@property (nonatomic, strong) NSMutableArray *expandMapIndex;
@property (nonatomic, strong) UIImageView *voicePic;
@property (nonatomic, strong) UIImageView *volumePic;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic) BOOL isRequest;

@end

@implementation ProductIOSCLientViewController

@synthesize responseTextField = _responseTextField;
@synthesize chatViewTable = _chatViewTable;
@synthesize chatArray = _chatArray;
@synthesize isRequest = _isRequest;
@synthesize isQueryCanceled = _isQueryCanceled;
@synthesize expandIndex = _expandIndex;
@synthesize expandMapIndex = _expandMapIndex;
@synthesize broadcastMessage = _broadcastMessage;
@synthesize messageStringBuf = _messageStringBuf;
@synthesize operationQueue = _operationQueue;
@synthesize bottomTabBar = _bottomTabBar;
@synthesize mvController = _mvController;
@synthesize iflyRecognizer = _iflyRecognizer;
@synthesize iflySynthesizer = _iflySynthesizer;
@synthesize recordView = _recordView;
@synthesize voiceRecorderView = _voiceRecorderView;
@synthesize voicePic = _voicePic;
@synthesize volumePic = _volumePic;
@synthesize waitingAlertView = _waitingAlertView;
@synthesize sendButton = _sendButton;
@synthesize backButton = _backButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.broadcastMessage = [[NSMutableString alloc] init];
    self.chatViewTable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg.jpg"]];
    
    self.mvController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    
    //setup navigation bar
    [self setupNavigationBar];
    //setup tab bar
    [self setupTabBar];
    
    [self.chatViewTable setDataSource:self];
    [self.chatViewTable setDelegate:self];
    self.messageStringBuf = [[NSMutableString alloc] init];
    self.expandIndex = [[NSMutableArray alloc] init];
    self.expandMapIndex = [[NSMutableArray alloc] init];
    self.isRequest = YES;
    
	self.chatArray = [[NSMutableArray alloc] init];
    NSString *greetingMessage = [self getGreetingString];
    UIView *view = [self chatBubbleView:greetingMessage from:NO];
    [self.expandIndex addObject:[NSNumber numberWithBool:NO]];
    [self.expandMapIndex addObject:[NSNumber numberWithBool:NO]];
    [self.chatArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:view, @"view", greetingMessage, @"message", @"NO", @"isRequest", nil]];
    [self.expandIndex addObject:[NSNumber numberWithBool:YES]];
    [self.expandMapIndex addObject:[NSNumber numberWithBool:NO]];
    [self.chatArray addObject:[NSNumber numberWithBool:NO]];
    [ProductMap init];
    
    self.voiceRecorderView = [[UIView alloc] initWithFrame:CGRectMake(110, 180, 100, 140)];
    [self.voiceRecorderView setBackgroundColor:[UIColor colorWithRed:0.707 green:0.711 blue:0.707 alpha:0.6]];
    self.voicePic = [[UIImageView alloc] initWithFrame:CGRectMake(6, 8, 46, 130)];
    [self.voicePic setImage:[UIImage imageNamed:@"voice_rcd_hint.png"]];
    [self.voiceRecorderView addSubview:self.voicePic];
    self.volumePic = [[UIImageView alloc] initWithFrame:CGRectMake(60, 126, 36, 10)];
    [self.volumePic setImage:[UIImage imageNamed:@"amp1.png"]];
    [self.voiceRecorderView addSubview:self.volumePic];
    [self.view addSubview:self.voiceRecorderView];
    self.voiceRecorderView.hidden = YES;
    
    [self setupRecognizeView];
    [self setupSynthesizeView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)setupNavigationBar
{
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"btn_back_nomal.png"] forState:UIControlStateNormal];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"btn_back_pressed.png"] forState:UIControlStateHighlighted];
    [self.backButton.layer setCornerRadius:8];
    [self.backButton setBackgroundColor:[UIColor clearColor]];
    self.backButton.frame = CGRectMake(20, 40, 60, 60);
    [self.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendButton setBackgroundImage:[UIImage imageNamed:@"btn_search_nomal.png"] forState:UIControlStateNormal];
    [self.sendButton setBackgroundImage:[UIImage imageNamed:@"btn_search_pressed.png"] forState:UIControlStateHighlighted];
    [self.sendButton.layer setCornerRadius:8];
    [self.sendButton setBackgroundColor:[UIColor clearColor]];
    [self.sendButton addTarget:self action:@selector(displayTextView:) forControlEvents:UIControlEventTouchUpInside];
    self.sendButton.frame = CGRectMake(20, 40, 65, 60);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.responseTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 10, 235, 32)];
    self.responseTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.responseTextField.font = [UIFont systemFontOfSize:13];
    self.responseTextField.placeholder = @"请输入您的问题";
    self.responseTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *keyboard = [[UIImageView alloc] initWithFrame:CGRectMake(190, 0, 35, 32)];
    [keyboard setImage:[UIImage imageNamed:@"ic_search.png"]];
    [self.responseTextField addSubview:keyboard];
    [self.responseTextField setDelegate:self];
}

- (void)setupTabBar
{
    self.bottomTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 328, 320, 94)];
    UIImageView *bottomBarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_bar_bg.jpg"]];
    bottomBarView.frame = CGRectMake(0.0, 0.0, 320.0, 94.0);
    bottomBarView.contentMode = UIViewContentModeScaleToFill;
    [self.bottomTabBar addSubview:bottomBarView];
    [self.view addSubview:self.bottomTabBar];
    
    self.recordView = [[UIButton alloc]initWithFrame:CGRectMake(116, 3, 83, 83)];
    [self.recordView setBackgroundImage:[UIImage imageNamed:@"btn_mic_nomal.png"] forState:UIControlStateNormal];
    [self.recordView setBackgroundImage:[UIImage imageNamed:@"btn_mic_pressed.png"] forState:UIControlStateHighlighted];
    self.recordView.userInteractionEnabled = YES;
    [self.recordView addTarget:self action:@selector(recordClicked) forControlEvents:UIControlEventTouchDown];
    [self.recordView addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomTabBar addSubview:self.recordView];
}

- (void)setupRecognizeView
{
    NSString *initParam = [[NSString alloc] initWithFormat:@"appid=%@", APPID];
    
    self.iflyRecognizer = [IFlySpeechRecognizer createRecognizer: initParam delegate:self];
    self.iflyRecognizer.delegate = self;
}

- (void)setupSynthesizeView
{
    NSString *initParam = [[NSString alloc] initWithFormat:
						   @"appid=%@", APPID];
	self.iflySynthesizer = [IFlySpeechSynthesizer createWithParams:initParam delegate:self];
    self.iflySynthesizer.delegate = self;
    [self.iflySynthesizer setParameter:@"speed" value:@"50"];
    [self.iflySynthesizer setParameter:@"volume" value:@"50"];
    [self.iflySynthesizer setParameter:@"voice_name" value:@"xiaoyan"];
    [self.iflySynthesizer setParameter:@"sample_rate" value:@"8000"];
}

- (void)beginBroadcast:text
{
    [self.recordView setBackgroundImage:[UIImage imageNamed:@"btn_mic_stop.png"] forState:UIControlStateNormal];
    [self.recordView removeTarget:self action:NULL forControlEvents:UIControlEventTouchDown];
    [self.recordView removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [self.recordView addTarget:self action:@selector(stopBroadcast) forControlEvents:UIControlEventTouchUpInside];
    [self.iflySynthesizer startSpeaking:text];
}

- (void)stopBroadcast
{
    [self.iflySynthesizer stopSpeaking];
    [self.iflyRecognizer cancel];
    [self.recordView setBackgroundImage:[UIImage imageNamed:@"btn_mic_nomal.png"] forState:UIControlStateNormal];
    [self.recordView removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [self.recordView addTarget:self action:@selector(recordClicked) forControlEvents:UIControlEventTouchDown];
    [self.recordView addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpInside];
}   

- (void)recordClicked
{
    //[self.iflyRecognizer setParameter:@"domain" value:_ent];
    [self.iflyRecognizer setParameter:@"sample_rate" value:@"16000"];
    [self.iflyRecognizer setParameter:@"plain_result" value:@"0"];
    self.voiceRecorderView.hidden = NO;
    [self.iflyRecognizer startListening];
}

- (void)stopRecord
{
    [self.iflyRecognizer stopListening];
}


- (void)sendMessage:(NSString *)message
{
    if (![message isEqualToString:@""])
    {
        /*
        QueryOperation* aQueryOperation = [[QueryOperation alloc] initWithQuestion:message target:self];
        [self.operationQueue addOperation:aQueryOperation];
         */
        WBQueryOperation *aQueryOperation = [[WBQueryOperation alloc] initWithQuestion:message target:self];
        [self.operationQueue addOperation:aQueryOperation];
        
        self.isQueryCanceled = NO;
        UIView *view = [self chatBubbleView:message from:YES];    
        [self.expandIndex addObject:[NSNumber numberWithBool:NO]];
        [self.expandMapIndex addObject:[NSNumber numberWithBool:NO]];
        [self.chatArray addObject:[[NSDictionary alloc] initWithObjectsAndKeys:view, @"view", message, @"message", @"YES", @"isRequest", nil]];
        [self.chatViewTable reloadData];
        [self.chatViewTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] atScrollPosition: UITableViewScrollPositionBottom animated:YES];
        
        self.waitingAlertView = [[UIAlertView alloc]initWithTitle:@"请稍后..."
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:nil];
        [self.waitingAlertView show];
        UIActivityIndicatorView *activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activeView.center = CGPointMake(30, 26);
        [activeView startAnimating];
        [self.waitingAlertView addSubview:activeView];
    }
}

- (void)processMessage:(NSString *)message
{
    if (self.isQueryCanceled)
    {
        self.isQueryCanceled = NO;
        return;
    }
    else
    {
        NSMutableDictionary *productInfo = [NSMutableDictionary alloc];
        self.isRequest = NO;
        /*
         * process xml from m160
        NSMutableString *dataString = [NSMutableString stringWithString:message];
        [dataString replaceOccurrencesOfString:@"<br/>" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [dataString length])];
        [dataString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [dataString length])];
        [dataString replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [dataString length])];
        NSRange range;
        range = [dataString rangeOfString:@"<"];
        self.broadcastMessage = [[dataString substringToIndex:range.location] copy];
        dataString = [[dataString substringFromIndex:range.location] copy];
         */
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:message options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        GDataXMLElement *provinceElement = [[rootElement elementsForName:@"legalprovince"] objectAtIndex:0];
        GDataXMLElement *nameElement = [[rootElement elementsForName:@"legalproduct"] objectAtIndex:0];
        GDataXMLElement *dateElement = [[rootElement elementsForName:@"dates"] objectAtIndex:0];
        GDataXMLElement *errorElement = [[rootElement elementsForName:@"errorcode"] objectAtIndex:0];
        [self.broadcastMessage setString:@""];
        
        if ([[errorElement stringValue] isEqualToString:@"2"])
        {
            NSString *exceptionString = @"抱歉，目前只支持中国各省份农产品物价的查询，请您换种方式提问，或许我可以回答。";
            [self.broadcastMessage appendString:exceptionString];
            UIView *view = [self chatBubbleView:exceptionString from:NO];
            productInfo = [productInfo initWithObjectsAndKeys:exceptionString, @"message", view, @"view", @"NO", @"isRequest", nil];
        }
        else if ([[errorElement stringValue] isEqualToString:@"3"])
        {
            NSString *exceptionString = @"抱歉，没有查到相关结果";
            [self.broadcastMessage appendString:exceptionString];
            UIView *view = [self chatBubbleView:exceptionString from:NO];
            productInfo = [productInfo initWithObjectsAndKeys:exceptionString, @"message", view, @"view", @"NO", @"isRequest", nil];
        }
        else
        {
            GDataXMLElement *priceElement = [[rootElement elementsForName:@"prices"] objectAtIndex:0];
            GDataXMLElement *codeElement = [[priceElement elementsForName:@"code"] objectAtIndex:0];
            int codeNumber = [[codeElement stringValue] intValue];
            NSString *alertString1 = @"未能找到您所查询时间的产品,";
            NSString *alertString2 = @"未能找到您所查询的产品,";
            NSString *alertString3 = @"未能找到您所查询市场的产品,";
            NSString *alertString4 = @"未能找到你所查询省份的产品";
            if (codeNumber >= 8) {
                [self.broadcastMessage appendString:alertString4];
                codeNumber -= 8;
            }
            else if (codeNumber >= 4)
            {
                [self.broadcastMessage appendString:alertString3];
                codeNumber -= 4;
            }
            else if (codeNumber >= 2)
            {
                [self.broadcastMessage appendString:alertString2];
                codeNumber -= 2;
            }
            else if (codeNumber >= 1)
            {
                [self.broadcastMessage appendString:alertString1];
                codeNumber -= 1;
            }
            [self.broadcastMessage appendFormat:@"为您查询的是%@%@%@的价格", [dateElement stringValue], [provinceElement stringValue], [nameElement stringValue]];
            productInfo = [productInfo initWithObjectsAndKeys:[provinceElement stringValue], @"province", [nameElement stringValue], @"name", [dateElement stringValue], @"dates", [errorElement stringValue], @"errorcode", @"NO", @"isRequest", nil, @"price", nil];
            NSArray *marketElements = [priceElement elementsForName:@"market"];
            NSMutableArray *properties = [[NSMutableArray alloc]init];
            for (GDataXMLElement *market in marketElements)
            {
                NSString *name = [[market attributeForName:@"name"] stringValue];
                NSString *address = [[market attributeForName:@"address"] stringValue];
                NSString *latitude = [[market attributeForName:@"lat"] stringValue];
                NSString *longitude = [[market attributeForName:@"lng"] stringValue];
                NSString *date = [[market attributeForName:@"date"] stringValue];
                NSString *price = [market stringValue];
                
                NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", address, @"address", latitude, @"lat", longitude, @"lng", date, @"date", price, @"price", nil];
                [properties addObject:attributes];
            }
            [productInfo setObject:properties forKey:@"price"];
        }
        [self beginBroadcast:self.broadcastMessage];
        [self.expandIndex addObject:[NSNumber numberWithBool:YES]];
        [self.expandMapIndex addObject:[NSNumber numberWithBool:NO]];
        [self.chatArray addObject:productInfo];
        [self.chatViewTable reloadData];
        [self.chatViewTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] atScrollPosition: UITableViewScrollPositionBottom animated:YES];
        [self.waitingAlertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (void)processException
{
    if (self.isQueryCanceled)
    {
        self.isQueryCanceled = NO;
        return;
    }
    else
    {
        NSString *exceptionString = @"抱歉，本系统暂时只支持回答菜价问题，其他功能敬请期待！";
        UIView *view = [self chatBubbleView:exceptionString from:NO];
        NSDictionary *exceptionInfo = [[NSDictionary alloc] initWithObjectsAndKeys:exceptionString, @"message", view, @"view", @"NO", @"isRequest", @"-1", @"errorcode", nil];
        [self.expandIndex addObject:[NSNumber numberWithBool:NO]];
        [self.expandMapIndex addObject:[NSNumber numberWithBool:NO]];
        [self.chatArray addObject:exceptionInfo];
        [self.chatViewTable reloadData];
        [self.chatViewTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] atScrollPosition: UITableViewScrollPositionBottom animated:YES];
        
        [self beginBroadcast:exceptionString];
        [self.waitingAlertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (void)processTimeoutException
{
    if (self.isQueryCanceled)
    {
        self.isQueryCanceled = NO;
        return;
    }
    else
    {
        [self.waitingAlertView dismissWithClickedButtonIndex:0 animated:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"服务器繁忙,稍后请重试."
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
    }
}

- (void)displayTextView:(id)sender
{
    if ([self.navigationItem.leftBarButtonItem.customView isKindOfClass:[UIButton class]]) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.responseTextField];
        self.navigationItem.leftBarButtonItem = leftItem;
        [self.sendButton setBackgroundImage:[UIImage imageNamed:@"btn_cancel_nomal.png"] forState:UIControlStateNormal];
        [self.sendButton setBackgroundImage:[UIImage imageNamed:@"btn_cancel_pressed.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
        [self.sendButton setBackgroundImage:[UIImage imageNamed:@"btn_search_nomal.png"] forState:UIControlStateNormal];
        [self.sendButton setBackgroundImage:[UIImage imageNamed:@"btn_search_pressed.png"] forState:UIControlStateHighlighted];
    }
    
}

- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendButtonPressed:(id)sender
{
    [self stopBroadcast];
    NSString *currentMessage = self.responseTextField.text;
    [self sendMessage:currentMessage];
    
    self.responseTextField.text = @"";
    [_responseTextField resignFirstResponder];
}


- (NSString *)getGreetingString
{
    NSDate *time=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH"];
    NSString *currentHour=[dateformatter stringFromDate:time];
    if ([currentHour compare:@"12"] == NSOrderedAscending)
        return @"早上好!";
    else if ([currentHour compare:@"18"] == NSOrderedAscending)
        return @"下午好!";
    else
        return @"晚上好!";
}

- (UIView *)chatBubbleView:(NSString *)message from:(BOOL)isRequest
{
    UILabel *resultView = [self createMessageTextView:message];
    resultView.backgroundColor = [UIColor clearColor];
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (isRequest)
        cellView.frame = CGRectMake(272 - resultView.frame.size.width, 10,resultView.frame.size.width + 44, resultView.frame.size.height + 16);
    else
		cellView.frame = CGRectMake(4, 10, resultView.frame.size.width + 52,resultView.frame.size.height + 16);
    if (cellView.frame.size.height < 48)
        cellView.frame = CGRectMake(cellView.frame.origin.x, cellView.frame.origin.y, cellView.frame.size.width, 48);
    [cellView addSubview:resultView];
    cellView.layer.borderWidth = 1.5;
    cellView.layer.borderColor = [[UIColor colorWithRed:0.707 green:0.711 blue:0.707 alpha:1] CGColor];
    cellView.layer.cornerRadius = 8;
    cellView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGesture.minimumPressDuration = 1.0;
    [cellView addGestureRecognizer:longPressGesture];
    
    return cellView;
}


- (UILabel *)createMessageTextView:(NSString *)text
{
    UIFont *fon = [UIFont systemFontOfSize:13];
    CGSize labelSize = [text sizeWithFont:fon constrainedToSize:CGSizeMake(270, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    if (labelSize.height == 16)
        [textLabel setFrame: CGRectMake(20, 8, labelSize.width, labelSize.height + 16)];
    else
        [textLabel setFrame: CGRectMake(20, 8, labelSize.width, labelSize.height)];
    [textLabel setFont:fon];
    [textLabel setText:text];
    [textLabel setNumberOfLines:0];
    return textLabel;
}

- (void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.chatViewTable];
        NSIndexPath * indexPath = [self.chatViewTable indexPathForRowAtPoint:point];
        NSString *message = [[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"message"];
        self.responseTextField.text = message;
    }
}

- (void)expandButtonTapped: (UIControl *) button withEvent: (UIEvent *) event
{
    UITableView *tableView = self.chatViewTable;
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint: [[[event touchesForView: button] anyObject] locationInView: tableView]];
    if (indexPath == nil)
        return;
    
    // reset cell expanded state in array
	BOOL isExpanded = ![[self.expandIndex objectAtIndex:[indexPath row]] boolValue];
    NSNumber *expandedIndex = [NSNumber numberWithBool:isExpanded];
	[self.expandIndex replaceObjectAtIndex:[indexPath row] withObject:expandedIndex];
    
    [self.chatViewTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)expandMapButtonTapped: (UIControl *) button withEvent: (UIEvent *) event
{
    UITableView *tableView = self.chatViewTable;
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint: [[[event touchesForView: button] anyObject] locationInView: tableView]];
    NSLog(@"%i", [indexPath row]);
    if (indexPath == nil)
        return;
    
    // reset cell expanded state in array
	BOOL isExpanded = ![[self.expandMapIndex objectAtIndex:[indexPath row]] boolValue];
    NSNumber *expandedIndex = [NSNumber numberWithBool:isExpanded];
	[self.expandMapIndex replaceObjectAtIndex:[indexPath row] withObject:expandedIndex];
    
    [self.chatViewTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - UITableView dataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chatArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 1)
    {
        ProductCell *cell = (ProductCell*)[tableView dequeueReusableCellWithIdentifier:@"Product Cell"];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.borderView.layer.borderWidth = 1.5;
        cell.borderView.layer.borderColor = [[UIColor colorWithRed:0.707 green:0.711 blue:0.707 alpha:1] CGColor];
        cell.borderView.layer.cornerRadius = 8;
        cell.borderView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
        cell.parentTableView = self;
        
        NSString *buttonText = [NSString stringWithFormat:@"您可以试着问我以下问题:"];
        UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 6, 230, 45)];
        buttonLabel.text = buttonText;
        buttonLabel.font = [UIFont systemFontOfSize:13];
        buttonLabel.backgroundColor = [UIColor clearColor];
        NSArray *views = [cell.contentView subviews];
        for (id view in views)
        {
            if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIImageView class]])
                [view removeFromSuperview];
        }
        [cell.contentView addSubview:buttonLabel];
        
        [cell.expandButton setBackgroundColor:[UIColor clearColor]];
        [cell.expandButton setBackgroundImage:[[UIImage imageNamed:@"blank_title_normal.9.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)] forState:UIControlStateNormal];
        [cell.expandButton setBackgroundImage:[[UIImage imageNamed:@"blank_title_pressed.9.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) ] forState:UIControlStateSelected];
        cell.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 20, 20, 20)];
        if ([[self.expandIndex objectAtIndex:[indexPath row]] boolValue])
            [cell.arrowImageView setImage:[UIImage imageNamed:@"show_arrow_normal.png"]];
        else
            [cell.arrowImageView setImage:[UIImage imageNamed:@"hide_arrow_normal.png"]];
        
        [cell.contentView addSubview:cell.arrowImageView];
        [cell.subTableView setDataSource:cell];
        [cell.subTableView setDelegate:cell];
        [cell.expandButton addTarget:self action:@selector(expandButtonTapped:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        cell.subCellNumber = [indexPath row];
        cell.isExpanded = [[self.expandIndex objectAtIndex:[indexPath row]] boolValue];
        cell.isMapExpanded = [[self.expandMapIndex objectAtIndex:[indexPath row]] boolValue];
        
        [cell.subTableView reloadData];
        return cell;
    }
    else
    {
        if ([[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"isRequest"] isEqualToString:@"NO"] &&
            ([[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"errorcode"] isEqualToString:@"0"] ||
             [[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"errorcode"] isEqualToString:@"1"]))
        {
            ProductCell *cell = (ProductCell*)[tableView dequeueReusableCellWithIdentifier:@"Product Cell"];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            cell.borderView.layer.borderWidth = 1.5;
            cell.borderView.layer.borderColor = [[UIColor colorWithRed:0.707 green:0.711 blue:0.707 alpha:1] CGColor];
            cell.borderView.layer.cornerRadius = 8;
            cell.borderView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
            cell.parentTableView = self;
            NSDictionary *chatInfo = [self.chatArray objectAtIndex:[indexPath row]];
            NSString *buttonText = [NSString stringWithFormat:@"为您查询的是%@%@%@的价格:", [chatInfo objectForKey:@"dates"], [chatInfo objectForKey:@"province"], [chatInfo objectForKey:@"name"]];
            UILabel *buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 6, 230, 45)];
            buttonLabel.text = buttonText;
            buttonLabel.font = [UIFont systemFontOfSize:13];
            buttonLabel.lineBreakMode = NSLineBreakByClipping;
            [buttonLabel setNumberOfLines:2];
            buttonLabel.backgroundColor = [UIColor clearColor];
            NSArray *views = [cell.contentView subviews];
            for (id view in views)
            {
                if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIImageView class]])
                    [view removeFromSuperview];
            }
            [cell.contentView addSubview:buttonLabel];
                    
            [cell.expandButton setBackgroundColor:[UIColor clearColor]];
            [cell.expandButton setBackgroundImage:[[UIImage imageNamed:@"blank_title_normal.9.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)] forState:UIControlStateNormal];
            [cell.expandButton setBackgroundImage:[[UIImage imageNamed:@"blank_title_pressed.9.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30) ] forState:UIControlStateSelected];
            cell.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 20, 20, 20)];
            if ([[self.expandIndex objectAtIndex:[indexPath row]] boolValue])
                [cell.arrowImageView setImage:[UIImage imageNamed:@"show_arrow_normal.png"]];
            else
                [cell.arrowImageView setImage:[UIImage imageNamed:@"hide_arrow_normal.png"]];

            [cell.contentView addSubview:cell.arrowImageView];
            cell.subCellInfo = [chatInfo objectForKey:@"price"];
            
            [cell.subTableView setDataSource:cell];
            [cell.subTableView setDelegate:cell];
            [cell.expandButton addTarget:self action:@selector(expandButtonTapped:withEvent:) forControlEvents:UIControlEventTouchUpInside];
            cell.subCellNumber = [indexPath row];
            cell.productImageName = [ProductMap getProductImageName:[chatInfo objectForKey:@"name"]];
            cell.isExpanded = [[self.expandIndex objectAtIndex:[indexPath row]] boolValue];
            cell.isMapExpanded = [[self.expandMapIndex objectAtIndex:[indexPath row]] boolValue];
            
            [cell.subTableView reloadData];
            return cell;
        }
        else
        {
            static NSString *CellIdentifier = @"Request Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            NSDictionary *chatInfo = [self.chatArray objectAtIndex:[indexPath row]];
            UIView *chatView = [chatInfo objectForKey:@"view"];
            NSArray *views = [cell.contentView subviews];
            for(UIView* view in views)
            {
                [view removeFromSuperview];
            }
            [cell.contentView addSubview:chatView];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0)
        return 64;
    else if ([indexPath row] == 1)
    {
        BOOL isExpand = [[self.expandIndex objectAtIndex:[indexPath row]] boolValue];
        if (isExpand)
            return 4 * 40 + 67;
        else
            return 67;
    }
    else
    {
        if ([[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"isRequest"] isEqualToString:@"NO"] &&
            ([[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"errorcode"] isEqualToString:@"0"] ||
             [[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"errorcode"] isEqualToString:@"1"]))
        {
            int result = 67 + 52;
            BOOL isExpand = [[self.expandIndex objectAtIndex:[indexPath row]] boolValue];
            BOOL isMapExpand = [[self.expandMapIndex objectAtIndex:[indexPath row]] boolValue];
            if (isExpand)
                result += ([[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"price"] count]) * 100 + 70;
            if (isMapExpand)
                result += 190;
            return result;
        }
        else if ([[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"isRequest"] isEqualToString:@"YES"])
        {
            int viewHeight = ((UIView *)[[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"view"]).frame.size.height;
            return viewHeight + 20;
        }
        else
            return 68;
    }
}


#pragma mark - textfield delegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *currentMessage = textField.text;
    [self sendMessage:currentMessage];
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - alert view delegate method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.isQueryCanceled = YES;
    return;
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    
}

#pragma mark - keyboard delegate method

- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    //NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    //CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
}

#pragma mark - XunFei Recognizer delegate

- (void) onVolumeChanged: (int)volume
{
    if (volume <= 4)
    {
        [self.volumePic setFrame:CGRectMake(60, 126, 36, 10)];
        [self.volumePic setImage:[UIImage imageNamed:@"amp1.png"]];
    }
    else if (volume <= 8)
    {
        [self.volumePic setFrame:CGRectMake(60, 106, 36, 30)];
        [self.volumePic setImage:[UIImage imageNamed:@"amp2.png"]];
    }
    else if (volume <= 12)
    {
        [self.volumePic setFrame:CGRectMake(60, 86, 36, 50)];
        [self.volumePic setImage:[UIImage imageNamed:@"amp3.png"]];
    }
    else if (volume <= 16)
    {
        [self.volumePic setFrame:CGRectMake(60, 66, 36, 70)];
        [self.volumePic setImage:[UIImage imageNamed:@"amp4.png"]];
    }
    else if (volume <= 20)
    {
        [self.volumePic setFrame:CGRectMake(60, 48, 36, 88)];
        [self.volumePic setImage:[UIImage imageNamed:@"amp5.png"]];
    }
    else if (volume <= 24)
    {
        [self.volumePic setFrame:CGRectMake(60, 30, 36, 106)];
        [self.volumePic setImage:[UIImage imageNamed:@"amp6.png"]];
    }
    else
    {
        [self.volumePic setFrame:CGRectMake(60, 10, 36, 126)];
        [self.volumePic setImage:[UIImage imageNamed:@"amp7.png"]];
    }
}

- (void) onBeginOfSpeech
{
    
}

- (void) onEndOfSpeech
{
    
}

- (void) onError:(IFlySpeechError *) errorCode
{
    [self sendMessage:[self.responseTextField text]];
    self.responseTextField.text = @"";
    [_responseTextField resignFirstResponder];
    self.voiceRecorderView.hidden = YES;
}


- (void) onResults:(NSArray *) results
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    [self.responseTextField setText:[result copy]];
}

/*
- (void)onEnd:(IFlyRecognizerView *)iFlyRecognizerView theError:(IFlySpeechError *)error
{
    [self sendMessage:[self.responseTextField text]];
    self.responseTextField.text = @"";
    [_responseTextField resignFirstResponder];
}

- (void)onResult:(IFlyRecognizerView *)iFlyRecognizerView theResult:(NSArray *)resultArray
{
    NSDictionary *dic = [resultArray objectAtIndex:0];
    NSMutableString *questionStringBuf = [NSMutableString stringWithString:[self.responseTextField text]];
    for (NSString *key in dic)
    {
        [questionStringBuf appendString:key];
    }    
    
    [self.responseTextField setText:[questionStringBuf copy]];
}*/

#pragma mark - XunFei Synthesizer delegate

- (void) onSpeakBegin
{
    
}

- (void) onBufferProgress:(int) progress
{
    
}

- (void) onSpeakProgress:(int) progress
{
    
}

- (void) onSpeakPaused
{
    
}

- (void) onSpeakResumed
{
    
}

- (void) onCompleted:(IFlySpeechError*) error
{
    [self.recordView setBackgroundImage:[UIImage imageNamed:@"btn_mic_nomal.png"] forState:UIControlStateNormal];
    [self.recordView removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [self.recordView addTarget:self action:@selector(recordClicked) forControlEvents:UIControlEventTouchDown];
    [self.recordView addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpInside];
}

- (void) onSpeakCancel
{
    
}


@end
