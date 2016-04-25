//
//  NetWorkManager.m
//  TestPods
//
//  Created by xy on 15/9/9.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "NetWorkStatusManager.h"
#import "SDWebImageManager.h"
#import "Manager.h"


@implementation NetWorkStatusManager

+ (instancetype)sharedManager {
    static NetWorkStatusManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[NetWorkStatusManager alloc] init];
    });
    
    return _sharedManager;
}




- (void)reachableViaWWAN {
    
    NSLog(@"无线网络");
    
//     取消所有图片下载
    [[SDWebImageManager sharedManager] cancelAll];
    
//    取消所有现在的网络请求
    [[[AFHTTPRequestOperationManager manager]  operationQueue] cancelAllOperations];
    
    
//    取消所有的上传操作
    
    
    
}


- (void)reachableViaWiFi {
    
    NSLog(@"WiFi网络");
}


- (void)reachableNot {
    
    NSLog(@"无网络");
}



- (void)startReachabilityStatusChangeMonitoring; {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
        [Manager sharedManager].networkReachabilityStatus = status;
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable:{
                
                [self reachableNot];
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                
                [self reachableViaWiFi];
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
                [self reachableViaWWAN];
                break;
                
            }
                
            default:
                break;
                
        }
        
    }];
 
}

@end
