//
//  SpeexEncoder.m
//  iAnswer
//
//  Created by Di Wang on 11-08-22.
//  Copyright 2011 University of Waterloo. All rights reserved.
//

#import "SpeexEncoder.h"
#import "config.h"
#import "speex/speex.h"
#import <math.h>
#import "IAnswerUtilities.h"


const int kAudioSampleRate = 16000;
const int kAudioPacketIntervalMs = 100;
const int kNumBitsPerAudioSample = 16;
const int kNoSpeechTimeoutSec = 8;
const int kEndpointerEstimationTimeMs = 300;

const char* const kContentTypeSpeex = "audio/x-speex-with-header-byte; rate=";
const int kSpeexEncodingQuality = 8;  
const int kMaxSpeexFrameLength = 110; 


@implementation SpeexEncoder

@synthesize encodedAudio_;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        encodedAudio_ = [[NSMutableData alloc] init];
    }
    
    return self;
}

-(void) dealloc {
    [encodedAudio_ release];
    [super dealloc];
}

- (void)speexEncRawBuf:(short*)samples withByteSize:(int) bytesize
{
   
    /*Holds the state of the encoder*/
    void *state;    
    /*Holds bits so they can be read and written to by the Speex routines*/
    SpeexBits bits;
    int samples_per_frame;
    char encoded_frame_data[kMaxSpeexFrameLength + 1];
    
    memset(&bits, 0, sizeof(bits));
    speex_bits_init(&bits);
    state = speex_encoder_init(&speex_wb_mode);
    
    speex_encoder_ctl(state, SPEEX_GET_FRAME_SIZE, &samples_per_frame);
    
    
    int quality = kSpeexEncodingQuality;
    speex_encoder_ctl(state, SPEEX_SET_QUALITY, &quality);
    int vbr = 1;
    speex_encoder_ctl(state, SPEEX_SET_VBR, &vbr);
    memset(encoded_frame_data, 0, sizeof(encoded_frame_data));
    
    int num_samples = bytesize / sizeof(short);
    
    // Drop incomplete frames, typically those which come in when recording stops.
    num_samples -= (num_samples % samples_per_frame);
    for (int i = 0; i < num_samples; i += samples_per_frame) {
        speex_bits_reset(&bits);
        
        speex_encode_int(state, (samples + i), &bits);
        
        // Encode the frame and place the size of the frame as the first byte. This
        // is the packet format for MIME type x-speex-with-header-byte.
        int frame_length = speex_bits_write(&bits, encoded_frame_data + 1,
                                            kMaxSpeexFrameLength);
        encoded_frame_data[0] = (char)frame_length;
        
        [encodedAudio_ appendBytes:encoded_frame_data length:frame_length+1];
    }
    
    /*Destroy the encoder state*/
    speex_encoder_destroy(state);
    /*Destroy the bit-packing struct*/
    speex_bits_destroy(&bits);
    //fclose(fout);
}

- (void)speexEncFile: (NSString*) inCafFilePath 
{
    
    AudioFileID fileID = [IAnswerUtilities openAudioFile:inCafFilePath];
    UInt32 waveLen = [IAnswerUtilities audioFileSize:fileID];
    
    NSLog(@"waveLen : %d",(int)waveLen);

    // the audio data buf
    short * samples = (short*) malloc(waveLen);
    memset(samples, 0, waveLen);
    
    // get the bytes from the file and put them into the data buffer
    OSStatus result = noErr;
    result = AudioFileReadBytes(fileID, false, 0, &waveLen, samples);
    
    AudioFileClose(fileID); //close the file
    if (result != noErr) NSLog(@"cannot load caf file: %@",inCafFilePath);
    
    [self speexEncRawBuf:samples withByteSize:waveLen];
    
    free(samples);
}

@end
