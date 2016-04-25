//
//  FileManager.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/4.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "YYFileManager.h"
#import "YYDiskCache.h"

static YYFileManager *shareManager = nil;


@interface YYFileManager()

@property(nonatomic, strong) YYDiskCache *cachePathDisk;

@end

@implementation YYFileManager

+ (YYFileManager *)instance {
    @synchronized ([YYFileManager class]) {
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
     
        NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
        basePath = [basePath stringByAppendingPathComponent:@"FileCacheLarge"];
        
        YYDiskCache *yy = [[YYDiskCache alloc] initWithPath:[basePath stringByAppendingPathComponent:@"yy"]];
        yy.customArchiveBlock = ^(id object) {return object;};
        yy.customUnarchiveBlock = ^(NSData *object) {return object;};
        
        _cachePathDisk = yy;
    }
    return self;
}

- (void)setImage:(UIImage *)image key:(NSString *)key {
    
    NSData *data = UIImageJPEGRepresentation(image, .9);
    [self setFile:data key:key];
}

- (UIImage *)getImageForKey:(NSString *)key {
    
    NSData *data = [self getFileForKey:key];
    UIImage *image  = [[UIImage alloc] initWithData:data];
    return image;
}

- (void)setVideo:(NSData *)data key:(NSString *)key {

    [self setFile:data key:key];
}

- (void)setVideoWithContentsOfFile:(NSString *)path key:(NSString *)key {
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self setFile:data key:key];
}

- (void)setVideoWithContentsOfURL:(NSURL *)url key:(NSString *)key {
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self setFile:data key:key];
}

- (NSData *)getVideoForKey:(NSString *)key {
    
    NSData *data = [self getFileForKey:key];
    return data;
}

- (void)setFile:(id)objcet key:(NSString *)key {
    
    NSTimeInterval begin, end, time;

    printf("\n===========================\n");
    printf("Disk cache set key-value pairs (value is NSData(100KB))\n");
    
    begin = CACurrentMediaTime();
    [self.cachePathDisk setObject:objcet forKey:key];
    end = CACurrentMediaTime();
    time = end - begin;
    printf("YYKVFile:     %8.2f\n", time * 1000);
}

- (NSData *)getFileForKey:(NSString *)key {
    
   return (NSData *)[self.cachePathDisk objectForKey:key];
}


- (void)removeFileForKey:(NSString *)key {
    
    [self.cachePathDisk removeObjectForKey:key];
}

- (void)removeAllFiles {
    
    [self.cachePathDisk removeAllObjects];
}




@end
