//
//  MeSettingTableViewCell.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/7.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "MeSettingTableViewCell.h"

@implementation MeSettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifiersty {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifiersty];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code

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

@end
