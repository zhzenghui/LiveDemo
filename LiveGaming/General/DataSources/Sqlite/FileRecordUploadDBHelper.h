//
//  UploadFileRecordDBHelper.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/1.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FileRecordModel;
/**
 *  SqliteDBManager 的事例应用
 */
@interface FileRecordUploadDBHelper : NSObject

// 保存新建上传的文件信息
- (void)saveUploadFileInfo:(FileRecordModel *)frm;

// 更新上传文件信息
- (void)updateFileInfo:(FileRecordModel *)frm;


// 删除上传文件信息
- (void)deleteFileInfo:(FileRecordModel *)frm;


@end
