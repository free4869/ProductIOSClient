//
//  ProductIOSCLientAppDelegate.h
//  ProductIOSClient
//
//  Created by Shao Wei on 6/28/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface ProductIOSCLientAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BMKMapManager *mapManager;

@end
