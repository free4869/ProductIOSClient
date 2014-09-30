//
//  LocationAnnotation.h
//  ProductIOSClient
//
//  Created by Shao Wei on 7/2/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationAnnotation : NSObject <MKAnnotation>
@property (strong, nonatomic) NSDictionary *marketInfo;

+ (LocationAnnotation *)annotationForLocation:(NSDictionary *)marketInfo;
@end
