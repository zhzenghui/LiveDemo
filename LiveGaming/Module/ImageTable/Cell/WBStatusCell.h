//
//  WBFeedCell.h
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBStatusCellDelegate;

@interface WBStatusCell : UITableViewCell

@property (nonatomic, weak) id<WBStatusCellDelegate> delegate;

@end



@protocol WBStatusCellDelegate <NSObject>
@optional
/// 点击了 Cell
- (void)cellDidClick:(WBStatusCell *)cell;
/// 点击了 Card
- (void)cellDidClickCard:(WBStatusCell *)cell;
/// 点击了转发内容
- (void)cellDidClickRetweet:(WBStatusCell *)cell;
/// 点击了Cell菜单
- (void)cellDidClickMenu:(WBStatusCell *)cell;
/// 点击了关注
- (void)cellDidClickFollow:(WBStatusCell *)cell;
/// 点击了转发
- (void)cellDidClickRepost:(WBStatusCell *)cell;
/// 点击了下方 Tag
- (void)cellDidClickTag:(WBStatusCell *)cell;
/// 点击了评论
- (void)cellDidClickComment:(WBStatusCell *)cell;
/// 点击了赞
- (void)cellDidClickLike:(WBStatusCell *)cell;
/// 点击了用户
/// 点击了图片
- (void)cell:(WBStatusCell *)cell didClickImageAtIndex:(NSUInteger)index;
/// 点击了 Label 的链接
//- (void)cell:(WBStatusCell *)cell didClickInLabel:(YYLabel *)label textRange:(NSRange)textRange;
@end
