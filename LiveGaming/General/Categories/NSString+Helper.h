//
//  NSString+Helper.h
//  
//
//  Created by zeng hui on 15/9/6.
//
//

#import <Foundation/Foundation.h>


@interface NSString(Helper)

- (NSString *)cleanString;


- (NSString *)urlEscapesString;


- (NSString *)sqliteEscape;


- (NSString *)vienUrlAvailable;

@end
