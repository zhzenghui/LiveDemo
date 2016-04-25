//
//  Posts.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/22.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "Post.h"
#import <objc/objc.h>

@implementation Post


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"photos" : [Photo class],
             @"trail" : [Trail class],
             @"player" : [Player class]};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"notes" : [Note class]};
}
@end


@implementation Player

@end

@implementation Reblog

@end


@implementation Trail

@end


@implementation Theme

@end




@implementation Photo

+ (NSDictionary *)modelContainerPropertyGenericClass {
//    CFRunLoopModeRef
//
//    CFRunLoopRef runloop = nil;
//    CFStringRef mode = "";
//    CFRunLoopAddCommonMode(runloop, mode);
//    CFRunLoopRunInMode(mode, 100, true);
    
    

    
    return @{@"alt_sizes" : [Alt_Size class],
             @"original_size" : [Original_Size class]};
    
}
@end


@implementation Alt_Size

@end

@implementation Original_Size

@end

@implementation Blog

@end


@implementation Note

@end


