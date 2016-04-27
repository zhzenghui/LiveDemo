//
//  LGDLabel.m
//  LiveGaming
//
//  Created by xy on 16/4/27.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "LGDLabel.h"

@implementation LGDLabel


- (void)setText:(NSString *)text {
    _text = text.copy;
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)contentsNeedUpdated {
    // do update
    [self.layer setNeedsDisplay];
}

#pragma mark - YYAsyncLayer

+ (Class)layerClass {
    return YYAsyncLayer.class;
}

- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
    
    // capture current state to display task
    NSString *text = _text;
    UIFont *font = _font;
    
    YYAsyncLayerDisplayTask *task = [YYAsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer *layer) {
        //...
    };
    
    task.display = ^(CGContextRef context, CGSize size, BOOL(^isCancelled)(void)) {
        if (isCancelled()) return;
//        NSArray *lines = CreateCTLines(text, font, size.width);
//        if (isCancelled()) return;
//        
//        for (int i = 0; i < lines.count; i++) {
//            CTLineRef line = line[i];
//            CGContextSetTextPosition(context, 0, i * font.pointSize * 1.5);
//            CTLineDraw(line, context);
//            if (isCancelled()) return;
//        }
    };
    
    task.didDisplay = ^(CALayer *layer, BOOL finished) {
        if (finished) {
            // finished
        } else {
            // cancelled
        }
    };
    
    return task;
}

@end
