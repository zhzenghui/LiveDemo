//
//  LoginApi.m
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "GetModuleApi.h"

@implementation GetModuleApi{
    NSString *_articleID;
}

- (id)initWithArticleID:(NSString *)ArticleID {
    self = [super init];
    if (self) {
        _articleID = @"89fe610d-8697-4523-8fe4-11748ee1f921";
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/common/GetModule";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{};
}

- (id)jsonValidator {
    return @{
             @"StateCode": [NSNumber class],
             @"Message": [NSString class]
             };
}

- (NSString *)userId {
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}


@end
