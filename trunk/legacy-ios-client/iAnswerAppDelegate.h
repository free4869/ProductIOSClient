//
//  iAnswerAppDelegate.h
//  iAnswer
//
//  Created by Di Wang on 11-09-08.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iAnswerViewController;

@interface iAnswerAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet iAnswerViewController *viewController;

@end
