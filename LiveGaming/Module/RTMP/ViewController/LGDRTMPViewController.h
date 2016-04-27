//
//  LGDViewController.h
//  LiveGaming
//
//  Created by xy on 16/4/25.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>


@interface LGDRTMPViewController : UIViewController

@property (atomic, strong) NSURL *url;

@property (atomic, retain) id <IJKMediaPlayback> player;

@end
