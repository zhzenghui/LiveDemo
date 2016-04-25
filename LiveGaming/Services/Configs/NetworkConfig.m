//
//  NetworkConfig.m
//  LiveGaming
//
//  Created by xy on 16/2/29.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "NetworkConfig.h"
#import "YTKNetworkConfig.h"
#import "YTKUrlArgumentsFilter.h"


@implementation NetworkConfig

+ (void)loadYTKDefaultConfig {
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
//    config.baseUrl = @"http://192.168.70.179:8090";
    config.baseUrl = @"http://192.168.57.201:8090";
//    config.baseUrl = @"http://123.127.236.135:8000";
//      config.baseUrl = @"http://192.168.57.55:8017";



    config.cdnUrl = @"http://fen.bi";
    
    /**
     *  公共参数
     */
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    YTKUrlArgumentsFilter *urlFilter = [YTKUrlArgumentsFilter filterWithArguments:@{@"version": appVersion}];
    [config addUrlFilter:urlFilter];
}

+ (void)baseUrl:(NSString *)baseUrl {
    NSAssert(baseUrl != nil, @"baseUrl不能为空！");

    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = baseUrl;
}
+ (void)cdnUrl:(NSString *)cdnUrl {
    NSAssert(cdnUrl != nil, @"cdnUrl不能为空！");
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = cdnUrl;
}

@end
