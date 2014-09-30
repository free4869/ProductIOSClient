//
//  IAnswerUtilities.h
//  iAnswer
//
//  Created by Di Wang on 11-06-17.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SpeechAudioQueue.h"
//#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioFile.h>

@interface IAnswerUtilities : NSObject {
    
}

+(NSString*)filterErrorCharacters:(NSString*) input;

+(NSString*)getTrimedStringFromQuery:(NSString*)query;

+(UInt32)audioFileSize:(AudioFileID)fileDescriptor;
+(AudioFileID)openAudioFile:(NSString*)filePath;
+(NSString*)makeHTMLString:(NSString*)plainText;
+(NSString*)makeHTMLStringHuge:(NSString*)plainText;
+(NSString*)makeEscapeString:(NSString*) input;
+(NSString*)normalizeWhitespace:(NSString*) answer;


@end
