//
//  ReplyCommentApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/31.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "ReplyCommentApi.h"
#import "Models.h"
@implementation ReplyCommentApi{
    NSString* _userId;
    NSString* _currentPage;
}
- (id)initWithUserId:(NSString *)userId CurrentPage:(NSString *)currentPage{
    self = [super init];
    if (self) {
        _currentPage = currentPage;
        _userId = userId;
    }
    return self;
}

- (NSString *)requestUrl
{
    return  @"/api/article/GetUserReply";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    NSDictionary *dic = @{@"UserId":_userId,@"CurrentPage":_currentPage};
    NSString *body = [dic yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return bodyDic;
    
}


@end
