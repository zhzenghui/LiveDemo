//
//  BoolTableViewCell.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/8.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   设置页面的cell， 右边是一个bool选择器
 */
@class SettingItem;
@protocol BoolTableViewCellDelegate;

@interface BoolTableViewCell : UITableViewCell


@property(nonatomic, strong) UISwitch *switchControl;
@property(nonatomic, strong) SettingItem *item;

@property(nonatomic, weak) id<BoolTableViewCellDelegate> delegate;

- (void)setContentCell:(SettingItem *)item;

@end


@protocol BoolTableViewCellDelegate <NSObject>

/**
 *  当cell的bool值改变时调用
 *
 *  @param item 当前的item值
 */
- (void)switchChanger:(SettingItem *)item;

@end