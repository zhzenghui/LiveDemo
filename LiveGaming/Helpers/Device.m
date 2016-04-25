//
//  DeviceUUID.m
//  BaseLib
//
//  Created by bejoy on 14/12/30.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
#import "Cookie.h"
#import "Device.h"

#include <objc/runtime.h>




@implementation Device

+ (NSString*)idfa {
  NSString* adId =
      [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

  return adId;
}

+ (NSString*)idfv {
  NSString* idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
  return idfv;
}

+ (NSString*)deviceToken {
    
  NSString* deviceToken = [Cookie  getCookie:@"deviceToken"];
  return deviceToken;
}

+ (NSString *)deviceSystemVersion {
    
    
    return [[UIDevice currentDevice] systemVersion];
}



+ (NSString *)deviceModel {
    
    
    return [[UIDevice currentDevice] model];
}


+ (BOOL)isJailBreak
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
//        NSLog(@"The device is jail broken!");
        return YES;
    }
//    NSLog(@"The device is NOT jail broken!");
    return NO;
}

+ (void)allApp {
    
//    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
//    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
}

@end
