//
//  LoginApi.h
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "YTKRequest.h"




@interface GetReplyApi : YTKRequest

- (id)initWithArticlesID:(NSString *)ArticlesID
               CurrentPage:(NSString *)currentPage;

- (NSString *)userId;


@end
