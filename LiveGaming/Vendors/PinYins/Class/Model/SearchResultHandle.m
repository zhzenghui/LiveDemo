//
//  SearchResultHandle.m
//  剧能玩2.1
//
//  Created by 大兵布莱恩特  on 15/11/11.
//  Copyright © 2015年 大兵布莱恩特 . All rights reserved.
//

#import "SearchResultHandle.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "Models.h"
@implementation SearchResultHandle
/**
 *  获取搜索的结果集
 *
 *  @param text 搜索内容
 *
 *  @return 返回结果集
 */
+ (NSMutableArray*)getSearchResultBySearchText:(NSString*)searchText dataArray:(NSMutableArray*)dataArray
{
    NSMutableArray *searchResults = [NSMutableArray array];
    if (searchText.length>0&&![ChineseInclude isIncludeChineseInString:searchText]) {
        for (int i=0; i<dataArray.count; i++) {
            FriendModel *friend = dataArray[i];
            if ([ChineseInclude isIncludeChineseInString:friend.FriendName]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:friend.FriendName];
                NSRange titleResult=[tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:friend.FriendName];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:friend.FriendName];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [searchResults addObject:friend.FriendName];
                }
            }
            else {
                NSRange titleResult=[friend.FriendName rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:friend.FriendName];
                }
            }
        }
    } else if (searchText.length>0&&[ChineseInclude isIncludeChineseInString:searchText]) {
        for (FriendModel *tempStr in dataArray) {
            NSRange titleResult=[tempStr.FriendName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [searchResults addObject:tempStr.FriendName];
            }
        }
    }
    return searchResults;
}
@end
