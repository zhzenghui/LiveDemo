//
//  CooladingManager.h
//  Coolading
//
//  Created by bejoy on 14/10/27.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import "CCLog.h"
#import "Cookie.h"
#import "Session.h"
#import "User.h"
#import "YYCache.h"
#import "DEFINE.h"
#import "Device.h"
#import "Settings.h"
#import "UserViewModel.h"
#import "NetWorkStatusManager.h"
#import "ProjectInfomation.h"
#import "AFNetworkReachabilityManager.h"
#import "Localizable.h"

extern NSString* ManagerError;

enum {
  ManagerErrorCommuntitySearchCode,
};




/**
 *  当前客户所处于的流程
 */
typedef NS_ENUM(NSInteger, UserProcessStatus){
    /**
     *  游客没有预约
     */
    UserProcessStatusGuest,
    /**
     *  用户注册，但是没有预约
     */
    UserProcessStatusRegistered,
};


/**
 *  施工状态
 */
typedef NS_ENUM(NSInteger, ConstructionStatus){
    /**
     *  施工前
     */
    ConstructionStatusBefore = 1 ,
};






/**
 *  全局的管理类，包括网络状态，  user session  等信息
 */
@interface Manager : NSObject {

}

@property(nonatomic, strong) UserViewModel *userViewModel;


@property(nonatomic, strong) User *loginUser;
@property(nonatomic, assign) BOOL isLogin;

/**
 *  上传列表
 */
@property(nonatomic, assign) NSMutableArray *uploadFiles;
/**
 *  下载列表
 */
@property(nonatomic, assign) NSMutableArray *downloadFiles;




@property(nonatomic, strong) NSMutableArray *ModuleList;



@property(nonatomic, strong) YYCache *fileCache;


/**
 *  文件缓存
 */
@property(nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;


/**
 *  全局的配置信息
 */
@property(nonatomic, strong) Settings *settings;



+ (Manager*)sharedManager;



@end
