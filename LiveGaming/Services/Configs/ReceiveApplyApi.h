//
//  ReceiveApplyApi.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/4/1.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>
@interface ReceiveApplyApi : YTKRequest
- (instancetype)initWithAppliedFor:(NSString *)applied AudiencetType:(NSString *)audiencetType Apply:(NSString *)apply ApplyMsg:(NSString *)applyMsg ApplyState:(NSString *)applyState;
@end
