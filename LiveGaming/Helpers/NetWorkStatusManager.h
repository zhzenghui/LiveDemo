//
//  NetWorkManager.h
//  TestPods
//
//  Created by xy on 15/9/9.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

/**
 *  网络状态管理
 */
@interface NetWorkStatusManager : NSObject


+ (instancetype)sharedManager;

- (void)startReachabilityStatusChangeMonitoring;

@end
