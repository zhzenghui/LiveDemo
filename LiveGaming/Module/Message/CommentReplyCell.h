//
//  CommentReplyCell.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/15.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentReplyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;
@end
