//
//  PlayView.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/22.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPlayer.h"
#import "Post.h"


typedef NS_ENUM(NSUInteger, VideoType) {
    VideoTypeVine,
    VideoTypeYoutube,
//    VideoType,
};

static NSString *const kVideoTypeVine = @"vine";
static NSString *const kVideoTypeTumblr = @"tumblr";


// 播放开始
// 播放完成



//播放器功能
//1. 控制进度
//2. 网络访问提示
//3. 缓存
//4. 加载到进度

@protocol PlayViewDelegate;
/**
 *  播放器
 */
@interface PlayView : UIView



@property(nonatomic, strong) UIImageView *thumbnailImageView;
@property(nonatomic, strong) NSString *urlString;
@property(nonatomic, strong) NSURL *url;

@property(nonatomic, strong) Post *post;


@property (strong, nonatomic) __block SCPlayer *player;

@property (weak, nonatomic) id<PlayViewDelegate> delegate;
@property (nonatomic, weak) UIView *suplerView;




@property (nonatomic, strong, readonly) UIView *topBar;
@property (nonatomic, strong, readonly) UIView *bottomBar;
@property (nonatomic, strong, readonly) UIButton *playButton;
@property (nonatomic, strong, readonly) UIButton *pauseButton;
@property (nonatomic, strong, readonly) UIButton *fullScreenButton;
@property (nonatomic, strong, readonly) UIButton *shrinkScreenButton;
@property (nonatomic, strong, readonly) UISlider *progressSlider;
@property (nonatomic, strong, readonly) UIButton *closeButton;
@property (nonatomic, strong, readonly) UILabel *timeLabel;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView;

- (void)animateHide;
- (void)animateShow;
- (void)autoFadeOutControlBar;
- (void)cancelAutoFadeOutControlBar;



- (void)playButtonClick;
- (void)pauseButtonClick;



- (void)resetAutoPlayTimer;



- (void)showErrorViewNetworkTip;

- (void)cleanThumbnail;
- (void)cleanResources;
- (void)cleanNetworkResources;
- (void)cleanAllResources;



@end



@protocol PlayViewDelegate <NSObject>

@optional

- (void)player:(PlayView *)player didURLError:(NSError*)error;


- (void)player:(PlayView *)player playing:(NSError*)error;

///**
// Called when the player has played some frames. The loopsCount will contains the number of
// loop if the curent item was set using setSmoothItem.
// */
//- (void)player:(SCPlayer *__nonnull)player didPlay:(CMTime)currentTime loopsCount:(NSInteger)loopsCount;
//
///**
// Called when the item has been changed on the SCPlayer
// */
//- (void)player:(SCPlayer *__nonnull)player didChangeItem:(AVPlayerItem *__nullable)item;
//
///**
// Called when the item has reached end
// */
//- (void)player:(SCPlayer *__nonnull)player didReachEndForItem:(AVPlayerItem *__nonnull)item;
//
///**
// Called when the item is ready to play
// */
//- (void)player:(SCPlayer *__nonnull)player itemReadyToPlay:(AVPlayerItem *__nonnull)item;
//
///**
// Called when the player has setup the renderer so it can receive the image in the
// proper orientation.
// */
//- (void)player:(SCPlayer *__nonnull)player didSetupSCImageView:(SCImageView *__nonnull)SCImageView;

@end