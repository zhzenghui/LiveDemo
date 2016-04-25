//
//  SocialConfig.h
//  LiveGaming
//
//  Created by xy on 16/3/9.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialSnsService.h"
#import "UMSocialControllerService.h"


#import "UMSocial.h"
#import "MobClick.h"



#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
@interface SocialConfig : NSObject <
UIActionSheetDelegate,
UMSocialUIDelegate
>


/**
 *   注册友盟社交分享
 */
+ (void)registerSocial;


/**
 *  分享内容
 *
 *  @param vc        分享列表页面所在的UIViewController对象
 *  @param shareText 分享编辑页面的内嵌文字
 *  @param image     分享编辑页面的内嵌图片
 *  @param shareLink 分享编辑页面的
 */
+ (void)shareSnsFromViewController:(UIViewController *)vc
                         shareText:(NSString *)shareText
                        shareImage:(UIImage *)image
                         shareLink:(NSString *)shareLink;


+ (void)loginSnsPlatformViewController:(UIViewController *)vc socialPlat:(NSString *)name
                                finish:(void (^)(UMSocialAccountEntity *resultData,  NSError *error))finishBlock;
@end
