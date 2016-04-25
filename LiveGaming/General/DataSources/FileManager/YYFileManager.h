//
//  FileManager.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/4.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYFileManager : NSObject

+ (YYFileManager *)instance;

// 保存文件到doc


// 保存文件到cache

/**
 *  保存到DiskCache的image。  注意该方法只能保存jpg对象
 *
 *  @param image  保存的image对象
 *  @param key    文件的键名， 建议使用md5来做键值
 */
- (void)setImage:(UIImage *)image key:(NSString *)key;
- (UIImage *)getImageForKey:(NSString *)key;


/**
 *  保存到DiskCache的mp4
 *
 *  @param data 视频文件的data
 *  @param key  文件的键名， 建议使用md5来做键值
 */
- (void)setVideo:(NSData *)data key:(NSString *)key;
- (void)setVideoWithContentsOfFile:(NSString *)path key:(NSString *)key;
- (void)setVideoWithContentsOfURL:(NSURL *)url key:(NSString *)key;

- (NSData *)getVideoForKey:(NSString *)key;


// 保存文件到DiskCache

- (void)setFile:(id)objcet key:(NSString *)key;

- (NSData *)getFileForKey:(NSString *)key;


- (void)removeFileForKey:(NSString *)key;

- (void)removeAllFiles;


@end
