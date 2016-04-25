//
//  GetFriendslistApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/22.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "GetFriendslistApi.h"

@implementation GetFriendslistApi{
    // 用户Id
    NSString *_body;
}
-(id)initWithUserId:(NSString *)body
{
    self = [super init];
    if (self) {
        _body = body;
    }
    return  self;
}
- (NSString *)requestUrl{
    return @"/api/user/GetFriends";
}
- (YTKRequestMethod)requestMethod{
    return  YTKRequestMethodPost;
}

- (id)requestArgument{
    return @{@"body":_body};
}

@end
