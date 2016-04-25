//
//  Models.h
//  LiveGaming
//
//  Created by xy on 16/3/21.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "YYModel.h"



@class CommessageModel;
@class Replylist;
@class ReplydetailModel;
@class ApplyModel;
@class OtherPersonInfoModel;
@interface Models : NSObject

@end

@interface Article : NSObject


@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *ArticleLink2;

@property (nonatomic, copy) NSString *CteateTime;

@property (nonatomic, assign) NSInteger ReadCount;

@property (nonatomic, copy) NSString *ArticlesType;

@property (nonatomic, copy) NSString *ArticleLink2Html;

@property (nonatomic, assign) NSInteger CommentCount;

@property (nonatomic, assign) NSInteger Bad;

@property (nonatomic, copy) NSString *IsPublish;

@property (nonatomic, copy) NSString *IsDel;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger Good;

@property (nonatomic, copy) NSString *ArticleLink;

@property (nonatomic, copy) NSString *UserID;

@property (nonatomic, copy) NSString *ModuleID;

@property (nonatomic, copy) NSString *ArticlesID;

@end


@interface GuessExtList : NSObject


@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *GuessID;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, copy) NSString *ItemValue;



@property (nonatomic, assign) NSInteger Upper;

@end

@interface GuessModel : NSObject


@property (nonatomic, copy) NSString *IsOpen;

@property (nonatomic, copy) NSString *UserID;

@property (nonatomic, copy) NSString *EndTime;

@property (nonatomic, assign) NSInteger GuessCount;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *ModuleID;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) NSArray<GuessExtList *> *GuessExtList;

@property (nonatomic, copy) NSString *GuessType;

@property (nonatomic, copy) NSString *GuessID;

@property (nonatomic, assign) NSInteger MySelectValue;

@end

#pragma mark 好友列表
@interface FriendModel : NSObject

@property (nonatomic, copy) NSString *FriendID;

@property (nonatomic, copy) NSString *Introduce;

@property (nonatomic, copy) NSString *FriendName;

@property (nonatomic, copy) NSString *Sex;

@property (nonatomic, copy) NSString *MobilePhone;

@property (nonatomic, copy) NSString *Image;

@property (nonatomic, assign) NSInteger Age;
@end


#pragma mark 系统消息
@interface CommessageModel : NSObject

@property (nonatomic, copy) NSString *MsgId;

@property (nonatomic, copy) NSString *MsgContent;

@property (nonatomic, copy) NSString *CreateTime;

@end

#pragma  mark 评论回复列表
@interface ReplyCommentModel : NSObject

@property (nonatomic, copy) NSString *UserId;

@property (nonatomic, copy) NSString *Status;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, assign) NSInteger ReplyCount;

@property (nonatomic, copy) NSString *ArticlesId;

@property (nonatomic, assign) NSInteger Good;

@property (nonatomic, copy) NSString *ParentId;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *LastReply;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, assign) NSInteger Bad;


@end

#pragma mark 评论详情列表
@interface ReplydetailModel:NSObject
@property (nonatomic, copy) NSString *UserId;

@property (nonatomic, copy) NSString *RepContent;

@property (nonatomic, copy) NSString *RepDateTime;

@property (nonatomic, copy) NSString *Introduce;

@property (nonatomic, copy) NSString *Sex;

@property (nonatomic, copy) NSString *LoginName;

@property (nonatomic, copy) NSString *MobilePhone;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Image;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, copy) NSString *Age;

@end
#pragma mark 申请人信息
@interface ApplyModel : NSObject
@property (nonatomic, copy) NSString *ApplyMsg;

@property (nonatomic, copy) NSString *Image;

@property (nonatomic, copy) NSString *Apply;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *AppliedFor;

@end

#pragma mark 其他人个人信息
@interface OtherPersonInfoModel : NSObject

@property (nonatomic, copy) NSString *AppliedFor;

@property (nonatomic, copy) NSString *Introduce;

@property (nonatomic, copy) NSString *Sex;

@property (nonatomic, copy) NSString *Apply;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Image;

@property (nonatomic, assign) NSInteger Age;

@end






