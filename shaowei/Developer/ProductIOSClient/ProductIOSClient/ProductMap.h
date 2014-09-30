//
//  ProductMap.h
//  ProductIOSClient
//
//  Created by Shao Wei on 7/19/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductMap : NSObject

@property (strong, nonatomic) NSDictionary *myProductMap;

+ (void)init;
+ (NSString *)getProductImageName:(NSString *)product;

@end
