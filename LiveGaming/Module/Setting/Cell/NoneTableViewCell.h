//
//  NoneTableViewCell.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/9.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingItem;
/**
 *  没有任何其他按钮的cell  有左侧的值和右侧的值
 */
@interface NoneTableViewCell : UITableViewCell

- (void)setContentCell:(SettingItem *)item;

@end
