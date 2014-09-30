//
//  RsvpWeatherApi.h
//  RsvpWeatherApi
//
//  Created by Shao Wei on 8/15/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFlySpeechSynthesizer.h"


@interface RsvpWeatherApi : NSObject <IFlySpeechSynthesizerDelegate>

@property (strong, nonatomic) IFlySpeechSynthesizer *iflySynthesizer;

- (NSString *)sendRequestWithQuestion:(NSString *)question;
- (void)setupVoiceSynthesizer;
- (void)playText:(NSString *)text;
- (void)pause;
- (void)resume;
- (void)cancel;


@end
