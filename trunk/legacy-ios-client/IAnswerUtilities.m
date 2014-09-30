//
//  IAnswerUtilities.m
//  iAnswer
//
//  Created by Di Wang on 11-06-17.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import "IAnswerUtilities.h"


@implementation IAnswerUtilities

+(NSString*)filterErrorCharacters:(NSString*) input
{
    NSCharacterSet* charSet;
    charSet = [NSCharacterSet characterSetWithCharactersInString:@"Ä¶  "];
    return [input stringByTrimmingCharactersInSet:charSet];
    
}

+(NSString*)getTrimedStringFromQuery:(NSString*)query
{
    NSURL *url = [[NSURL alloc] initWithString:query];
    NSData *dataFromUrl = [NSData dataWithContentsOfURL:url];
    NSString *result4urlString = [[NSString alloc] initWithData:dataFromUrl encoding:NSUTF8StringEncoding];
    NSString *trimmedQuestion =[result4urlString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [url release];
    [result4urlString release];
    return trimmedQuestion;
}

+(NSString*)getDataFromQuery:(NSString*)query
{
    NSURL *url = [[NSURL alloc] initWithString:query];
    NSData *dataFromUrl = [NSData dataWithContentsOfURL:url];
    NSString *result4urlString = [[NSString alloc] initWithData:dataFromUrl
                                                       encoding:NSUTF8StringEncoding];
    NSString *trimmedQuestion =[result4urlString stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [url release];
    [result4urlString release];
    return trimmedQuestion;
}

// find the audio portion of the file
// return the size in bytes
+(UInt32)audioFileSize:(AudioFileID)fileDescriptor
{
	UInt64 outDataSize = 0;
	UInt32 thePropSize = sizeof(outDataSize);
	OSStatus result = AudioFileGetProperty(fileDescriptor, kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
	if(result != 0) NSLog(@"cannot find file size");
	return (UInt32)outDataSize;
}

// open the audio file
// returns a big audio ID struct
+(AudioFileID)openAudioFile:(NSString*)filePath
{
	AudioFileID outAFID;
	// use the NSURl instead of a cfurlref cuz it is easier
	NSURL * afUrl = [NSURL fileURLWithPath:filePath];
    OSStatus result = AudioFileOpenURL((CFURLRef)afUrl, kAudioFileReadPermission, 0, &outAFID);
    
	if (result != 0) NSLog(@"cannot openf file: %@",filePath);
	return outAFID;
}

+(NSString*)makeHTMLString:(NSString*)plainText
{
    NSMutableString* html = [NSMutableString stringWithString:plainText];
    [html insertString:@"<font size=45>" atIndex:0];
    [html appendString:@"</font>"];
    return html;
}

+(NSString*)makeHTMLStringHuge:(NSString*)plainText
{
    NSMutableString* html = [NSMutableString stringWithString:plainText];
    [html insertString:@"<font size=160>" atIndex:0];
    [html appendString:@"</font>"];
    return html;
}
 
+(NSString*)makeEscapeString:(NSString*) input
{
    return (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                               NULL,
                                                               (CFStringRef)input,
                                                               NULL,
                                                               (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                               kCFStringEncodingUTF8 );
}

+(NSString*)normalizeWhitespace:(NSString*) answer
{
    if (answer == nil) {
        return nil;
    }
    
    answer = [answer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    answer = [answer stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
    answer = [answer stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    answer = [answer stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    answer = [answer stringByReplacingOccurrencesOfString:@" " withString:@" "];
    while ([answer rangeOfString:@"  "].location != NSNotFound) {
        answer = [answer stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    
    return answer;
}


@end
