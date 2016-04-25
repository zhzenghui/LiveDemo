//
//  EditUserInfoApi.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/26.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "EditUserInfoApi.h"
#import "Models.h"
@implementation EditUserInfoApi {
    NSString *_age;
    NSString *_userName;
    NSString *_sex;
    NSString *_introduce;
    NSString *_userId;
}

- (id)initWithAge:(NSString *)age  UserID:(NSString *)userId sex:(NSString *)sex UserName:(NSString *)userName Introduce:(NSString *)introduce
{
    self = [super init];
    if (self) {
        _age = age;
        _sex = sex;
        _userName = userName;
        _introduce = introduce;
        _userId = userId;
    }
    return self;
}
- (NSString *)requestUrl{
    return @"/api/user/UpdateUser";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    
    NSDictionary *dict = @{
                           @"Age": _age,
                           @"UserId":_userId,
                           @"Sex":_sex,
                           @"UserName":_userName,
                           @"Introduce":_introduce
                           };
    NSString *s = [dict yy_modelToJSONString];
    NSDictionary *dc = @{@"body": s};
    return dc;
}
//- (AFConstructingBlock)constructingBodyBlock {
//    return ^(id<AFMultipartFormData> formData) {
//        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
//        NSString *name = @"image";
//        NSString *formKey = @"image";
//        NSString *type = @"image/jpeg";
//        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
//    };
//}
//
- (id)jsonValidator {
    return @{
             @"StateCode": [NSNumber class],
             //             @"loginUser": [NSDictionary class],
             //             @"Message": [NSString class]
             };
}
//
//- (NSString *)userId {
//    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
//}

@end
