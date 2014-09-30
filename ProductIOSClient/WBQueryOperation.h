//
//  WBQueryOperation.h
//  ProductIOSClient
//
//  Created by Shao Wei on 8/25/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface WBQueryOperation : NSOperation

@property (nonatomic) id delegate;
@property (nonatomic, strong) NSString *question;

- (id)initWithQuestion:(NSString *)question target:(id)target;

@end
