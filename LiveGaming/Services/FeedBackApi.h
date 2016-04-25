//
//  FeedBackApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/28.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>
@interface FeedBackApi : YTKRequest
- (id)initWithUserId:(NSString *)userId Content:(NSString *)content;
@end
