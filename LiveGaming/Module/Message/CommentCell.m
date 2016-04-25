//
//  CommentCell.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/19.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "CommentCell.h"
@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModels:(ReplydetailModel *)model
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    self.userNameLabel.text = model.UserName;
    self.commentLabel.text = model.RepContent;
    self.timeLabel.text = model.CreateTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
