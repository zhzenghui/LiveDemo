//
//  Settings.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/11/24.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


///是否载入图片
#define KloadImageType @"loadImageType"


//文件提供对于全局的所有设置
@interface Settings : NSObject

+ (Settings *)instance;

// 登陆状态

// 是否自动登录

// 网络状态

// 是否载入大数据量的文件，比如图片视频

//
// 是否接受推送
// 推送的声音， 震动
@property(nonatomic, assign) BOOL notificationStatus;
@property(nonatomic, assign) BOOL notificationVoiceStatus;
@property(nonatomic, assign) BOOL notificationVibrationStatus;


@property(nonatomic, assign) BOOL isAutoSaveAlbum;

@property(nonatomic, assign) BOOL isUploadForWWAN;


// 视频，图片 载入设置
// 1 wifi  2， 全部  3， 不自动播放
@property(nonatomic, assign) BOOL isAutoPlay;

// 视频是否使用https播放
@property(nonatomic, assign) BOOL isHttps;





// 自动保存到相册

// 当前用户的身份 vip

// 默认视频的载入的质量

// 广告是否显示

// 设置sdimage缓存大小
// 设置sdimage缓存大小

// 城市

// 坐标

// 当前本地保存的版本

// App 的版本


/**
 *  获取工程的版本号BundleVersion（可配置数字之间的连接符，使用默认传入nil）
 *
 *  @param osType         app类型
 */
- (NSString *)getBundleVersionComponentsJoinedBy:(NSString *)joinStr;

// 是否载入 首次开启展示 lunch

- (void)loadDefauleConfig;




#pragma mark - 高级设置

/**
 *  获取当前App数据库结构版本， 数据库版本 用于检测本地数据的更新
 *
 *  @return 数据库结构版本
 */
- (NSNumber *)appSqliteStructureVersion;

/**
 *  获取本地Cookie的数据库结构版本
 *
 *  @return Cookie数据库结构版本
 */
- (NSNumber *)localAppSqliteStructureVersion;

// 设置本地数据库结构版本
- (void)setLocalAppSqliteStructureVersion:(NSNumber *)version;


// 登录  日期



@end
