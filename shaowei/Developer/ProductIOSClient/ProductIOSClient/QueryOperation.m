//
//  QueryOperation.m
//  ProductIOSClient
//
//  Created by Shao Wei on 6/29/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "QueryOperation.h"

@implementation QueryOperation

@synthesize delegate = _delegate;
@synthesize question = _question;


- (id)initWithQuestion:(NSString *)question target:(id)target
{
    self = [super init];
    if (self) {
        self.question = question;
        self.delegate = target;
    }
    
    return self;
}

- (BOOL)isSuccess:(ProductResponse *)response
{
    return response != nil && response.status != nil && [response.status.code isEqualToString:@"Success"];
}


- (void)main
{
    ProductRequest_Builder *productReqBuilder = [[ProductRequest_Builder alloc] init];
    [productReqBuilder setQuestion:self.question];
    Property *userid = [[[[Property builder] setKey:@"USER_ID"] setValue:@"dc2305"] build];
    Property *platform = [[[[Property builder] setKey:@"PLATFORM"] setValue:@"Iphone"] build];
    Property *language = [[[[Property builder] setKey:@"LANGUAGE"] setValue:@"chinese"] build];
    Property *product = [[[[Property builder] setKey:@"PRODUCT"] setValue:@"caijia"] build];
    [productReqBuilder addProperties:userid];
    [productReqBuilder addProperties:platform];
    [productReqBuilder addProperties:language];
    [productReqBuilder addProperties:product];
    
    ProductRequest *productReq = [productReqBuilder build];
    
    NSData *reqData = [productReq data];
    NSString *queryUrl = @"http://m160.cs.uwaterloo.ca/service/rsvp/answer";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:queryUrl]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"text/html; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:reqData];
    [request setValue:[NSString stringWithFormat:@"%i",reqData.length] forHTTPHeaderField:@"Content-Length"];
    [request setTimeoutInterval:10];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];    
    if (!responseData)
    {
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(processTimeoutException) withObject:nil waitUntilDone:YES];
        return;
    }
    ProductResponse *productRes = [ProductResponse parseFromData:responseData];
    NSLog(@"%@", productRes.answer);
    if ([self isSuccess:productRes])
    {
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(processMessage:) withObject:productRes.answer waitUntilDone:YES];
    }
    else
    {
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(processException) withObject:nil waitUntilDone:YES];
    }
}
@end
