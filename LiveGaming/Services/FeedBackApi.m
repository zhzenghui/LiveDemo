//
//  FeedBackApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/28.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "FeedBackApi.h"
#import "Models.h"
@implementation FeedBackApi{
    
    NSString *_userId,*_content;
}
- (id)initWithUserId:(NSString *)userId Content:(NSString *)content
{
    self = [super init];
    if (self) {
        _userId = userId;
        _content = content;
    }
    return self;
}
- (NSString *)requestUrl{
    return @"/api/user/FeedBack";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {

    NSDictionary *dict = @{
                           @"UserId": _userId,
                           @"Content": _content
                           };
    NSString *s = [dict yy_modelToJSONString];
    NSDictionary *dc = @{@"body": s};
    return dc;
}
//
//- (id)jsonValidator {
//    return @{
//             @"StateCode": [NSNumber class],
//             };
//}
//
//- (NSString *)userId {
//    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
//}

@end
