//
//  CommentReplyCell.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/15.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "CommentReplyCell.h"

@implementation CommentReplyCell

- (void)awakeFromNib {
    self.redLabel.layer.cornerRadius = 13/2;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
