//
//  CooladingManager.m
//  Coolading
//
//  Created by bejoy on 14/10/27.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import "Manager.h"




NSString* ManagerSearchFailedError =  @"CooladingManagerSearchFailedError";

static Manager* manager;

@implementation Manager

+ (Manager *)sharedManager {
  if (!manager) {
    manager = [[Manager alloc] init];
  }

  return manager;
}



- (id)init {
  if (self == [super init]) {
            
      _fileCache = [[YYCache alloc] initWithName:@"file"];
      _userViewModel = [[UserViewModel alloc] init];
      
      //      // 保存
//      NSString *key = @"1";
//      NSDictionary *user = @{@"id": @1, @"name": @"tangqiao", @"age": @30};
//      [store putObject:user withId:key intoTable:tableName];
//      // 查询
//      NSDictionary *queryUser = [store getObjectById:key fromTable:tableName];
//      NSLog(@"query data result: %@", queryUser);
  }
  return self;
}

- (NSError*)tellDelegateAboutQuestionSearchError:(NSError*)error {
  NSDictionary* errorInfo = nil;
  if (error) {
    errorInfo =
        [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
  }

  NSError* reportableError =
      [NSError errorWithDomain:ManagerSearchFailedError
                          code:ManagerErrorCommuntitySearchCode
                      userInfo:errorInfo];

  return reportableError;
}


#pragma mark - 

- (void)networkReachabilityStatusChanger:(NSNotification *)notification {

    
}


#pragma mark - user
- (void)setLoginUser:(User *)loginUser {
    NSDictionary *dict = [loginUser yy_modelToJSONObject];
    [Cookie setCookie:@"user" value:dict];
    
    if ( loginUser ) {
        _isLogin = YES;
    }
    else {
        _isLogin = NO;
    }
    
}

- (User *)loginUser {
    NSDictionary *userDict = [Cookie getCookie:@"user"];
    User *current = [User yy_modelWithDictionary:userDict];
    
#if DEBUG
    current.Coin = @"200";
    current.nickName = @"耍大刀";
    current.phoneNumber = @"13124556667";
    current.auth_token = @"13124556667";
#endif
    return  current;
}

@end
