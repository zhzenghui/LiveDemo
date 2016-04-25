//
//  UIImage+Image.m
//  自定义TabBarViewController
//
//  Created by 王雨 on 16/3/6.
//  Copyright (c) 2016年 王雨. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+(instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}
@end
