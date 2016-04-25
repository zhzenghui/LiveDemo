//
//  User.h
//  Coolading
//
//  Created by bejoy on 14/10/27.
//  Copyright (c) 2014年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
/**
 ibj 用户对象模型
 */

@interface User : NSObject

/**
 *  工地id
 */
@property(nonatomic, strong) NSString* serveId;


/**
 *  登录设备
 */
@property(nonatomic, strong) NSString* device;

/**
 *
 */
@property(nonatomic, strong) NSString* auth_token;

/**
 *  客户名称
 */
@property(nonatomic, strong) NSString* customName;

/**
 *  昵称
 */
@property(nonatomic, strong) NSString* nickName;



@property(nonatomic, strong) NSString* phoneNumber;


@property(nonatomic, strong) NSString* email;


// 金币数
@property(nonatomic, strong) NSString* coinNum;


/**
 *   性别 1-男 0-女
 */
@property(nonatomic, strong) NSString* sex;
/**
 *  省
 */
@property(nonatomic, strong) NSString *province;
/**
 *  市
 */
@property(nonatomic, strong) NSString *city;

/**
 *  详细地址
 */
@property(nonatomic, strong) NSString *houseAddress;

/**
 *  面积
 *
 */
@property(nonatomic, strong) NSString* houseArea;
/**
 *  装修情况 0-未装修 1-已装修
 */
@property(nonatomic, strong) NSString* houseType;
/**
 *  预算
 */
@property(nonatomic, strong) NSString*  budget;



@property(nonatomic, strong) NSString* type;
@property(nonatomic, strong) NSString* iconPath;
@property(nonatomic, strong) NSDate  * lastLoginTime;
@property(nonatomic, strong) NSString* avatar;
@property(nonatomic, strong) NSString* residential;
@property(nonatomic, strong) NSString* identity;
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* pwd;
@property(nonatomic, strong) NSString* pwd_sha2;
@property(nonatomic, strong) NSString* nPassword;
@property(nonatomic, strong) NSString* oldPassword;

@property(nonatomic, assign) NSInteger indexType;
@property(nonatomic, strong) NSString *loginTime;
@property(nonatomic, strong) NSString *jinbi;
@property(nonatomic, strong) NSString *introduction;



@property (nonatomic, assign) NSInteger likes;

@property (nonatomic, copy) NSString *default_post_format;

@property (nonatomic, assign) NSInteger following;

@property(nonatomic, strong) NSArray *blogs;






@property (nonatomic, copy) NSString *UserID;

@property (nonatomic, copy) NSString *Image;

@property (nonatomic, copy) NSString *PassWord;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Sex;

@property (nonatomic, copy) NSString *IDCard;

@property (nonatomic, copy) NSString *Coin;

@property (nonatomic, copy) NSString *LoginName;

@property (nonatomic, copy) NSString *Email;

@property (nonatomic, copy) NSString *Blog;

@property (nonatomic, copy) NSString *Adress;

@property (nonatomic, copy) NSString *MobilePhone;

@property (nonatomic, copy) NSString *RealName;

@property (nonatomic, copy) NSString *Hobby;

@property (nonatomic, copy) NSString *Introduce;

@property (nonatomic, copy) NSString *LastUpdateTime;

@property (nonatomic, copy) NSString *WeChar;

@property (nonatomic, copy) NSString *Age;

@property (nonatomic, copy) NSString *UserRule;




@end
