//
//  UserViewModel.h
//  CooLaDingNOTwo
//
//  Created by xy on 16/1/5.
//  Copyright © 2016年 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface UserViewModel : NSObject

@property(nonatomic, strong) User *ibjUser;

/**
 *  登出后 清理数据， 清理用户数据， oauth
 */
- (void)loginOut;

@end
