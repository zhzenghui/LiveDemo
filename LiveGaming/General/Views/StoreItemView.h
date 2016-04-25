//
//  StoreItemView.h
//  CooLaDingNOTwo
//
//  Created by zeng hui on 15/11/2.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBJImageView.h"



@interface StoreItemView : UIView



@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIView *LabelView;
@property(nonatomic, assign) int  Type;
@property(nonatomic, strong) IBJImageView *convertImageView;
@property(nonatomic, strong) IBJImageView *converView;
@property(nonatomic, strong) IBJImageView *palyButtonView;



- (void)cleanStoreItemView;

@end
