//
//  ZYTokenManager.m
//  自定义搜索框并缓存搜索记录
//
//  Created by xiayong on 16/3/11.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "ZYTokenManager.h"
#import "CommonMacro.h"
@implementation ZYTokenManager


//缓存搜索数组
+(void)SearchText :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组
        
    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT addObject:seaTxt];
    if(searTXT.count > 5)
    {
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:searTXT forKey:@"myArray"];
    [userDefaultes synchronize];
}
+(void)removeAllArray{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"myArray"];
    [userDefaults synchronize];
}

+ (CGFloat)contentHeight:(NSString *)content
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake((230/320.0f) * KSCREENWIDTH, MAXFLOAT)
                   
                                        options:NSStringDrawingUsesLineFragmentOrigin
                   
                                     attributes:attributes
                   
                                        context:nil];
    return rect.size.height + 91;
}
+ (CGFloat)contentWight:(NSString *)content
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGRect rect = [content boundingRectWithSize:CGSizeMake((230/320.0f)* KSCREENWIDTH, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
    return rect.size.width;
}


@end
