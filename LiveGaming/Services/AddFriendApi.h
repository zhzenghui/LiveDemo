//
//  AddFriendApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>

@interface AddFriendApi : YTKRequest
-(instancetype)initWithApply:(NSString *)apply AppliedFor:(NSString *)appliedFor ApplyMsg:(NSString *)applyMsg AudiencetYype:(NSString *)audiencetYype;
@end
