//
//  LoginApi.m
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "GetReplyApi.h"
#import "YYModel.h"

@implementation GetReplyApi{
    NSString *_articlesID;
    NSString *_currentPage;
    
}

- (id)initWithArticlesID:(NSString *)ArticlesID
             CurrentPage:(NSString *)currentPage {

    self = [super init];
    if (self) {

        _articlesID  = ArticlesID;
        _currentPage = currentPage;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/article/GetReply";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    NSDictionary *dict = @{
                           @"ArticlesID": _articlesID,
                           @"CurrentPage": _currentPage
                           };
    NSString *s = [dict yy_modelToJSONString];
    NSDictionary *dc = @{@"body": s};
    return dc;
}

- (id)jsonValidator {
    return @{
//             @"ArticlesList": [NSArray class],
             @"StateCode": [NSNumber class]
             };
}

- (NSString *)userId {
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}


@end
