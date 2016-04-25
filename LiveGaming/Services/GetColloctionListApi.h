//
//  GetColloctionListApi.h
//  LiveGaming
//
//  Created by xy on 16/3/29.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "YTKRequest.h"

@interface GetColloctionListApi : YTKRequest



- (id)initWithArticlesType:(NSString *)tableTyep
                  UserId:(NSString *)userId
               CurrentPage:(NSString *)currentPage;
@end
