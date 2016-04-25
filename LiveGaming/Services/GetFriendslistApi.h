//
//  GetFriendslistApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/22.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "YTKRequest.h"
@interface GetFriendslistApi : YTKRequest
- (id)initWithUserId:(NSString *)body;
@end
