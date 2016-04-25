//
//  PlayView.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/22.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "PlayView.h"
#import "DEFINE.H"
#import "SCRecorder.h"
#import "Common.h"
#import "Post.h"
#import "NSString+Helper.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>


#define KThumbanailTime 0

static const CGFloat kVideoControlBarHeight = 40.0;
static const CGFloat kVideoControlAnimationTimeinterval = 0.3;
static const CGFloat kVideoControlTimeLabelFontSize = 10.0;
static const CGFloat kVideoControlLabelFontSize = 20.0;
static const CGFloat kVideoControlBarAutoFadeOutTimeinterval = 5.0;


static const CGFloat kVideoPlayerControllerAnimationTimeinterval = 0.3f;

@interface PlayView() <SCPlayerDelegate> {
    UIProgressView * progressView;
}

@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *fullScreenButton;
@property (nonatomic, strong) UIButton *shrinkScreenButton;
@property (nonatomic, strong) UISlider *progressSlider;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UILabel *loadingTimeLabel;

@property (nonatomic, strong) NSTimer *autoPlayerTimer;

@property (nonatomic, strong) UIView *controlView;

@property (nonatomic, strong) UIView *tipInfomationView;


@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;


@property (nonatomic, strong) SCVideoPlayerView *vpv;
@property (nonatomic, strong) NSTimer *durationTimer;
@property (nonatomic, assign) BOOL isBarShowing;

@property (nonatomic, assign) BOOL isFullScreen;


// 旋转视频方向
@property (nonatomic, assign) BOOL isLandscapeMode;
@property (nonatomic, assign) CGRect originFrame;


//缩小时 放回原来的位置
@property (nonatomic, assign) CGRect oldFrame;




@end



@implementation PlayView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    
    [self removeObservers];
    _player.delegate = nil;
}

- (void)setupView {
    
    
    self.backgroundColor = KbackgroundBlack;

    
    [self setAutoPlayer];
    _player = [SCPlayer player];
    _player.delegate = self;
  

    self.vpv = [[SCVideoPlayerView alloc] initWithPlayer:_player];
//    self.vpv.frame = ;
    self.vpv.backgroundColor =  KbackgroundBlack;
    [self addSubview:self.vpv];
//    self.vpv.playerLayer.needsDisplayOnBoundsChange = YES;

    
    self.thumbnailImageView = [[UIImageView alloc] init];
    self.thumbnailImageView.backgroundColor = KbackgroundBlack;
    self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.thumbnailImageView];
    
    
    [self addSubview:self.controlView];
    
    [self.controlView addSubview:self.tipInfomationView];
    [self.tipInfomationView addSubview:self.errorLabel];
    [self.tipInfomationView addSubview:self.loadingTimeLabel];
    
    [self.controlView addSubview:self.topBar];
    [self.controlView addSubview:self.bottomBar];
    [self.bottomBar addSubview:self.playButton];
    [self.bottomBar addSubview:self.pauseButton];
    self.pauseButton.hidden = YES;
    [self.bottomBar addSubview:self.fullScreenButton];
    [self.bottomBar addSubview:self.shrinkScreenButton];
    self.shrinkScreenButton.hidden = YES;
    [self.bottomBar addSubview:self.progressSlider];
    [self.progressSlider addSubview:progressView];

    [self.bottomBar addSubview:self.timeLabel];

    [self.controlView addSubview:self.indicatorView];
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
//    [tapGesture setNumberOfTouchesRequired : 1];
//
//    [self addGestureRecognizer:tapGesture];
    
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];

    
    UITapGestureRecognizer *tGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBottom:)];
    [self.bottomBar addGestureRecognizer:tGesture];
    
    [self configControlAction];
    [self configObserver];
    
    
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    [self configAllControllerFrame];
}


#pragma mark -

- (void)onMPMoviePlayerPlaybackStateDidChangeNotification
{
    if ( self.player.isPlaying ) {
        self.pauseButton.hidden = NO;
        self.playButton.hidden = YES;
        [self startDurationTimer];
        [self.indicatorView stopAnimating];
        [self autoFadeOutControlBar];
    } else {
        self.pauseButton.hidden = YES;
        self.playButton.hidden = NO;
        [self stopDurationTimer];
        [self animateShow];
    }
}

- (void)startDurationTimer
{
    self.durationTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(monitorVideoPlayback) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
}

- (void)stopDurationTimer
{
    [self.durationTimer invalidate];
}

#pragma mark -  player


- (void)player:(SCPlayer *__nonnull)player didPlay:(CMTime)currentTime loopsCount:(NSInteger)loopsCount; {
    
    DLog(@"didPlay:(CMTime)currentTime");
}


- (void)player:(SCPlayer *__nonnull)player didChangeItem:(AVPlayerItem *__nullable)item; {
//    DLog(@"didChangeItem");
    
    [self.indicatorView startAnimating];

//    清理屏幕内容

}

- (void)player:(SCPlayer *__nonnull)player didReachEndForItem:(AVPlayerItem *__nonnull)item; {
//    DLog(@"didReachEndForItem");

//    [self animateShow];
    [self stopButtonClick];
}


- (void)player:(SCPlayer *__nonnull)player itemReadyToPlay:(AVPlayerItem *__nonnull)item; {
//    DLog(@"itemReadyToPlay");
    [self hiddenImmediatelyThumbmail];

    [self setProgressSliderMaxMinValues];
    [self monitorVideoPlayback];
    [self.indicatorView stopAnimating];
    self.tipInfomationView.hidden = YES;
    [self onMPMoviePlayerPlaybackStateDidChangeNotification];


}

- (void)player:(SCPlayer *__nonnull)player didSetupSCImageView:(SCImageView *__nonnull)SCImageView; {
    DLog(@"didSetupSCImageView");

}

#pragma mark -  observe

- (void)playbackBufferEmptyForTimer {
    [self.player play];
}

- (void)continuePlaying
{
    
//    [self.player play];
    if (!self.playerItem.playbackLikelyToKeepUp)
    {
        if ( self.playerItem.playbackBufferEmpty  ==  YES ) {
            
//            [self.playerItem.asset cancelLoading];
//            CMTime time = self.playerItem.duration;
//            CMTime tpd  = self.player.playableDuration ;

            
            
            
//            if (tpd.timescale > time.timescale) {
//                [self.player play];
//            }
        }
//        self.loadingView.hidden = NO;
//        __weak typeof(self) wSelf = self;
        
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//        dispatch_async(queue, ^{
//            [wSelf.player play];
//            dispatch_sync(dispatch_get_main_queue(), ^{
//            });
//        });
//        self.playbackLikelyToKeepUpKVOToken =
//        NSString *keypath = @"";

//        NSString *keyPath÷ = @""; _playerItem.playbackLikelyToKeepUp;
//        self.playerItem addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:(nullable void *)
//        [self.playerItem addObserverForKeyPath:@keypath(_playerItem.playbackLikelyToKeepUp) block:^(id obj, NSDictionary *change) {
//            __strong typeof(self) sSelf = wSelf;
//            if(sSelf)
//            {
//                if (sSelf.playerItem.playbackLikelyToKeepUp)
//                {
//                    [sSelf.playerItem removeObserverForKeyPath:@keypath(_playerItem.playbackLikelyToKeepUp) token:self.playbackLikelyToKeepUpKVOToken];
//                    sSelf.playbackLikelyToKeepUpKVOToken = nil;
//                    [sSelf continuePlaying];
//                }
//            }
//        }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
   
    if (object == _player && [keyPath isEqualToString:@"status"]) {
        if (_player.status == AVPlayerStatusReadyToPlay) {
            _playButton.enabled = YES;
            DLog(@"AVPlayerStatusReadyToPlay");

        } else if (_player.status == AVPlayerStatusFailed) {
            // something went wrong. player.error should contain some information
            DLog(@"AVPlayerStatusFailed");

        }
    }
    else if ([keyPath isEqualToString:@"rate"] )
    {

        NSLog(@"rate：%f",self.player.rate);

        if (self.player.rate == 0.0 )
        {
            [self.indicatorView startAnimating];
        }
        else if (self.player.rate == 1.0 ){
            [self.indicatorView stopAnimating];
        }
    }
    else if ([keyPath isEqualToString:@"currentTime"] )
    {
         ;
        CGFloat time = CMTimeGetSeconds(self.playerItem.currentTime);
        NSLog(@"currentTime：%f",time);

    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"] )
    {
        NSArray *array = [self.playerItem loadedTimeRanges];
        //获取范围i
        CMTimeRange range = [array.firstObject CMTimeRangeValue];
        //从哪儿开始的
        CGFloat start = CMTimeGetSeconds(range.start);
        //缓存了多少
        CGFloat duration = CMTimeGetSeconds(range.duration);
        //一共缓存了多少
        CGFloat allCache = start+duration;
//        NSLog(@"缓存了多少数据：%f",allCache);
        
        //设置缓存的百分比
        CMTime allTime = [self.playerItem duration];
        //转换
        CGFloat time = CMTimeGetSeconds(allTime);
        CGFloat y = allCache/time;
        NSLog(@"缓存百分比：--------%f",y);
        progressView.progress = y;

    }
    else if (object == self.playerItem && [keyPath isEqualToString:@"playbackBufferEmpty"])
    {
        if (self.playerItem.playbackBufferEmpty) {
        
            [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(playbackBufferEmptyForTimer) userInfo:nil repeats:NO];
            NSLog(@"playbackBufferEmpty");
            NSLog(@"可播放数据为空");
        }
    }
    else if (object == self.playerItem && [keyPath isEqualToString:@"playbackLikelyToKeepUp"])
    {
        NSLog(@"playbackLikelyToKeepUp");

        if (self.playerItem.playbackLikelyToKeepUp)
        {
            [self.player play];
            
        }
    }
    else if (object == self.playerItem && [keyPath isEqualToString:@"playbackBufferFull"])
    {
        NSLog(@"playbackBufferFull");
        
        if (self.playerItem.playbackBufferFull)
        {
            [self.player play];
            
        }
    }
    
//
//    DLog(@"播放状态%i", self.player.isPlaying);
//    DLog(@"播放rate：%f", self.player.rate);
//    DLog(@"播放status：%li", (long)_player.status);
//    CMTime time = self.playerItem.duration;
//    CMTime tpd  = self.player.playableDuration ;
//
////    long long t = time.value / time.timescale;
////    DLog(@"播放duration：%lld", t);
//    DLog(@"播放Empty：%d", self.playerItem.playbackBufferEmpty);
//    DLog(@"播放Full：%d", self.playerItem.playbackBufferFull);

}

- (void)removeObservers {
    AVPlayerItem *item = self.playerItem;
    [item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [item removeObserver:self forKeyPath:@"status"];
    [item removeObserver:self forKeyPath:@"currentTime"];
    [item removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [item removeObserver:self forKeyPath:@"playbackBufferFull"];

    [_player removeObserver:self forKeyPath:@"currentTime"];
    [_player removeObserver:self forKeyPath:@"status"];
    [_player removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [_player removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [_player removeObserver:self forKeyPath:@"rate"];

}
- (void)addObservers {
    
    AVPlayerItem *item = self.playerItem ;
    [item addObserver:self forKeyPath:@"loadedTimeRanges"       options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"status"                 options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"currentTime"            options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"playbackBufferEmpty"    options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"playbackBufferFull"     options:NSKeyValueObservingOptionNew context:nil];
    
    [_player addObserver:self forKeyPath:@"currentTime"            options:NSKeyValueObservingOptionNew context:nil];
    [_player addObserver:self forKeyPath:@"status" options:0 context:nil];
    [_player addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [_player addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    [_player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark -  event response


- (void)loadVieoForUrl {
    if (_player) {
//        当前没有播放的item 设置新的url 主要是
        if ( ! _player.currentItem ) {
            DLog(@"====================视频切换");
            
            __block AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:self.url];


            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);

                [_player setItem: item];
                dispatch_async(queue, ^{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                    
                        self.playerItem = item;
                        [self addObservers];
                        
                    });
            });
        
        }
    }
}

- (void)cleanPlayer {
    [_player setItem:nil];
}

- (void)resetAllconfig {
    self.isBarShowing = YES;
    self.isFullScreen = NO;
    self.isLandscapeMode = NO;
    self.progressSlider.value = 0.f;
    progressView.progress = 0.f;
    [self.indicatorView stopAnimating];
    
    self.tipInfomationView.hidden = NO;
    
    [self pauseButtonClick];
    [self stopDurationTimer];
    [self animateShow];

    [self resetAutoPlayTimer];

    //    清理资源
    [self cleanPlayer];

    [self cleanThumbnail];

    [self cleanUrl];
    [self closeErrorViewTip];
    
    [self cleanAllResources];
    
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:self.post.thumbnail_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self showThumbnail];
    }];

}

- (void)loadPlay {

    [self resetAllconfig];
//    设置

    NSString *str = self.urlString;
    if ( ! str) {
        [self showErrorViewTip:@"视频连接有误"];
        [self cleanPlayer];
        return;
    }
//    
//    if ( ! [CooladingManager sharedCooladingManager].settings.isHttps ) {
//        str = [str stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
//    }
    
    self.urlString = str;
    NSURL *url = [NSURL URLWithString:str];
    if (url) {
        self.url = url;
    }
    DLog(@"%@", self.url);

}

- (void)dispose {
    
    [_player cancelPendingPrerolls];
}




- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.isBarShowing = YES;
}

- (void)animateHide
{
    if (!self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeinterval animations:^{
        self.topBar.alpha = 0.0;
        self.bottomBar.alpha = 0.0;
        
        self.fullScreenButton.alpha = 0;
        self.shrinkScreenButton.alpha = 0;
    } completion:^(BOOL finished) {
        self.isBarShowing = NO;
    }];
}

- (void)animateShow
{
    if (self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeinterval animations:^{
        self.topBar.alpha = 1.0;
        self.bottomBar.alpha = 1.0;
        
        self.fullScreenButton.alpha = 1;
        self.shrinkScreenButton.alpha = 1;
    } completion:^(BOOL finished) {
        self.isBarShowing = YES;
        [self autoFadeOutControlBar];
    }];
}

// 隐藏bottom view
- (void)autoFadeOutControlBar
{
    if (!self.isBarShowing) {
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
    [self performSelector:@selector(animateHide) withObject:nil afterDelay:kVideoControlBarAutoFadeOutTimeinterval];
}

- (void)cancelAutoFadeOutControlBar
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
}

- (void)closeButtonClick
{
    [self dismiss];
}

//- (void)dismiss
//{
//    [self stopDurationTimer];
//    [self.player pause];
//    
//    [UIView animateWithDuration:kVideoPlayerControllerAnimationTimeinterval animations:^{
//        self.view.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [self.view removeFromSuperview];
//        if (self.dimissCompleteBlock) {
//            self.dimissCompleteBlock();
//        }
//    }];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//}

// 调整播放进度
- (void)progressSliderValueChanged:(UISlider *)slider {
    double currentTime = floor(slider.value);
    double totalTime = floor(self.player.itemDuration.value/self.player.itemDuration.timescale);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
}

//
- (void)progressSliderTouchBegan:(UISlider *)slider {
    
    [self stopDurationTimer];
    
    [self.player pause];
    [self cancelAutoFadeOutControlBar];
}

//  调整结束后 播放
- (void)progressSliderTouchEnded:(UISlider *)slider {
    
    [self startDurationTimer];
    
    [self.player seekToTime:CMTimeMake(floor(slider.value), 1)];
    [self.player play];
    [self autoFadeOutControlBar];
}

//   设置播放器的进度条
- (void)setProgressSliderMaxMinValues {
    CMTime idtime = self.player.itemDuration;
    CGFloat duration = idtime.value/idtime.timescale;
    self.progressSlider.minimumValue = 0.f;
    self.progressSlider.maximumValue = duration;
    
}

- (void)setTimeLabelValues:(double)currentTime totalTime:(double)totalTime {
    double minutesElapsed = floor(currentTime / 60.0);
    double secondsElapsed = fmod(currentTime, 60.0);
    NSString *timeElapsedString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesElapsed, secondsElapsed];
    
    double minutesRemaining = floor(totalTime / 60.0);;
    double secondsRemaining = floor(fmod(totalTime, 60.0));;
    NSString *timeRmainingString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesRemaining, secondsRemaining];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeElapsedString,timeRmainingString];
}


- (void)onTapBottom:(UITapGestureRecognizer *)gesture {
    
}

- (void)doubleTap:(UITapGestureRecognizer *)gesture {
        if (self.isLandscapeMode) {
            
            [self shrinkScreenButtonClick];
        }
        else {
            [self fullScreenButtonClick];
        }
}
- (void)onTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
//        小窗口模式
        if ( ! self.isFullScreen && self.isBarShowing) {
            [self animateHide];
        }
        else {
            [self animateShow];
        }
        
//        全屏模式
        if ( ! self.isFullScreen && self.isBarShowing) {
            _oldFrame   = self.frame;
            
            UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
            if (!keyWindow) {
                keyWindow = [[[UIApplication sharedApplication] windows] firstObject];
            }
            CGFloat height = [[UIScreen mainScreen] bounds].size.height;
            CGFloat width = [[UIScreen mainScreen] bounds].size.width;
            CGRect frame = CGRectMake(0, 0, width, height);;
            
            [keyWindow addSubview:self];
            [UIView animateWithDuration:kVideoPlayerControllerAnimationTimeinterval animations:^{
                self.frame = frame;

            } completion:^(BOOL finished) {
                
            }];
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
            self.isFullScreen = YES;
            [self playButtonClick];
        }
        else if (self.isFullScreen && self.isBarShowing) {
            
            
            if (self.isLandscapeMode) {

                [self shrinkScreenButtonClick];
            }
            [_suplerView addSubview:self];
            [UIView animateWithDuration:kVideoPlayerControllerAnimationTimeinterval animations:^{
                self.frame = _oldFrame;
            } completion:^(BOOL finished) {
            }];
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
            
            self.isFullScreen = NO;;
        }
    }
}


- (void)setPlayItem {
    [self loadVieoForUrl];
}

- (void)autoPlayer:(NSTimer *)timer {
    
    [self playButtonClick];
}

- (void)setAutoPlayer {
    _autoPlayerTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoPlayer:) userInfo:nil repeats:NO];
}

- (void)playButtonClick
{
    [self setPlayItem];
    [self.player play];
    
    [self.delegate player:self playing:nil];

    
    self.playButton.hidden = YES;
    self.pauseButton.hidden = NO;
}



- (void)resetAutoPlayTimer {
    if ([_autoPlayerTimer isValid]) {
        [_autoPlayerTimer invalidate];
    }
}

- (void)stopButtonClick
{
    [self.player seekToTime:CMTimeMake(0, 1000)];
    [self.player pause];
}


- (void)pauseButtonClick
{
//    [self.player seekToTime:CMTimeMake(10, 1)];
    [self.player pause];
    self.playButton.hidden = NO;
    self.pauseButton.hidden = YES;
    [self dispose];

}

- (void)showFullScreen {
    if (self.isLandscapeMode) {
        return;
    }

    [UIView animateWithDuration:0.3f animations:^{

        CGFloat radians = (M_PI/180) * 90;
        [UIView animateWithDuration:1.0 animations:^{
            self.vpv.transform = CGAffineTransformRotate(self.transform, radians);
            self.controlView.transform = CGAffineTransformRotate(self.transform, radians);
        }];
        
    } completion:^(BOOL finished) {
        self.isLandscapeMode = YES;
        self.fullScreenButton.hidden = YES;
        self.shrinkScreenButton.hidden = NO;
        
        [self configPlayControlFrame];
    }];
}

- (void)fullScreenButtonClick
{
    [self showFullScreen];
}

- (void)shrinkScreenButtonClick
{
    if (!self.isLandscapeMode) {
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
        CGFloat radians = (M_PI/180) * 0;
        [UIView animateWithDuration:1.0 animations:^{
            self.vpv.transform = CGAffineTransformRotate(self.transform, radians);
            self.controlView.transform = CGAffineTransformRotate(self.transform, radians);

        }];
    } completion:^(BOOL finished) {
        self.isLandscapeMode = NO;
        self.fullScreenButton.hidden = NO;
        self.shrinkScreenButton.hidden = YES;
    }];
}

#pragma mark - Private Method
- (void)showThumbnail {
//    self.thumbnailImageView.hidden = NO;
    
    [UIView animateWithDuration:KThumbanailTime animations:^{
        self.thumbnailImageView.alpha = 1;
    }];
}

- (void)hiddenThumbmail {
//    self.thumbnailImageView.hidden = YES;
    [UIView animateWithDuration:KThumbanailTime animations:^{
        self.thumbnailImageView.alpha = 0;
    }];
}

- (void)hiddenImmediatelyThumbmail {
    self.thumbnailImageView.alpha = 0;
}


- (void)showErrorViewTip:(NSString *)errorMsg {
    
    self.errorLabel.text = errorMsg;
}
- (void)closeErrorViewTip {
    
    self.errorLabel.text = @"";
}

- (void)showErrorViewNetworkTip {
    self.errorLabel.text = @"请检查网络";
}



- (void)showInWindow
{
 
}

- (void)dismiss
{
    [self stopDurationTimer];
//    [self stop];
    [UIView animateWithDuration:kVideoPlayerControllerAnimationTimeinterval animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
//        [self.view removeFromSuperview];
//        if (self.dimissCompleteBlock) {
//            self.dimissCompleteBlock();
//        }
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)cleanAllResources {
    [self pauseButtonClick];
    [self cleanNetworkResources];
    [self cleanThumbnail];
    
    [self closeErrorViewTip];
}

- (void)cleanNetworkResources {
    
    [self dispose];
}


- (void)cleanThumbnail {
    [self.thumbnailImageView setImage:nil];
}


- (void)cleanResources {
    
}

- (void)cleanUrl {
    
    NSString *v_url = self.post.video_url;
    
    if ([self.post.video_type isEqualToString:kVideoTypeVine]) {
        v_url = self.post.thumbnail_url;
    }
    
    if (  [v_url vienUrlAvailable] ) {
    
        if ( [self.post.video_type isEqualToString:kVideoTypeVine]) {
            v_url = self.post.thumbnail_url;
            NSRange r = [v_url rangeOfString:@".mp4"];
            v_url = [v_url substringToIndex:r.location + r.length];
        }
    }
    else {
//        [self showErrorView];
        return;
    }
    //    else if ( [self.post.video_url isEqualToString:kVideoType]) {
    //
    //    }
    //    else if ( [self.post.video_url isEqualToString:kVideoType]) {
    //
    //    }
    //    else if ( [self.post.video_url isEqualToString:kVideoType]) {
    //
    //    }
    self.urlString = v_url;
}



- (void)configObserver
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMoviePlayerPlaybackStateDidChangeNotification) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMoviePlayerLoadStateDidChangeNotification) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMoviePlayerReadyForDisplayDidChangeNotification) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMPMovieDurationAvailableNotification) name:MPMovieDurationAvailableNotification object:nil];
}

- (void)cancelObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)configControlAction
{
    [self.playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseButton addTarget:self action:@selector(pauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.fullScreenButton addTarget:self action:@selector(fullScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.shrinkScreenButton addTarget:self action:@selector(shrinkScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.progressSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.progressSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    [self.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
    [self.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];

}

- (void)configPlayControlFrame {
    
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if (self.isFullScreen) {
        
        width = KDeviceWidth;
        height = KDeviceHeight;
        if (self.isLandscapeMode) {
         
            width = KDeviceHeight;
            height = KDeviceWidth;
        }
    }
    
    
    self.topBar.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), width, kVideoControlBarHeight);
    //    self.closeButton.frame = CGRectMake(CGRectGetWidth(self.topBar.bounds) - CGRectGetWidth(self.closeButton.bounds), CGRectGetMinX(self.topBar.bounds), CGRectGetWidth(self.closeButton.bounds), CGRectGetHeight(self.closeButton.bounds));
    self.bottomBar.frame = CGRectMake(CGRectGetMinX(self.bounds), height- kVideoControlBarHeight, width, kVideoControlBarHeight);
    self.playButton.frame = CGRectMake(CGRectGetMinX(self.bottomBar.bounds), CGRectGetHeight(self.bottomBar.bounds)/2 - CGRectGetHeight(self.playButton.bounds)/2, CGRectGetWidth(self.playButton.bounds), CGRectGetHeight(self.playButton.bounds));
    self.pauseButton.frame = self.playButton.frame;
    self.fullScreenButton.frame = CGRectMake(CGRectGetWidth(self.bottomBar.bounds) - CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.bottomBar.bounds)/2 - CGRectGetHeight(self.fullScreenButton.bounds)/2, CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.fullScreenButton.bounds));
    self.shrinkScreenButton.frame = self.fullScreenButton.frame;
    self.progressSlider.frame = CGRectMake(CGRectGetMaxX(self.playButton.frame), CGRectGetHeight(self.bottomBar.bounds)/2 - CGRectGetHeight(self.progressSlider.bounds)/2, CGRectGetMinX(self.fullScreenButton.frame) - CGRectGetMaxX(self.playButton.frame), CGRectGetHeight(self.progressSlider.bounds));
    progressView.frame = CGRectMake(3, 15, self.progressSlider.frame.size.width-6, self.bottomBar.frame.size.height);
    self.timeLabel.frame = CGRectMake(CGRectGetMidX(self.progressSlider.frame), CGRectGetHeight(self.bottomBar.bounds) - CGRectGetHeight(self.timeLabel.bounds) - 2.0, CGRectGetWidth(self.progressSlider.bounds)/2, CGRectGetHeight(self.timeLabel.bounds));
    self.indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)configAllControllerFrame {
    
    CGRect newFrame = self.frame;
    newFrame.origin = CGPointZero;
    self.vpv.frame = newFrame;

    self.controlView.frame  = newFrame;
    self.tipInfomationView.frame    = newFrame;
    self.errorLabel.frame   = newFrame;
    self.thumbnailImageView.frame = newFrame;
    
    [self configPlayControlFrame];
    
}

//监听设备旋转方向
- (void)ListeningRotating{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
}

- (void)onDeviceOrientationChange{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
            /**        case UIInterfaceOrientationUnknown:
             NSLog(@"未知方向");
             break;
             */
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
//            [self backOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
//            [self backOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在右");
            
//            [self setDeviceOrientationLandscapeLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            
            NSLog(@"第1个旋转方向---电池栏在左");
            
//            [self setDeviceOrientationLandscapeRight];
            
        }
            break;
            
        default:
            break;
    }
    
}


// 设置当前的播放进度到播放条
- (void)monitorVideoPlayback
{
    
    AVPlayerItem *currentItem = self.player.currentItem;
    CMTime duration = currentItem.duration; //total time
    CMTime currentTimeCM = currentItem.currentTime; //playing time
    
    
    double currentTime = floor(currentTimeCM.value/currentTimeCM.timescale);

    double totalTime = floor(duration.value/duration.timescale);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
    self.progressSlider.value = ceil(currentTime);
}

#pragma mark - delloc


#pragma mark - getter or setter

- (void)setPost:(Post *)post {
    
    if (  post != _post) {
        _post = post;
        [self loadPlay];

    }
}

- (void)setUrlString:(NSString *)urlString {
    if ( ! [_urlString isEqualToString:urlString]) {
        
        _urlString = urlString;
    }
}

- (void)setFrame:(CGRect)frame {
    if (!CGRectEqualToRect(frame, self.frame)) {
        [super setFrame:frame];
        [self configAllControllerFrame];
    }
}

#pragma mark - Property

- (UIView *)topBar
{
    if (!_topBar) {
        _topBar = [UIView new];
        _topBar.backgroundColor = [UIColor clearColor];
    }
    return _topBar;
}

- (UIView *)bottomBar
{
    if (!_bottomBar) {
        _bottomBar = [UIView new];
        _bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _bottomBar;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"kr-video-player-play"] forState:UIControlStateNormal];
        _playButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _playButton;
}

- (UIButton *)pauseButton
{
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseButton setImage:[UIImage imageNamed:@"kr-video-player-pause"] forState:UIControlStateNormal];
        _pauseButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _pauseButton;
}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"kr-video-player-fullscreen"] forState:UIControlStateNormal];
        _fullScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _fullScreenButton;
}

- (UIButton *)shrinkScreenButton
{
    if (!_shrinkScreenButton) {
        _shrinkScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shrinkScreenButton setImage:[UIImage imageNamed:@"kr-video-player-shrinkscreen"] forState:UIControlStateNormal];
        _shrinkScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _shrinkScreenButton;
}

- (UISlider *)progressSlider
{
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"kr-video-player-point"] forState:UIControlStateNormal];
        [_progressSlider setMinimumTrackTintColor:[UIColor whiteColor]];
        [_progressSlider setMaximumTrackTintColor:[UIColor lightGrayColor]];
        _progressSlider.value = 0.f;
        _progressSlider.continuous = YES;
        
        progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        
    }
    return _progressSlider;
}




- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"kr-video-player-close"] forState:UIControlStateNormal];
        _closeButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _closeButton;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:kVideoControlTimeLabelFontSize];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.bounds = CGRectMake(0, 0, kVideoControlTimeLabelFontSize, kVideoControlTimeLabelFontSize);
    }
    return _timeLabel;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicatorView stopAnimating];
    }
    return _indicatorView;
}


- (UIView *)controlView
{
    if (!_controlView) {
        _controlView = [UIView new];
        _controlView.backgroundColor = [UIColor clearColor];
    }
    return _controlView;
}


- (UIView *)tipInfomationView
{
    if (!_tipInfomationView) {
        _tipInfomationView = [UIView new];
        _tipInfomationView.backgroundColor = [UIColor clearColor];
    }
    return _tipInfomationView;
}

- (UILabel *)errorLabel
{
    if (!_errorLabel) {
        _errorLabel = [UILabel new];
        _errorLabel.backgroundColor = [UIColor clearColor];
        _errorLabel.font = [UIFont systemFontOfSize:kVideoControlLabelFontSize];
        _errorLabel.textColor = KRed;// [UIColor redColor];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.bounds = CGRectMake(0, 0, kVideoControlTimeLabelFontSize, kVideoControlTimeLabelFontSize);
    }
    return _errorLabel;
}

- (UILabel *)loadingTimeLabel
{
    if (!_loadingTimeLabel) {
        _loadingTimeLabel = [UILabel new];
        _loadingTimeLabel.backgroundColor = [UIColor clearColor];
        _loadingTimeLabel.font = [UIFont systemFontOfSize:kVideoControlLabelFontSize];
        _loadingTimeLabel.textColor = [UIColor whiteColor];
        _loadingTimeLabel.textAlignment = NSTextAlignmentCenter;
        _loadingTimeLabel.bounds = CGRectMake(0, 0, kVideoControlTimeLabelFontSize, kVideoControlTimeLabelFontSize);
    }
    return _loadingTimeLabel;
}

@end
