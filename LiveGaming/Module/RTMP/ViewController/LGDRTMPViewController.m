//
//  LGDViewController.m
//  LiveGaming
//
//  Created by xy on 16/4/25.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "LGDRTMPViewController.h"




@interface LGDRTMPViewController ()
@end

@implementation LGDRTMPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = [NSURL URLWithString:@"http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];



    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];

    UIView *playerView = [_player view];

    playerView.frame = self.view.frame;

    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;



    [self.view insertSubview:playerView atIndex:1];

    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];

//    [self installMovieNotificationObservers];

    [self.player prepareToPlay];
    
    [self.player play];
    
    
    //    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
//    //    NSString *scheme = [[url scheme] lowercaseString];
//    
////    rtmp://192.168.57.54:1935/myapp
////    http://krtv.qiniudn.com/150522nextapp
//    [IJKVideoViewController presentFromViewController:self withTitle:[NSString stringWithFormat:@"URL: %@", url] URL:url completion:^{
//        //            [self.navigationController popViewControllerAnimated:NO];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
