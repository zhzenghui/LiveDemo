//
//  SystemMessage.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/29.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "SystemMessageApi.h"
#import "Models.h"
@implementation SystemMessageApi{
    NSString *_currentPage;
    
}
- (id)initWithCurrentPage:(NSString *)currentPage
{
    self = [super init];
    if (self) {
        _currentPage = currentPage;
    }
    return self;
}
- (NSString *)requestUrl
{
    return @"/api/common/GetComMessageList";
}
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
-(id)requestArgument
{
    NSDictionary *dic = @{@"CurrentPage":_currentPage};
    NSString *body = [dic yy_modelToJSONString];
    NSDictionary *bodyDic = @{@"body":body};
    return bodyDic;
}



@end
