//
//  UserInfoTableViewCell.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/7.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "UserInfoTableViewCell.h"
#import "Masonry.h"
#import "DEFINE.h"
#import "UIImage+WaterMark.h"
#import "UIImageView+WebCache.h"
#import "IBJButton.h"

#define kOffset 4

@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}


- (void)initView {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


    [self.contentView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kOffset);
        make.left.mas_equalTo(kOffset);
        make.bottom.mas_equalTo(-kOffset);
        make.width.mas_equalTo(self.avatar.mas_height);
        
    }];

    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatar.mas_top);
        make.left.mas_equalTo(self.avatar.mas_right).offset(kOffset);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.contentView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kOffset);
        make.left.mas_equalTo(self.avatar.mas_right).offset(kOffset);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(31);
    }];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}


- (void)updateConstraints {
    
//    NSLog(@"%lg", self.avatar.frame.size.width);
//    self.avatar.layer.cornerRadius = self.avatar.frame.size.width;
    
    [super updateConstraints];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}



- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:YES];
    //
    if (highlighted) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
    }
    
}


- (void)setContentCell:(IBJUser *)item {
    
//    self.nameLabel.text = item.name;
////    self.numberLabel.text = item.title;
//
//    Blog *b = item.blogs[0];
//    NSString *blogName = [NSString stringWithFormat:@"%@.tumblr.com", b.name];
//    [self.avatar tb_setImageForBlogName:blogName forState:UIControlStateNormal size:AvatarSize128];
    
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}

- (UIButton *)avatar {
    
    if (_avatar == nil) {
        _avatar = [[IBJButton alloc] init];
        _avatar.backgroundColor = Kbackground;
        _avatar.layer.masksToBounds = YES;
        _avatar.opaque = NO;
        _avatar.layer.cornerRadius = 2;
        _avatar.layer.masksToBounds =YES;
        
    }
    
    return _avatar;
}

- (UILabel *)nameLabel {
    
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:20];
    }
    return _nameLabel;
}

- (UILabel *)numberLabel{
    
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:15];
        _numberLabel.textColor = [UIColor grayColor];
    }
    return _numberLabel;
}
@end
