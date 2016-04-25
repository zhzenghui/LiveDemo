//
//  UserInfoTableViewCell.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/7.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBJUser;
/**
 *  设置界面的用户信息cell
 */
@interface UserInfoTableViewCell : UITableViewCell

//头像
//名称
//介绍
@property(nonatomic, strong) UIButton    *avatar;
@property(nonatomic, strong) UILabel        *nameLabel;
@property(nonatomic, strong) UILabel        *numberLabel;

- (void)setContentCell:(IBJUser *)item;


@end
