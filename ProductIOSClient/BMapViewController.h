//
//  BMapViewController.h
//  ProductIOSClient
//
//  Created by Shao Wei on 9/6/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface BMapViewController : UIViewController <BMKMapViewDelegate>

@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKPointAnnotation *annotation;
@property (strong, nonatomic) UIImageView *bubbleView;

@end
