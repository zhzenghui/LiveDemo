//
//  CommentCell.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/19.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"
@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
- (void)setModels:(ReplydetailModel *)model;
@end
