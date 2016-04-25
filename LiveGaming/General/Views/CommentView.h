//
//  CommentView.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/22.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextViewBlock)(NSString *);
@interface CommentView : UIView<UITextViewDelegate>
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UIButton * cancelBtn;
@property (nonatomic,strong)UIButton * sureBtn;
// 黑色背景图
@property (nonatomic,strong)UIView *backView;
// 评论
@property (nonatomic,copy)NSString *commentStr;
// 用于回调评论的字符串
@property (nonatomic,assign)TextViewBlock textViewBlock;
@end
