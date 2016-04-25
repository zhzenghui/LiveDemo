//
//  IBJButton.m
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/8.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

#import "IBJButton.h"

@implementation IBJButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (IBJButton *)tagButton; {
    
    IBJButton *button = [IBJButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    return button;
}

@end
