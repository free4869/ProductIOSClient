//
//  WBQueryOperation.m
//  ProductIOSClient
//
//  Created by Shao Wei on 8/25/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "WBQueryOperation.h"

@implementation WBQueryOperation

- (id)initWithQuestion:(NSString *)question target:(id)target
{
    self = [super init];
    if (self) {
        self.question = question;
        self.delegate = target;
    }
    
    return self;
}

- (void)main
{
    //NSString *queryFormat = @"http://54.245.101.9:19200/cn-vertical/answer/question=%@";
    NSString *queryFormat = @"http://54.178.143.221:8080/ChineseVerticalServer/cn-vertical/answer/%@";
    NSString *encodedQuestion = [self.question stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *queryString = [NSString stringWithFormat:queryFormat, encodedQuestion];
    NSURL *queryUrl = [[NSURL alloc] initWithString:queryString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:queryUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ([self isCancelled])
    {
        return;
    }
    if (!received)
    {
        return;
        /*
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(processTimeoutException) withObject:nil waitUntilDone:YES];
        return;
         */
    }
    NSMutableString *queryResult = [[NSMutableString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:queryResult options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    GDataXMLElement *statusElement = [[rootElement elementsForName:@"status"] objectAtIndex:0];
    GDataXMLElement *answerElement = [[rootElement elementsForName:@"answer"] objectAtIndex:0];
    NSLog(@"%@", [answerElement stringValue]);
    GDataXMLDocument *productDoc = [[GDataXMLDocument alloc] initWithXMLString:[answerElement stringValue] options:0 error:nil];
    if ([[statusElement stringValue] isEqualToString:@"Success"] && productDoc != nil)
    {
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(processMessage:) withObject:[answerElement stringValue] waitUntilDone:YES];
    }
    else
    {
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(processException) withObject:nil waitUntilDone:YES];
    }
}


@end
