//
//  ReplyDetailApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>

@interface ReplyDetailApi : YTKRequest
- (instancetype)initWithUserId:(NSString *)userId ArticleId:(NSString *)articleId CurrentPage:(NSString *)currentPage RepId:(NSString *)repId;
@end
