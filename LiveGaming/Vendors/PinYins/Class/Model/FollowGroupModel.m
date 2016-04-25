//
//  FollowGroupModel.m
//  剧能玩2.1
//
//  Created by 大兵布莱恩特  on 15/11/11.
//  Copyright © 2015年 大兵布莱恩特 . All rights reserved.
//

#import "FollowGroupModel.h"
#import "PinYinForObjc.h"
#import "Models.h"
@implementation FollowGroupModel

+ (instancetype)getGroupsWithArray:(NSMutableArray*)dataArray groupTitle:(NSString*)title
{
    NSMutableArray *tempArray = [NSMutableArray array];
    FollowGroupModel *group = [[FollowGroupModel alloc] init];
    for (FriendModel *friend in dataArray)
    {
        
        NSLog(@"%@",friend.FriendName);
        NSString *header = [PinYinForObjc chineseConvertToPinYinHead:friend.FriendName];
        if ([header isEqualToString:title])
        {
            [tempArray addObject:friend];
        }
    }
    group.groupTitle = title;
    group.follows = tempArray;
    return group;
}
@end
