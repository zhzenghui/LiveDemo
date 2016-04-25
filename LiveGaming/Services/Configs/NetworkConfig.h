//
//  NetworkConfig.h
//  LiveGaming
//
//  Created by xy on 16/2/29.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkConfig : NSObject

+ (void)loadYTKDefaultConfig;

+ (void)baseUrl:(NSString *)baseUrl;

+ (void)cdnUrl:(NSString *)cdnUrl;

@end
