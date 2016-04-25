//
//  SizeMacro.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/15.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#ifndef SizeMacro_h
#define SizeMacro_h

// 屏幕宽,高
#define KSCREENWIDTH  [[UIScreen mainScreen]bounds].size.width
#define KSCREENHEIHGT [[UIScreen mainScreen]bounds].size.height

// 视图的宽高
#define KViewWidth(view)  (view.frame.size.width)
#define KViewHight(view)  (view.frame.size.height)

// 视图的X,Y
#define KViewX(view)  (view.frame.origin.x)
#define KViewY(view)  (view.frame.origin.y)

// 默认边距 为15
#define KSpace 15

#endif /* SizeMacro_h */
