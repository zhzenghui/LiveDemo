//
//  AddFriendsApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/31.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "AddFriendsApi.h"
#import "Models.h"
@implementation AddFriendsApi{
    
    NSString *_userId;
    NSString *_friendId;
}
- (id)initWithUserId:(NSString *)userId FriendId:(NSString *)friendId
{
    self = [super init];
    if (self) {
        _userId = userId;
        _friendId = friendId;
    }
    return self;
}
- (NSString *)requestUrl
{
    return @"/api/user/AddFriends";
}
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
- (id)requestArgument{
    NSDictionary *dic = @{@"UserId":_userId,@"FriendId":_friendId};
    NSString * body = [dic yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return bodyDic;
}

@end
