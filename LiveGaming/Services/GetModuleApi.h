//
//  LoginApi.h
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "YTKRequest.h"

/**
 获取首页的二级分类的数据
 
 */
@interface GetModuleApi : YTKRequest


- (id)initWithArticleID:(NSString *)ArticleID;

- (NSString *)userId;


@end
