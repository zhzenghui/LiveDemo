//
//  SettingItem.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/8.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CellType) {

    CellTypeDisclosureIndicator,
    CellTypeBool,
    CellTypeNone,
    CellTypeUser,
};

@interface SettingItem : NSObject

@property(nonatomic, strong) NSString *fieldName;
@property(nonatomic, strong) NSString *field;
@property(nonatomic, strong) NSString *fieldValue;
@property(nonatomic, strong) NSString *relationiewController;
@property(nonatomic, assign) CellType cellType;

@property(nonatomic, assign) BOOL fieldValueBOOL;


@end
