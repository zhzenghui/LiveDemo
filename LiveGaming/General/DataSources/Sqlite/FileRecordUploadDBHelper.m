//
//  UploadFileRecordDBHelper.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/1.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "FileRecordUploadDBHelper.h"
#import "YTKKeyValueStore.h"
#import "SqliteDBManager.h"
//#import "FileRecordModel.h"
#import "Common.h"

#define KUploadFileTableName @"upload_file_table"

@implementation FileRecordUploadDBHelper


//保存本地文件数据

- (void)saveUploadFileInfo:(FileRecordModel *)frm {

//    NSDictionary *frmDict = (NSDictionary *)[frm yy_modelToJSONObject];
//    DLog(@"%@", frmDict);
//    
//    NSString *insertSql = [[SqliteDBManager instance] insertFromJsonDict:frmDict tableName:@"FileRecord"];
//    DLog(@"%@", insertSql);
//    
//    [[SqliteDBManager instance] executeFromSql:insertSql];


}


- (void)updateFileInfo:(FileRecordModel *)frm {
 
//    NSDictionary *frmDict = (NSDictionary *)[frm yy_modelToJSONObject];
//    NSString *updateSql = [[SqliteDBManager instance] updateFromJsonDict:frmDict tableName:@"FileRecord" whereFiled:@"md5"];
//    
//    [[SqliteDBManager instance] executeFromSql:updateSql];
}


- (void)deleteFileInfo:(FileRecordModel *)frm {
    
    
}

@end
