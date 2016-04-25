//
//  ZHZBarButton.m
//  
//
//  Created by zeng hui on 15/7/29.
//
//

#import "ZHZBarButton.h"
#import "DEFINE.h"

@implementation ZHZBarButton

- (instancetype)init {
    
    if (self = [super init]) {
        
        float width = KDeviceWidth/2;

        
//        float height = 15;
        
        _tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width , KDeviceToolBarHeight)];
        _tLabel.textAlignment = NSTextAlignmentCenter;
//        _tLabel.backgroundColor = KRed;
        _tLabel.font = [UIFont systemFontOfSize:20];
        _tLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:_tLabel];


    }
    
    return self;
}




- (void)setTitle:(NSString *)title {
    
    _tLabel.text = title;
}

- (void)setSelected:(BOOL)selected {
    
    if (selected ) {
        _tLabel.textColor = Kwhite;
    }
    else {
        _tLabel.textColor = KlightGrayColor;
     
        [UIColor grayColor];
    }
}

//- (void)setImage:(UIImage *)image forState:(UIControlState)state

@end
