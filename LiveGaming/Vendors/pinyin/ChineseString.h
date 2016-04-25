//
//  ChineseString.h
//  YZX_ChineseSorting
//
//  Created by Suilongkeji on 13-10-29.
//  Copyright (c) 2013年 Suilongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"
#import "Models.h"
@interface ChineseString : NSObject
@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;
@property(retain,nonatomic)Friendlist *friend;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr friends:(NSMutableArray *)friends;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr friends:(NSMutableArray *)friends;



///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr friends:(NSMutableArray *)friends;

@end