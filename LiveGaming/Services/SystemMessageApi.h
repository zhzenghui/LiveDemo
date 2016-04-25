//
//  SystemMessage.h
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/29.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import <YTKRequest.h>
@interface SystemMessageApi : YTKRequest
- (id)initWithCurrentPage:(NSString *)currentPage;
@end
