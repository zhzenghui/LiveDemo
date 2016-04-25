//
//  RageIAPHelper.m
//  In App Rage
//
//  Created by Ray Wenderlich on 9/5/12.
//  Copyright (c) 2012 Razeware LLC. All rights reserved.
//

#import "RageIAPHelper.h"

@implementation RageIAPHelper

+ (RageIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static RageIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.yooyooi.yoosaympose.6coin",
                                      @"com.yooyooi.yoosaympose.12coin",
                                      @"com.yooyooi.yoosaympose.30coin",
                                      @"com.yooyooi.yoosaympose.98coin",
                                      @"com.yooyooi.yoosaympose.258coin",
                                      @"com.yooyooi.yoosaympose.328coin",
                                      @"com.yooyooi.yoosaympose.648coin",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
