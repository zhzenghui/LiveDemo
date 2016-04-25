//
//  LoginApi.m
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "GetArticleApi.h"

@implementation GetArticleApi{
    NSString *_username;
    NSString *_password;
}

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/article/GetArticle";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return nil;
}

- (id)jsonValidator {
    return @{
             @"ArticlesID": [NSString class],
             @"Content": [NSString class]
             };
}

- (NSString *)userId {
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}


@end
