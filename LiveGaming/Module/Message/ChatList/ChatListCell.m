/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */


#import "ChatListCell.h"
#import "UIImageView+HeadImage.h"
#import "ColorMacro.h"
#import "SizeMacro.h"
@interface ChatListCell (){
    UILabel * _nameLabel;
    UIImageView *_headImage;
    UILabel *_timeLabel;
    UILabel *_unreadLabel;
    UILabel *_detailLabel;
    UIView *_lineView;
}

@end

@implementation ChatListCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        // Initialization code
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCREENWIDTH - 100, 15, 80, 16)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = KGrayText;
        [self.contentView addSubview:_timeLabel];

        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 15, KSCREENWIDTH - 120 - 65, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = KGrayText;
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];

        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 45, 45)];
        _headImage.layer.cornerRadius = 45/2;
        [self.contentView addSubview:_headImage];
    
        
        _unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(45,10, 20, 20)];
        _unreadLabel.backgroundColor = [UIColor redColor];
        _unreadLabel.textColor = [UIColor whiteColor];
        
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.font = [UIFont systemFontOfSize:11];
        _unreadLabel.layer.cornerRadius = 10;
        _unreadLabel.clipsToBounds = YES;
        [self.contentView addSubview:_unreadLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 40,KSCREENWIDTH -  20 - 65, 20)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = Kblock;
        [self.contentView addSubview:_detailLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,KSCREENWIDTH, 1)];
        _lineView.backgroundColor = KLine;
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = [UIColor redColor];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (![_unreadLabel isHidden]) {
        _unreadLabel.backgroundColor = [UIColor redColor];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.imageView.frame;
    
    [_headImage imageWithUsername:_name placeholderImage:[UIImage imageNamed:@"默认头像"]];
    _headImage.frame = CGRectMake(15, 15, 45, 45);
    [_nameLabel setTextWithUsername:_name];
    _detailLabel.text = _detailMsg;
    _timeLabel.text = _time;
    if (_unreadCount > 0) {
        if (_unreadCount < 9) {
            _unreadLabel.font = [UIFont systemFontOfSize:13];
        }else if(_unreadCount > 9 && _unreadCount < 99){
            _unreadLabel.font = [UIFont systemFontOfSize:12];
        }else{
            _unreadLabel.font = [UIFont systemFontOfSize:10];
        }
        [_unreadLabel setHidden:NO];
        [self.contentView bringSubviewToFront:_unreadLabel];
        _unreadLabel.text = [NSString stringWithFormat:@"%ld",(long)_unreadCount];
    }else{
        [_unreadLabel setHidden:YES];
    }
    
    frame = _lineView.frame;
    frame.origin.y = self.contentView.frame.size.height - 1;
    _lineView.frame = frame;
}

-(void)setName:(NSString *)name{
    _name = name;
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
@end
