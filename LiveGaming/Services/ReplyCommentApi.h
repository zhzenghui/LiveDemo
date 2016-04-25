//
//  ReplyCommentApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/31.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>

@interface ReplyCommentApi : YTKRequest
- (id)initWithUserId:(NSString *)userId CurrentPage:(NSString *)currentPage;
@end
