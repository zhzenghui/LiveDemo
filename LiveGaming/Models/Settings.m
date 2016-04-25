//
//  Settings.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/11/24.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "Settings.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "Common.h"
#import "YYModel.h"

/**
 *  当前未升级的sqlite数据库结构的版本， 用于和appSqliteStructureVersion对比来进行数据库升级
 */
static NSString *const LOCAL_APP_STRUCTURE_VERSION = @"LocalAppStructureVersion";
/**
 *  当前sqlite数据库结构的版本
 */
static NSString *const APP_SQLITES_TRUCTURE_VERSION = @"appSqliteStructureVersion";


static Settings *shareManager = nil;

@interface Settings()

@property(nonatomic, strong) NSMutableDictionary *settingsDict;
@property(nonatomic, strong) NSArray *sqliteStructureArray;

@end



@implementation Settings


+ (Settings *)instance
{
    @synchronized ([Settings class]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            shareManager = [[[self class] alloc] init];
        });
    }
    return shareManager;
}

- (id)init {
    self = [super init];
    if (self) {

        
        [self loadConfigForCookie];

    }
    return self;
}

#pragma mark - SDImage
//下载超时
- (void)setLocalImageCache {
    SDImageCache *cache = [SDImageCache sharedImageCache];
    //缓存时长
    cache.maxCacheAge = 60 * 60 * 24* 7;
    //缓存文件大小
    cache.maxCacheSize = 1024 * 1024 * 50;
    //    cache.maxMemoryCost = 1000;
}

//下载超时
- (void)setLocalImageDownloadTimeout{
    //下载超时
    [SDWebImageDownloader sharedDownloader].downloadTimeout = 20;
}



- (NSNumber *)appSqliteStructureVersion {
    
    NSString *ssaSql = [[NSBundle mainBundle] pathForResource:@"sqlite_structure" ofType:@"plist"];
    _sqliteStructureArray = [NSArray arrayWithContentsOfURL:[NSURL fileURLWithPath:ssaSql]];
    
    NSNumber *sqlStrutureVersion = @(0);
    if (_sqliteStructureArray.lastObject) {
        sqlStrutureVersion = _sqliteStructureArray.lastObject[@"version"];
    }
    _sqliteStructureArray = nil;
    return sqlStrutureVersion; //数据库结构每次更新后要更新这个值
}

- (NSNumber *)localAppSqliteStructureVersion {
    NSNumber *localAppSqliteStructureVersion = [Cookie getCookie:LOCAL_APP_STRUCTURE_VERSION];
    if (localAppSqliteStructureVersion) {
        return localAppSqliteStructureVersion;
    }
    return @(0);
}


- (void)setLocalAppSqliteStructureVersion:(NSNumber *)version {
    
    [Cookie setCookie:LOCAL_APP_STRUCTURE_VERSION value:version];
}

#pragma mark -

- (void)setIsAutoSaveAlbum:(BOOL)isAutoSaveAlbum {
    
    
    if (_isAutoSaveAlbum != isAutoSaveAlbum) {
        _isAutoSaveAlbum = isAutoSaveAlbum;
        [self saveSettings:@(isAutoSaveAlbum)];
    }
}


- (void)setIsUploadForWWAN:(BOOL)isUploadForWWAN {
    
    
    if (_isUploadForWWAN != isUploadForWWAN) {
        _isUploadForWWAN = isUploadForWWAN;
        [self saveSettings:@(isUploadForWWAN)];
    }
}


- (void)setIsAutoPlay:(BOOL)isAutoPlay {
    
    
    if (_isAutoPlay != isAutoPlay) {
        _isAutoPlay = isAutoPlay;
        [self saveSettings:@(isAutoPlay)];
    }
}


- (void)setIsHttps:(BOOL)isHttps {
    
    if (_isHttps != isHttps) {
        _isHttps = isHttps;
        [self saveSettings:@(isHttps)];
    }
}

#pragma mark - 通知设置

- (void)setNotificationAllStatus {
    
    _notificationStatus = YES;
    if (_notificationVoiceStatus == NO && _notificationVibrationStatus == NO) {
        _notificationVoiceStatus = NO;
    }
}

- (void)setNotificationVibrationStatus:(BOOL)notificationVibrationStatus {
    
    if (_notificationVibrationStatus != notificationVibrationStatus) {
        _notificationVibrationStatus = notificationVibrationStatus;
        [self setNotificationAllStatus];
        [self saveSettings:@(notificationVibrationStatus)];

    }
}


- (void)setNotificationVoiceStatus:(BOOL)notificationVoiceStatus {
    
    if (_notificationVoiceStatus != notificationVoiceStatus) {
        _notificationVoiceStatus = notificationVoiceStatus;
        [self setNotificationAllStatus];
        [self saveSettings:@(notificationVoiceStatus)];
    }
}

#pragma mark -


/// 获取工程的版本号BundleVersion（可配置数字之间的连接符，使用默认传入nil）
- (NSString *)getBundleVersionComponentsJoinedBy:(NSString *)joinStr
{
    NSString *curVer = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    
    if ((joinStr != nil) && [joinStr isKindOfClass:[NSString class]]) {
        curVer = [[curVer componentsSeparatedByString:@"."] componentsJoinedByString:joinStr];
    }
    
    if (curVer.length <= 0) {
        curVer = @"";
    }
    
    return curVer;
}

- (void)saveSettings:(id)currentItem {
    
    DLog(@"保存设置成功");
    [Cookie setKVCookie:KSettings value:self.yy_modelToJSONString];
}


- (void)loadDefauleConfig {
    
    NSString *appSql = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
    _settingsDict = [NSMutableDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:appSql]];
    _notificationVibrationStatus = NO;
    _notificationVoiceStatus     = NO;
}



- (void)loadConfigForCookie {
    NSString *json = [Cookie getKVCookie:KSettings];
    
    [self yy_modelSetWithJSON:json];
    
    
}




@end
