//
//  NoneTableViewCell.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/9.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "NoneTableViewCell.h"
#import "SettingItem.h"
@implementation NoneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *accesoryBadge = [[UILabel alloc] init];
        NSString *string = @"2";
        accesoryBadge.text = string;
        accesoryBadge.textColor = [UIColor whiteColor];
//        accesoryBadge.font = UIFont(name: "Lato-Regular", size: 16)
        accesoryBadge.font = [UIFont fontWithName:@"Lato-Regular" size:16];
        accesoryBadge.textAlignment = NSTextAlignmentCenter;
        accesoryBadge.layer.cornerRadius = 4;
        accesoryBadge.clipsToBounds = true;
        
//        accesoryBadge.frame = CGRectMake(0, 0, WidthForView(string, font: UIFont(name: "Lato-Light", size: 16), height: 20)+20, 20)
        self.accessoryView = accesoryBadge;
    }
    return self;
}




- (void)setContentCell:(SettingItem *)item {
    
    self.textLabel.text = item.fieldName;
    self.detailTextLabel.text = item.fieldValue;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
