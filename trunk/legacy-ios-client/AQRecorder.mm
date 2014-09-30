#include "AQRecorder.h"

int AQRecorder::ComputeRecordBufferSize(const AudioStreamBasicDescription *format, float seconds)
{
	int packets, frames, bytes = 0;
	try {
		frames = (int)ceil(seconds * format->mSampleRate);
		
		if (format->mBytesPerFrame > 0)
			bytes = frames * format->mBytesPerFrame;
		else {
			UInt32 maxPacketSize;
			if (format->mBytesPerPacket > 0)
				maxPacketSize = format->mBytesPerPacket;	// constant packet size
			else {
				UInt32 propertySize = sizeof(maxPacketSize);
				XThrowIfError(AudioQueueGetProperty(mQueue, kAudioQueueProperty_MaximumOutputPacketSize, &maxPacketSize,
												 &propertySize), "couldn't get queue's maximum output packet size");
			}
			if (format->mFramesPerPacket > 0)
				packets = frames / format->mFramesPerPacket;
			else
				packets = frames;	// worst-case scenario: 1 frame in a packet
			if (packets == 0)		// sanity check
				packets = 1;
			bytes = packets * maxPacketSize;
		}
	} catch (CAXException e) {
		char buf[256];
		fprintf(stderr, "Error: %s (%s)\n", e.mOperation, e.FormatError(buf));
		return 0;
	}	
	return bytes;
}



// Returns the average power level in the given signal
float AQRecorder::getPower(signed short int *signal, int numSamples)
{
    int i;
    float amp;
    float powerSum = 0.0f;
    
    for (i = 0; i < numSamples; i++)
    {
        amp = (float) abs(signal[i]);
        powerSum += amp * amp;
    }
    
    return powerSum / (32768.0f * 32768.0f * (float) numSamples);
}

// AudioQueue callback function, called when an input buffers has been filled.
void AQRecorder::MyInputBufferHandler(	void *								inUserData,
										AudioQueueRef						inAQ,
										AudioQueueBufferRef					inBuffer,
										const AudioTimeStamp *				inStartTime,
										UInt32								inNumPackets,
										const AudioStreamPacketDescription*	inPacketDesc)
{
	AQRecorder *aqr = (AQRecorder *)inUserData;
	try {
		if (inNumPackets > 0) {
			aqr->mRecordPacket += inNumPackets;
            
            float power = getPower((short*)inBuffer->mAudioData, inBuffer->mAudioDataByteSize / 2);
            NSLog(@"%f",power);
            
            if (power>0.000020 && aqr->recordState==AQR_SPEECH_NOT_DETECTED) {
                aqr->recordState=AQR_SPEECH_DETECTED;
                NSLog(@"AQR_SPEECH_DETECTED");
            }
            
            if((power<0.000150 && aqr->recordState==AQR_SPEECH_DETECTED && aqr->mRecordPacket>32000)
                || (aqr->mRecordPacket > 16000*25) ){
                aqr->recordState=AQR_SPEECH_FINISHED;
                NSLog(@"AQR_SPEECH_FINISHED");  
                aqr->StopRecord();
            }else{
                [aqr->speexEncoder_ speexEncRawBuf:(short*)inBuffer->mAudioData withByteSize:inBuffer->mAudioDataByteSize]; 
            }
        }
		
		if (aqr->IsRunning())
			XThrowIfError(AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL), "AudioQueueEnqueueBuffer failed");
	} catch (CAXException e) {
		char buf[256];
		fprintf(stderr, "Error: %s (%s)\n", e.mOperation, e.FormatError(buf));
	}
}

AQRecorder::AQRecorder()
{
	mIsRunning = false;
	mRecordPacket = 0;
    speexEncoder_ = [[SpeexEncoder alloc] init];
    recordState = AQR_SPEECH_NOT_DETECTED;
}

AQRecorder::~AQRecorder()
{
	AudioQueueDispose(mQueue, TRUE);
	AudioFileClose(mRecordFile);
    [speexEncoder_ release];
}

// ____________________________________________________________________________________
// Copy a queue's encoder's magic cookie to an audio file.
void AQRecorder::CopyEncoderCookieToFile()
{
	UInt32 propertySize;
	OSStatus err = AudioQueueGetPropertySize(mQueue, kAudioQueueProperty_MagicCookie, &propertySize);
	
	if (err == noErr && propertySize > 0) {
		Byte *magicCookie = new Byte[propertySize];
		UInt32 magicCookieSize;
		XThrowIfError(AudioQueueGetProperty(mQueue, kAudioQueueProperty_MagicCookie, magicCookie, &propertySize), "get audio converter's magic cookie");
		magicCookieSize = propertySize;	// the converter lies and tell us the wrong size
		
		// now set the magic cookie on the output file
		UInt32 willEatTheCookie = false;
		// the converter wants to give us one; will the file take it?
		err = AudioFileGetPropertyInfo(mRecordFile, kAudioFilePropertyMagicCookieData, NULL, &willEatTheCookie);
		if (err == noErr && willEatTheCookie) {
			err = AudioFileSetProperty(mRecordFile, kAudioFilePropertyMagicCookieData, magicCookieSize, magicCookie);
			XThrowIfError(err, "set audio file's magic cookie");
		}
		delete[] magicCookie;
	}
}

void AQRecorder::SetupAudioFormat(UInt32 inFormatID)
{
	memset(&mRecordFormat, 0, sizeof(mRecordFormat));

	mRecordFormat.mFormatID = inFormatID;
        mRecordFormat.mSampleRate = 16000.0;
        mRecordFormat.mChannelsPerFrame = 1;
    
		// if we want pcm, default to signed 16-bit little-endian
		mRecordFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
		mRecordFormat.mBitsPerChannel = 16;
		mRecordFormat.mBytesPerPacket = mRecordFormat.mBytesPerFrame = (mRecordFormat.mBitsPerChannel / 8) * mRecordFormat.mChannelsPerFrame;
		mRecordFormat.mFramesPerPacket = 1;
        
       
        
        
	//}
}

void AQRecorder::StartRecord()
{
	int i, bufferByteSize;
	UInt32 size;
//	CFURLRef url;
    
	recordState=AQR_SPEECH_NOT_DETECTED;
    
	try {		

		// specify the recording format
		SetupAudioFormat(kAudioFormatLinearPCM);
		
		// create the queue
		XThrowIfError(AudioQueueNewInput(
									  &mRecordFormat,
									  MyInputBufferHandler,
									  this /* userData */,
									  NULL /* run loop */, NULL /* run loop mode */,
									  0 /* flags */, &mQueue), "AudioQueueNewInput failed");
		
		// get the record format back from the queue's audio converter --
		// the file may require a more specific stream description than was necessary to create the encoder.
		mRecordPacket = 0;

		size = sizeof(mRecordFormat);
		XThrowIfError(AudioQueueGetProperty(mQueue, kAudioQueueProperty_StreamDescription,	
										 &mRecordFormat, &size), "couldn't get queue's format");
        
        
        //create new encoder for new recording
        [speexEncoder_ release];
        speexEncoder_ = [[SpeexEncoder alloc] init];
		
		// allocate and enqueue buffers
		bufferByteSize = ComputeRecordBufferSize(&mRecordFormat, kBufferDurationSeconds);	// enough bytes for half a second
		for (i = 0; i < kNumberRecordBuffers; ++i) {
			XThrowIfError(AudioQueueAllocateBuffer(mQueue, bufferByteSize, &mBuffers[i]),
					   "AudioQueueAllocateBuffer failed");
			XThrowIfError(AudioQueueEnqueueBuffer(mQueue, mBuffers[i], 0, NULL),
					   "AudioQueueEnqueueBuffer failed");
		}
		// start the queue
		mIsRunning = true;
		XThrowIfError(AudioQueueStart(mQueue, NULL), "AudioQueueStart failed");
	}
	catch (CAXException &e) {
		char buf[256];
		fprintf(stderr, "Error: %s (%s)\n", e.mOperation, e.FormatError(buf));
	}
	catch (...) {
		fprintf(stderr, "An unknown error occurred\n");
	}	

}


void AQRecorder::StopRecord()
{
    if (!mIsRunning) {
        return;
    }
	// end recording
	mIsRunning = false;
	XThrowIfError(AudioQueueStop(mQueue, true), "AudioQueueStop failed");	
	// a codec may update its cookie at the end of an encoding session, so reapply it to the file now
	CopyEncoderCookieToFile();
	AudioQueueDispose(mQueue, true);
	AudioFileClose(mRecordFile);
    //[delegate_ recordQueueStopped:nil]; 
    [(NSObject*)delegate_ performSelectorOnMainThread:@selector(recordQueueStopped:) withObject:nil waitUntilDone:NO];
}
