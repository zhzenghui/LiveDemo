//
//  SqliteDB.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/11/27.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


@interface SqliteDBManager : NSObject {
//    FMDatabase *_db;
}

@property(nonatomic,retain)NSDictionary *exceptionInfoDic;

+ (SqliteDBManager *)instance;


- (void)updateSqliteDBStructure;





//  写入，更新，删除数据
- (void)executeFromSql:(NSString *)sql;


//  搜索数据
//  单挑数据
//  多条数据
- (FMResultSet *)getObjectOrObjects:(NSString *)sql;




- (NSString *)insertFromJsonDict:(NSDictionary *)jsonDict tableName:(NSString *)tableName;


- (NSString *)updateFromJsonDict:(NSDictionary *)jsonDict tableName:(NSString *)tableName whereFiled:(NSString *)whereFiled;


- (NSString *)updateFromJsonDict:(NSDictionary *)jsonDict tableName:(NSString *)tableName whereFileds:(NSArray *)whereFileds;


- (NSString *)updateFromJsonDict:(NSDictionary *)jsonDict
                       tableName:(NSString *)tableName
                    updateFileds:(NSArray *)updateFileds
                      whereFiled:(NSString *)whereFiled;

- (NSString *)updateFromJsonDict:(NSDictionary *)jsonDict
                       tableName:(NSString *)tableName
                    updateFiled:(NSString *)updateFiled
                      whereFiled:(NSString *)whereFiled;

@end
