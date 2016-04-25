//
//  LoginApi.h
//  LiveGaming
//
//  Created by xy on 16/3/10.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "YTKRequest.h"

typedef NS_ENUM(NSUInteger, HostTableType) {
    HostTableTypeRecommend = 0, //推荐
    HostTableTypePost      = 1,       //文章
    HostTableTypeVideo     = 2,       //视频
};


typedef NS_ENUM(NSUInteger, PageType) {
    /**
     *  主页
     */
    PageTypeMain,
    /**
     *  收藏
     */
    PageTypeColloction,
};

@interface GetArticleListApi : YTKRequest

- (id)initWithArticlesType:(NSString *)tableTyep
                  ModuleID:(NSString *)moduleID
               CurrentPage:(NSString *)currentPage;

- (NSString *)userId;


@end
