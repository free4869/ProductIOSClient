//
//  QueryOperation.h
//  ProductIOSClient
//
//  Created by Shao Wei on 6/29/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductRequestType.pb.h"


@interface QueryOperation : NSOperation

@property (nonatomic) id delegate;
@property (nonatomic, strong) NSString *question;

- (id)initWithQuestion:(NSString *)question target:(id)target;

@end
