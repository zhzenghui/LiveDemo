//
//  StoreItemView.m
//  CooLaDingNOTwo
//
//  Created by zeng hui on 15/11/2.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "StoreItemView.h"
#import "DEFINE.h"

@interface StoreItemView()




@end



@implementation StoreItemView




- (void)setStoreItem {
    
    
    //图片
    self.convertImageView = [[IBJImageView alloc]init];
    self.convertImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.convertImageView];
    
    self.converView = [[IBJImageView alloc]init];
    self.converView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.converView];
    
    
    self.palyButtonView = [[IBJImageView alloc]init];
    self.palyButtonView.contentMode = UIViewContentModeCenter;
    self.palyButtonView.image = [UIImage imageNamed:@"play"];
    self.palyButtonView.hidden = YES;
    
    [self addSubview:self.palyButtonView];
    
    //盛放label的容器
    self.LabelView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 25)];
    [self.LabelView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.LabelView];
    
    //label
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  , 0, self.LabelView.frame.size.width , 25)];
    [self.LabelView addSubview:self.nameLabel];
    
    
    
    
    
    self.converView.translatesAutoresizingMaskIntoConstraints = NO;
    self.LabelView.translatesAutoresizingMaskIntoConstraints = NO;
    self.converView.translatesAutoresizingMaskIntoConstraints = NO;
    self.palyButtonView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *imageMap = @{@"imageView" :self.converView,
                               @"labelView" :self.LabelView,
                               @"converView" :self.converView,
                               @"palyButtonView": self.palyButtonView};
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:imageMap];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:imageMap];
    
    NSArray *converhConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[converView]-0-|" options:0 metrics:nil views:imageMap];
    NSArray *convervConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[converView]-0-|" options:0 metrics:nil views:imageMap];
    
    NSArray *playrhConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[palyButtonView]-0-|" options:0 metrics:nil views:imageMap];
    NSArray *playrvConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[palyButtonView]-0-|" options:0 metrics:nil views:imageMap];
    
    
    NSArray *labelHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[labelView]-0-|" options:0 metrics:nil views:imageMap];
    NSArray *labelVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]-0-[labelView]-0-|" options:0 metrics:nil views:imageMap];
    
    [self addConstraints:hConstraints];
    [self addConstraints:vConstraints];
    
    [self addConstraints:converhConstraints];
    [self addConstraints:convervConstraints];
    
    [self addConstraints:playrhConstraints];
    [self addConstraints:playrvConstraints];
    
    [self addConstraints:labelHConstraints];
    [self addConstraints:labelVConstraints];

}



- (void)cleanStoreItemView {
    
    self.converView.image = nil;;
    self.converView.image = nil;
    
    self.backgroundColor = Kwhite;

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    // Configure the view for the selected state
}


@end
