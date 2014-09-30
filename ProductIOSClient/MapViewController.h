//
//  MapViewController.h
//  ProductIOSClient
//
//  Created by Shao Wei on 7/3/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationAnnotation.h"

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) LocationAnnotation *annotation;

@end