//
//  Models.m
//  LiveGaming
//
//  Created by xy on 16/3/21.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models.h"


@implementation Article
+ (NSDictionary *)objectClassInArray{
    return @{@"FriendModel" : [FriendModel class]};
}
@end

@implementation GuessExtList
+ (NSDictionary *)objectClassInArray{
    return @{@"GuessExtList" : [GuessExtList class]};
}

@end


@implementation GuessModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"GuessExtList" : [GuessExtList class]};
}
@end
@implementation FriendModel
+(NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"FriendModel" : [FriendModel class]};
}
@end


@implementation CommessageModel
+(NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"CommessageModel" : [CommessageModel class]};
}
@end


@implementation ReplyCommentModel
+(NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"ReplyCommentModel" : [ReplyCommentModel class]};
}

@end

@implementation ReplydetailModel
+(NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"ReplydetailModel" : [ReplydetailModel class]};
}
@end
@implementation ApplyModel
+(NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"ApplyModel" : [ApplyModel class]};
}




@end


@implementation OtherPersonInfoModel
+(NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"OtherPersonInfoModel" : [OtherPersonInfoModel class]};
}
@end



