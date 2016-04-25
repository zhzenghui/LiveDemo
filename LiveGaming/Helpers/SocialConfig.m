//
//  SocialConfig.m
//  LiveGaming
//
//  Created by xy on 16/3/9.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "SocialConfig.h"

//
//#define UmengAppkey @"56dfc19e67e58e2256000935"
#define UmengAppkey @"53290df956240b6b4a0084b3"



#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface SocialConfig() <UMSocialUIDelegate, UIActionSheetDelegate>

@end


@implementation SocialConfig

+ (void)registerSocial {
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxdc1e388c3822c80b" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.umeng.com/social"];
    
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3731145531"
                                              secret:@"254f9b501f782e748cdc92458dfa65ec"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    //使用友盟统计
    [MobClick startWithAppkey:UmengAppkey];
    
    
}


+ (void)shareSnsFromViewController:(UIViewController *)vc
                         shareText:(NSString *)shareText
                        shareImage:(UIImage *)image
                         shareLink:(NSString *)shareLink
{
    id<UMSocialUIDelegate> delegate = (id)self;
    [UMSocialSnsService presentSnsIconSheetView:vc
                                         appKey:UmengAppkey
                                      shareText:shareText
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,
                                                 UMShareToWechatSession,
                                                 UMShareToWechatTimeline,
                                                 UMShareToQQ,nil]
                                       delegate:delegate];
    
    
//    横向屏幕的情况
//    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    
    
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


#pragma mark  -  

/**
 *  登录第三方， 包含qq ，微博
 *
 */
+ (void)loginSnsPlatformViewController:(UIViewController *)vc
                            socialPlat:(NSString *)name
                                finish:(void (^)(UMSocialAccountEntity *resultData,  NSError *error))finishBlock{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:name];
    
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:name];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            finishBlock(snsAccount, nil);
            
        }});
}


+ (void)loginOutFromSocialPlat:(NSString *)name  {
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
}

@end
