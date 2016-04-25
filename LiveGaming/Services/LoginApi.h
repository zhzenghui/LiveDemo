//
//  LoginApi.h
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "YTKRequest.h"

@interface LoginApi : YTKRequest


- (id)initWithUsername:(NSString *)username password:(NSString *)password;

- (NSString *)userId;


@end
