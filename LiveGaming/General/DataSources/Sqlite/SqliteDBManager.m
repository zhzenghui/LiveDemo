//
//  SqliteDB.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/11/27.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "SqliteDBManager.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "Settings.h"
#import "Common.h"

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]



static SqliteDBManager *shareManager = nil;


@interface SqliteDBManager() {
    
}

@property (assign, nonatomic) BOOL isModify;

@property (strong, nonatomic) FMDatabaseQueue * dbQueue;

@end

@implementation SqliteDBManager

static NSString *const DEFAULT_DB_NAME = @"database.sqlite";

#pragma mark -
#pragma mark 创建数据库连接
+ (SqliteDBManager *)instance
{
    @synchronized ([SqliteDBManager class]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            shareManager = [[[self class] alloc] initWithDBWithPath:KDefaultDATABASEPath];
        });
    }
    return shareManager;
}
- (id)init {
    return [self initWithDBWithPath:KDefaultDATABASEPath];
}

- (id)initDBWithName:(NSString *)dbName {
    self = [super init];
    if (self) {
        NSString * dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:dbName];
        DLog(@"dbPath = %@", dbPath);
        if (_dbQueue) {
            [self close];
        }
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        _isModify = NO;

    }
    return self;
}

- (id)initWithDBWithPath:(NSString *)dbPath {
    self = [super init];
    if (self) {
        DLog(@"dbPath = %@", dbPath);
        if (_dbQueue) {
            [self close];
        }
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        _isModify = NO;

    }
    return self;
}

- (void)close {
    [_dbQueue close];
    _dbQueue = nil;
}

#pragma mark - 

- (void)updateSqliteDBStructure {
//     判断根据
//     *****主意数据字段应该尽力不做删除字段的操作
//     1. 获取本地数据库版本
//     2. 读取本地sqllite_structure 的版本号
//     3. 判断相同处理完成
//     4. 判断结果不同，则从该号码开始一次执行 sql语句来更新数据库结构
//     测试用的
//    [[Settings instance] setLocalAppSqliteStructureVersion:@(1)];
    int localAppSqliteStructureVersion = [[[Settings instance] localAppSqliteStructureVersion] intValue];
    int appSqliteStructureVersion = [[[Settings instance] appSqliteStructureVersion] intValue];
    DLog(@"localAppSqliteStructureVersion：%@； \
         appSqliteStructureVersion:%@", @(localAppSqliteStructureVersion), @(appSqliteStructureVersion));
    DLog(@"%@",  appSqliteStructureVersion > localAppSqliteStructureVersion ? @"更新本地数据结构": @"不更新本地数据结构")
    
    if (appSqliteStructureVersion > localAppSqliteStructureVersion) { //更新
        DLog(@"执行数据库结构更新");
        _isModify = YES;
        [self updateSqliteDBStructureSQL];
        _isModify = NO;
    }
    else { // 不更新
        DLog(@"不需要执行数据库结构更新");
    }
    
    
}

- (void)updateSqliteDBStructureSQL {
    NSString *appSql = [[NSBundle mainBundle] pathForResource:@"sqlite_structure" ofType:@"plist"];
    NSArray *sqlArray = [NSArray arrayWithContentsOfURL: [NSURL fileURLWithPath:appSql]];
    
    int appSqliteStructureVersion = [[[Settings instance] appSqliteStructureVersion] intValue];
    int localAppSqliteStructureVersion = [[[Settings instance] localAppSqliteStructureVersion] intValue];
    
    if (localAppSqliteStructureVersion > 0) {
        localAppSqliteStructureVersion++;
    }
    
    for (int i = localAppSqliteStructureVersion; i <= appSqliteStructureVersion; i++) {
        
        NSDictionary *sqlDict = sqlArray[i];
        NSString *version = sqlDict[@"version"];
        NSString *sql = sqlDict[@"sql"];
        BOOL resoult = [self executeUpdate:sql];
        if (resoult) {
            DLog(@"version:%@",  version);
            DLog(@"执行sql成功");
            [[Settings instance] setLocalAppSqliteStructureVersion:@(appSqliteStructureVersion)];
        }
        else {
            DLog(@"version:%@",  version);
            DLog(@"执行sql失败");
        }
    }
    
}



+ (void)copyDB
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* realPath = KDefaultDATABASEPath;
    NSString * srcPath = [[NSBundle mainBundle] pathForResource:KDATABASE_NAME ofType:nil];
    
    if (![fileManager fileExistsAtPath:realPath])
    {
        NSError * error;
        if (![fileManager copyItemAtPath:srcPath toPath:realPath error:&error])
        {
            DLog(@"Login basedata.s3db open error: %@", error);
        }
    }
}

#pragma mark - execute Update data

- (BOOL)executeUpdate:(NSString *)sql {
    
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        DLog(@"ERROR, failed to insert/replace into table: %@", sql);
    }
    return result;

}

//  写入，更新，删除数据
- (void)executeFromSql:(NSString *)sql {
    
    if ( _isModify ) {
        return;
    }
    
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        DLog(@"ERROR, failed to insert/replace into table: %@", sql);
    }
}

//  搜索数据
//  单挑数据
//  多条数据
- (FMResultSet *)getObjectOrObjects:(NSString *)sql {
    if ( _isModify ) {
        return nil;
    }
    
    __block FMResultSet * rs;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        rs = [db executeQuery:sql];
        [rs close];

    }];
    return rs;
}



#pragma mark -

- (NSString *)insertFromJsonDict:(NSDictionary *)jsonDict tableName:(NSString *)tableName {
    
    NSMutableString *sql = [NSMutableString string];
    
    
    [sql appendString:@"REPLACE INTO "];
    [sql appendString:tableName];
    [sql appendString:@"("];
    for (NSString *key in jsonDict.allKeys) {
        [sql appendFormat:@"%@,", key];
    }
    
    sql = [[sql substringWithRange:NSMakeRange(0, sql.length-1)] mutableCopy];
    [sql appendString:@")"];
    [sql appendString:@"VALUES "];
    [sql appendString:@"("];
    for (NSString *key in jsonDict.allValues) {
        [sql appendFormat:@"'%@',", key];
    }
    
    sql = [[sql substringWithRange:NSMakeRange(0, sql.length-1)] mutableCopy];
    [sql appendString:@")"];
    
    return sql;
}


- (NSString *)updateFromJsonDict:(NSDictionary *)jsonDict tableName:(NSString *)tableName whereFiled:(NSString *)whereFiled{
    
    NSMutableString *sql = [NSMutableString string];
        
    [sql appendString:@"UPDATE "];
    [sql appendString:tableName];
    [sql appendString:@" SET "];

    for (int i = 0; i<jsonDict.count; i++) {
        
        [sql appendFormat:@"%@ = '%@',", jsonDict.allKeys[i], jsonDict.allValues[i]];
    }
    
    sql = [[sql substringWithRange:NSMakeRange(0, sql.length-1)] mutableCopy];

    
    if (whereFiled) {
        [sql appendFormat:@"where %@ ='%@'",whereFiled, jsonDict[whereFiled]];
    }
    
    return sql;

}


- (NSString *)updateFromJsonDict:(NSDictionary *)jsonDict tableName:(NSString *)tableName whereFileds:(NSArray *)whereFileds {
     return @"";
}


- (NSString *)updateFromJsonDict:(NSDictionary *)jsonDict
                       tableName:(NSString *)tableName
                    updateFileds:(NSArray *)updateFileds
                      whereFiled:(NSString *)whereFiled {
        return @"";
    
}

- (NSString *)updateFromJsonDict:(NSDictionary *)jsonDict
                       tableName:(NSString *)tableName
                     updateFiled:(NSString *)updateFiled
                      whereFiled:(NSString *)whereFiled {
    return @"";
}

@end
