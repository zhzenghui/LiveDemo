#import <Foundation/Foundation.h>
#import "avformat.h"
#import "avcodec.h"
#import "avio.h"
#import "swscale.h"
#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioToolbox.h>


@interface RTSPPlayer : NSObject {
	AVFormatContext *pFormatCtx;
	AVCodecContext *pCodecCtx;
    AVFrame *pFrame;
    AVPacket packet;
	AVPicture picture;
    AVCodecContext *_audioCodecContext;

    AVStream *_audioStream;
    NSUInteger _audioBufferSize;
    AVPacket *_packet, _currentPacket;
    
    struct SwsContext *img_convert_ctx;
    int16_t *_audioBuffer;

    
    
    UIImage *currentImage;
    NSMutableArray *audioPacketQueue;
    NSLock *audioPacketQueueLock;
    
    int audioPacketQueueSize;
    int videoStream;
    int audioStream;
    
    int sourceWidth, sourceHeight;
	int outputWidth, outputHeight;
	double duration;
    double currentTime;
    
    BOOL primed;
    BOOL _inBuffer;


}

/* Last decoded picture as UIImage */
@property (nonatomic, readonly) UIImage *currentImage;

/* Size of video frame */
@property (nonatomic, readonly) int sourceWidth, sourceHeight;

/* Output image size. Set to the source size by default. */
@property (nonatomic) int outputWidth, outputHeight;

/* Length of video in seconds */
@property (nonatomic, readonly) double duration;

/* Current time of video in seconds */
@property (nonatomic, readonly) double currentTime;

@property (nonatomic, retain) NSMutableArray *audioPacketQueue;
@property (nonatomic, assign) AVCodecContext *_audioCodecContext;
@property (nonatomic, assign) AudioQueueBufferRef emptyAudioBuffer;
@property (nonatomic, assign) int audioPacketQueueSize;
@property (nonatomic, assign) AVStream *_audioStream;

/* Initialize with movie at moviePath. Output dimensions are set to source dimensions. */
-(id)initWithVideo:(NSString *)moviePath usesTcp:(BOOL)usesTcp;

/* Read the next frame from the video stream. Returns false if no frame read (video over). */
-(BOOL)stepFrame;

/* Seek to closest keyframe near specified time */
-(void)seekTime:(double)seconds;

-(void)closeAudio;

- (AVPacket*)readPacket;

@end
