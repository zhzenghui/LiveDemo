//
//  DEFINE.h
//  Coolading
//
//  Created by mUser on 15/1/3.
//  Copyright (c) 2015年 zeng. All rights reserved.
//

#import "Utils.h"

#import "ColorMacro.h"

#pragma mark - enum

typedef NS_ENUM(NSInteger, ItemStatue) {
    ItemStatueOpen,
    ItemStatueClose,
};



#pragma mark - 全局基础配置
#define KSettings @"settings"

//  推送通知
#define Knotification @""

//#define KappStoreID 882663597
#define KappStoreID 882663597
//  关于
//  qq群
//  联系作者

//  更新
//  开源协议

//  wifi网络上传
//  网络变化 改变
//  自动保存到相册
//  高清切换


#pragma mark - network string
#define Kstatus @"status"
#define Kmsg @"msg"
#define Kresult @"data"

#define KNotAuthorized 401

#define KPageSize  20
#pragma mark - 目录
//KCurrentUser
#define KCurrentUser @"currentUser"
#define KResource @"iPhone"
#define KServerPhone @""


#define KDATABASE_NAME  @"fff.sb"
#define KDefaultDATABASEPath KDocumentName(KDATABASE_NAME)

#pragma mark - 目录

#define KCachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define KCachesDirectoryFiles [KCachesDirectory stringByAppendingPathComponent:@"/files"]
#define KCachesDirectoryName(fileName) [NSString stringWithFormat:@"%@/%@",  KCachesDirectoryFiles ,fileName]

#define KCachesName(fileName) [NSString stringWithFormat:@"%@/%@",  KCachesDirectoryFiles ,fileName]
#define KDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define KDocumentDirectoryPhoto [KDocumentDirectory stringByAppendingPathComponent:@"/photo"]
#define KDocumentDirectoryUpload [KDocumentDirectory stringByAppendingPathComponent:@"/upload"]
#define KDocumentUploadForName(fileName) [NSString stringWithFormat:@"%@/%@",  KDocumentDirectoryUpload ,fileName]
#define KDocumentName(fileName) [NSString stringWithFormat:@"%@/%@",  KDocumentDirectory ,fileName]

//数据库路径
#define DocumentDatabase [KDocumentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]


#pragma mark -  域名地址


//#define kDomainUrl @"http://192.168.1.100:9999"
//#define kDomain @"http://192.168.199.104:3000/api/v1/"
//#define kImageDomain @" http://192.168.1.100:6666/image"


//#define KUpyun @"http://yuefile.b0.upaiyun.com/"
#define KUpyun @"http://yuefile.b0.upaiyun.com/"
#if DEBUG
#define kDomainAPI @"http://192.168.199.104:3000/api/v1/"
#define kDomain @"http://192.168.199.104:3000/"
#else
#define kDomain @"http://192.168.199.104:3000/api/v1/"
#endif

#define kTumblrCallBack @"https://www.yuenvshen.com/tumblr/callback"

#define WEAK_SELF __weak typeof(self) weakSelf = self
#define weak_Self(id) __weak typeof(id) weakSelf = id



#pragma mark - notification

#define KloadTagsForTagsArray                @"loadTagsForTagsArray"
#define KchangeCooladingManagerNotifition    @"changeCooladingManagerNotifition"
#define KreadDateMDcitionary                 @"readDateMDcitionary"
#define KloginSucess                         @"KloginSucess"
#define KKloadRCIM                           @"KloadRCIM"
#define KloginNotification                   @"loginNotification"
#define KrespondsToScrollViewOffChangerShang @"KrespondsToScrollViewOffChangerShang"
#define KrespondsToScrollViewOffChangerXia   @"KrespondsToScrollViewOffChangerXia"
#define KLogoutRefresh                       @"KLogoutRefresh"

// 推荐,竞猜,消息,设置
#define KRecommendNotification               @"KRecommendNotification"
#define KGuessNotfification                  @"KGuessNotfification"
#define KMessageNotfification                @"KMessageNotfification"
#define KSettingNotfification                @"KSettingNotfification"


#pragma mark - ios device  设备类型和设备尺寸

#define KiPhone5 (KDeviceWidth==320)
#define KiPhone6 (KDeviceWidth==375)
#define KiPhone6p (KDeviceWidth==414)
#define KwProportion 375.0*KDeviceWidth
#define KhProportion 667.0*KDeviceHeight
#define KmainViewHeight mainView.frame.size.height
#define KDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
#define KDeviceNav_Sta_Height 64
#define KDeviceNavHeight 44
#define KDeviceStatusBarHeight 20
#define KDeviceToolBarHeight 44
#define KDeviceBigToolBarHeight 88


#define KToolBarButtonHeight 60
#define KHeaderBarButtonHeight 44
#define KBarButtonWidth 144


#pragma mark - 首页的cell高度

#define kStoreItemWidth         KDeviceWidth/4
#define kStoreItemWidth_space   5
#define KCellHight              kStoreItemWidth *2
#define KCellHeaderHight        30



#define KPhotoKitIsUsed [[UIDevice currentDevice].systemVersion doubleValue]



#define propertyKeyPath(property) (@""#property)
#define propertyKeyPathLastComponent(property) [[(@""#property) componentsSeparatedByString:@"."] lastObject]

#pragma mark - app key
#define Ksalt @"a153a34ac15f4856be224929ed0b547d"
#define KumengAppkey @"55f8d1cfe0f55ad0830020e0"


#pragma mark - key

#define KSERVICE_NAME @"yooyooi"
#define KGROUP_NAME @"YOUR_APP_ID.com.yooyooi.yoosaympose"  // GROUP NAME should start with application
// identifier.


//根据地区获取位置...
#define kCityLocation(longitude, latitude)                               \
  ([NSString stringWithFormat:@"%@location/pos?long=%f&lat=%f", kDomain, \
                              longitude, latitude])



//计算 文字 宽度高度
#define KcalculateContentSize(contentText, width, height, font)         \
              [contentText boundingRectWithSize:CGSizeMake(width, height)\
                                        options:NSStringDrawingUsesLineFragmentOrigin       \
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} \
                                        context:nil].size







