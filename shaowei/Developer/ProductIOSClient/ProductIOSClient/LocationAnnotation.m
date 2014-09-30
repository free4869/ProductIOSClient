//
//  LocationAnnotation.m
//  ProductIOSClient
//
//  Created by Shao Wei on 7/2/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "LocationAnnotation.h"

@implementation LocationAnnotation

@synthesize marketInfo = _marketInfo;

+ (LocationAnnotation *)annotationForLocation:(NSDictionary *)marketInfo
{
    LocationAnnotation *annotation = [[LocationAnnotation alloc] init];
    annotation.marketInfo = marketInfo;
    return annotation;
}

- (NSString *)title
{
    return [self.marketInfo objectForKey:@"name"];
    NSLog(@"1111"); 
}

- (NSString *)subtitle
{
    return [self.marketInfo objectForKey:@"address"];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.marketInfo objectForKey:@"lat"] doubleValue];
    coordinate.longitude = [[self.marketInfo objectForKey:@"lng"] doubleValue];
    return coordinate;
}

@end
