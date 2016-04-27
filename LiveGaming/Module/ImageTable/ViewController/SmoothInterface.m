//
//  LGDViewController.m
//  LiveGaming
//
//  Created by xy on 16/4/25.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "SmoothInterface.h"
#import "WBModel.h"
#import "YYModel.h"
#import "NSObject+YYModel.h"

@interface SmoothInterface ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@property (nonatomic, strong) NSMutableArray *layouts;

@end

@implementation SmoothInterface

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Example";
//    self.titles = @[].mutableCopy;
//    self.classNames = @[].mutableCopy;
//    [self addCell:@"界面流畅优化" class:@"SmoothInterface"];
////    [self addCell:@"Image" class:@"YYImageExample"];
////    [self addCell:@"Text" class:@"YYTextExample"];
////    //    [self addCell:@"Utility" class:@"YYUtilityExample"];
////    [self addCell:@"Feed List Demo" class:@"YYFeedListExample"];
//    [self.tableView reloadData];
    
    //[self log];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"weibo_0.json"]];
            WBTimelineItem *item = [WBTimelineItem yy_modelWithJSON:data];
            for (WBStatus *status in item.statuses) {
//                WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline];
                //                [layout layout];
//                [_layouts addObject:layout];
            }

        
        // 复制一下，让列表长一些，不至于滑两下就到底了
        [_layouts addObjectsFromArray:_layouts];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = [NSString stringWithFormat:@"Weibo (loaded:%d)", (int)_layouts.count];
//            [indicator removeFromSuperview];
            self.navigationController.view.userInteractionEnabled = YES;
//            [_tableView reloadData];
        });
    });


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
