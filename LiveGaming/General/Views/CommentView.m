//
//  CommentView.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/22.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "CommentView.h"
#import "ColorMacro.h"
#import "SizeMacro.h"
#define TextViewHeight 120
#define ButtonWidth 60
#define ButtonHeight 30
@implementation CommentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)createView{
    // 背景View
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, KSCREENHEIHGT - 180, KSCREENWIDTH, 180)];
    self.backView.backgroundColor = KCellColor;
    [self addSubview:self.backView];
    
    // textView
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(KSpace, KSpace, KSCREENWIDTH  - 2*KSpace,TextViewHeight)];
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];
    self.textView.backgroundColor = Kwhite;
    [self.backView addSubview:self.textView];
    
    // 确定
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.sureBtn.frame = CGRectMake(KSCREENWIDTH - KSpace - ButtonWidth, KViewY(self.textView) + KViewHight(self.textView) + 10, ButtonWidth, ButtonHeight);
        [self.sureBtn setTitleColor:Kblock forState:UIControlStateNormal];
    [self.backView addSubview:self.sureBtn];
    
    // 取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:Kblock forState:UIControlStateNormal];
    self.cancelBtn.frame = CGRectMake(KSpace, KViewY(self.textView) + KViewHight(self.textView) + 10, ButtonWidth, ButtonHeight);
    [self.backView addSubview:self.cancelBtn];
    [self.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)tap:(UITapGestureRecognizer *)sender{
    [self removeFromSuperview];
    [self hideKeyBoard];
}
#pragma mark  隐藏键盘

- (void)hideKeyBoard
{
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        for (UIView* view in window.subviews)
        {
            [self dismissAllKeyBoardInView:view];
        }
    }
}

-(BOOL) dismissAllKeyBoardInView:(UIView *)view
{
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoardInView:subView])
        {
            return YES;
        }
    }
    return NO;
}
- (void)sureBtnClick:(UIButton *)sender
{
    NSLog(@"发布");
}
- (void)cancelBtnClick:(UIButton *)sender{
    [self removeFromSuperview];
    [self hideKeyBoard];
      NSLog(@"取消");
}

#pragma  mark textView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
        if (text.length == 0) return YES;
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 15) {
            return NO;
        }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
        if (textView.text.length > 20) {
            textView.text = [textView.text substringToIndex:20];
        }
    self.commentStr = textView.text;
}
@end
