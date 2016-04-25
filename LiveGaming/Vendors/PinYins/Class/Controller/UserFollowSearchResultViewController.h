//
//  UserFollowSearchResultViewController.h
//  剧能玩2.1
//
//  Created by 大兵布莱恩特  on 15/11/11.
//  Copyright © 2015年 大兵布莱恩特 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"
@class UserFollowSearchResultViewController;
@protocol UserFollowSearchResultViewControllerDelegate <NSObject>

@optional
/**
 *  点击了关注的那个人的模型
 *
 *  @param resultVC 结果的控制器
 *  @param follow   关注人的模型
 */
- (void)resultViewController:(UserFollowSearchResultViewController*)resultVC didSelectFollowModel:(FriendModel*)follow;

@end

/**
 *  搜索的结果控制器
 */
@interface UserFollowSearchResultViewController : UITableViewController
/**
 *  数据源数组
 */
@property (nonatomic,strong)NSMutableArray *dataSource;

/**
 *  delegate
 */
@property (nonatomic,weak) id<UserFollowSearchResultViewControllerDelegate>delegate;


@end
