//
//  UserViewModel.m
//  CooLaDingNOTwo
//
//  Created by xy on 16/1/5.
//  Copyright © 2016年 coolading. All rights reserved.
//

#import "UserViewModel.h"
#import "YYModel.h"
#import "YYCache.h"
#import "User.h"
#import "DEFINE.h"

#define KUserCache @"KUserCache"
#define KUserCacheKey @"KUserCacheKey"



@implementation UserViewModel

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    


    [self loadUserForCache];
    return self;
}

- (void)setIbjUser:(User *)ibjUser {
    
    if (_ibjUser != ibjUser) {

        _ibjUser = ibjUser;
        
        
        YYCache *cache = [[YYCache alloc] initWithName:KUserCache];

        [cache setObject:ibjUser.yy_modelToJSONData forKey:KUserCacheKey];
    }
}


- (void)loadUserForCache {
    
    [self user];
}

- (void)user {
    
    YYCache *cache = [[YYCache alloc] initWithName:KUserCache];
    
    if ([cache objectForKey:KUserCacheKey]) {
        
        _ibjUser = [User yy_modelWithJSON:[cache objectForKey:KUserCacheKey]];
    }
}


- (void)loginOut {
    
    //  post   login out
    [[NSNotificationCenter defaultCenter] postNotificationName:KLogoutRefresh object:nil];
    
    YYCache *cache = [[YYCache alloc] initWithName:KUserCache];

    //清理用户数据
    [cache removeAllObjects];
//    清理 验证数据
    
//    清理

}

@end
