//
//  ColorMacro.h
//  CooLaDingNOTwo
//
//  Created by xy on 16/1/14.
//  Copyright © 2016年 coolading. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h


#pragma mark - color
/* *** DEBUG DEFINE *** */
// 测试用色（正常状态下置0，为透明色）
#if DEBUG
#define KTEST_COLOR  ([UIColor  colorWithRed:arc4random() % 10 / 10.0f \
green:arc4random() % 10 / 10.0f \
blue:arc4random() % 10 / 10.0f \
alpha:0.8] )
#else
#define KTEST_COLOR ([UIColor clearColor])
#endif




#define Kcolora(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define Kcolor(r, g, b)     Kcolora(r, g, b, 1)

// 白色
#define Kwhite              Kcolora(255, 255, 255, 1);
#define KlightGrayColor         [UIColor lightGrayColor]
// 黑色
#define Kblock              Kcolor(0,0,0)
// 红色
#define KRed                Kcolor(216, 0, 15)
// 蓝色
#define KBlue             Kcolor(0, 0, 255)
// 默认灰色字体颜色
#define KGrayText            Kcolor(136,136,136)
// cell 颜色
#define KCellColor           Kcolor(244,244,244)
// 分割线颜色
#define KLine                Kcolor(220,220,220)

#define Kbackground         Kcolor(227, 227, 227.0   )
#define KbackgroundNight    Kcolor(167, 167, 167.0   )

#define KbackgroundBlack    Kcolor(16, 16, 16 )
//#define KbackgroundBlack    Kcolor(0, 0, 0   )

#define KInsBlue            Kcolor(36, 75, 115)

#define KUIColorFromRGB(rgbValue) \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
    blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
    alpha:1.0]
#endif /* ColorMacro_h */
