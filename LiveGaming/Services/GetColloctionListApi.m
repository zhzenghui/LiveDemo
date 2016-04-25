//
//  GetColloctionListApi.m
//  LiveGaming
//
//  Created by xy on 16/3/29.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "GetColloctionListApi.h"
#import "YYModel.h"

@implementation GetColloctionListApi {
    NSString *_tableType;
    NSString *_userId;
    NSString *_currentPage;
}

- (id)initWithArticlesType:(NSString *)tableType
                    UserId:(NSString *)userId
               CurrentPage:(NSString *)currentPage {
    self = [super init];
    if (self) {
        
        _tableType   = tableType;
        _userId      = userId;
        _currentPage = currentPage;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/api/searchlist/getcollectionlist";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    NSDictionary *dict = @{
                           @"ArticlesType": _tableType ,
                           @"UserId": _userId,
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

@end
