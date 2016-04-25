//
//  LoginApi.m
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "GetArticleListApi.h"
#import "YYModel.h"

@implementation GetArticleListApi{
    NSString *_tableType;
    NSString *_moduleID;
    NSString *_currentPage;
    
}

- (id)initWithArticlesType:(NSString *)tableType
                  ModuleID:(NSString *)moduleID
               CurrentPage:(NSString *)currentPage {
    self = [super init];
    if (self) {

        _tableType = tableType;
        _moduleID  = moduleID;
        _currentPage = currentPage;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/article/GetArticleByType";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    NSDictionary *dict = @{
                           @"ArticlesType": _tableType ,
                           @"ModuleID": _moduleID,
                           @"CurrentPage": _currentPage

                           };
    NSString *s = [dict yy_modelToJSONString];
    NSDictionary *dc = @{@"body": s};
    return dc;}

- (id)jsonValidator {
    return @{
             @"ArticlesList": [NSArray class],
             @"StateCode": [NSNumber class]
             };
}

- (NSString *)userId {
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}


@end
