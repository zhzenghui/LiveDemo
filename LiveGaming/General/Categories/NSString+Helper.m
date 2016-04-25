//
//  NSString+Helper.m
//  
//
//  Created by zeng hui on 15/9/6.
//
//

#import "NSString+Helper.h"

@implementation NSString(Helper)


- (NSString *)sqliteEscape; {
    
    NSString *escapeString = [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    return escapeString;
}

- (NSString *)cleanString; {
    
    NSString *str = [self stringByReplacingOccurrencesOfString:@"#" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"*" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"%" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"~" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"!" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"@" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"$" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"%" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"^" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"(" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@")" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"{" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"}" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"[" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"]" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"|" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"/" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"?" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"`" withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"." withString:@""];
    str = [self stringByReplacingOccurrencesOfString:@"# " withString:@""];
    return str;
}


- (NSString *)urlEscapesString; {
    
    NSString *str = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return str;
}

- (NSString *)vienUrlAvailable; {
    
    NSString *str = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    bool available = YES;
    NSString *v_url = self;
    
    
    NSRange r = [v_url rangeOfString:@"/r/thumbs"];
    NSRange rp4 = [v_url rangeOfString:@".mp4"];

    if (r.length > 0) {
        available = NO;
    }
    
    if (rp4.length ==  0) {
        available = NO;
    }
    
    
    if ( ! available) { // 为NO 时 清除url
        str = nil;
    }

    
    return str;
}




@end
