//
//  User.m
//  Coolading
//
//  Created by bejoy on 14/10/27.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import "User.h"
#import "CCLog.h"


@implementation User

- (id)initWithPhone:(NSString *)phone pwd:(NSString *)pwd {
  if (self = [super init]) {
    _phoneNumber = phone;
    _pwd = pwd;
  }
  return self;
}

//
//
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"blogs" : [Blog class]};
//
//}










@end
