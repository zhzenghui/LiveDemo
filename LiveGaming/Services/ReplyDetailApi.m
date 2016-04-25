

//
//  ReplyDetailApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "ReplyDetailApi.h"
#import "Models.h"
@implementation ReplyDetailApi{
    NSString *_userId;
    NSString *_articleId;
    NSString *_currentPage;
    NSString *_repId;
}
- (instancetype)initWithUserId:(NSString *)userId ArticleId:(NSString *)articleId CurrentPage:(NSString *)currentPage RepId:(NSString *)repId{
    if (self = [super init]) {
        _userId = userId;
        _articleId = articleId;
        _currentPage = currentPage;
        _repId = repId;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"/api/article/GetReplyDetail";
}
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
- (id)requestArgument
{
    NSDictionary *dic = @{@"UserId":_userId,@"ArticleId":_articleId,@"CurrentPage":_currentPage,@"RepId":_repId};
    NSString *body = [dic yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return  bodyDic;
}



@end
