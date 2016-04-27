//
//  WBFeedCell.m
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "WBStatusCell.h"



@implementation WBStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)prepareForReuse {
    // ignore
}

//- (void)setLayout:(WBStatusLayout *)layout {
//    self.height = layout.height;
//    self.contentView.height = layout.height;
//    _statusView.layout = layout;
//}

@end
