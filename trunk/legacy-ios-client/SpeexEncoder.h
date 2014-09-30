//
//  SpeexEncoder.h
//  iAnswer
//
//  Created by Di Wang on 11-08-22.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeexEncoder : NSObject{
    NSMutableData* encodedAudio_;
}

@property (nonatomic, retain) NSMutableData* encodedAudio_;

- (void)speexEncFile: (NSString*) inCafFilePath;
- (void)speexEncRawBuf:(short*)data withByteSize:(int) bytesize;

@end
