//
//  BoolTableViewCell.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/8.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "BoolTableViewCell.h"
#import "Masonry.h"
#import "SettingItem.h"

@implementation BoolTableViewCell

- (void)initView {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self addSubview:self.switchControl];
    [self.switchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4);
        make.right.mas_equalTo(-4);
        make.width.mas_equalTo(51);
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


- (void)setContentCell:(SettingItem *)item {
    
    self.item = item;
    self.textLabel.text = item.fieldName;
    self.switchControl.on = item.fieldValueBOOL;
}

- (void)change:(UISwitch *)sw {
    
    _item.fieldValueBOOL = sw.on;
    if ( [_delegate respondsToSelector:@selector(switchChanger:)]) {
        [_delegate performSelector:@selector(switchChanger:) withObject:_item];
    }
}


- (UISwitch *)switchControl {
    
    if (_switchControl == nil) {
        _switchControl = [[UISwitch alloc] init];
        [_switchControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchControl;
}

@end
