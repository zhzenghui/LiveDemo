//
//  LGDViewController.m
//  LiveGaming
//
//  Created by xy on 16/4/25.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "LGDViewController.h"
#import "LGDSettingViewController.h"

@interface LGDViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@end

@implementation LGDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"主页";
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"1.界面流畅优化" class:@"SmoothInterface"];
//    [self addCell:@"2.FFMpeg视频播放器" class:@"LGDPlayerViewController"];
    [self addCell:@"2.ijkFFMpeg视频播放器" class:@"LGDRTMPViewController"];
//    [self addCell:@"Image" class:@"YYImageExample"];
//    [self addCell:@"Text" class:@"YYTextExample"];
//    //    [self addCell:@"Utility" class:@"YYUtilityExample"];
//    [self addCell:@"Feed List Demo" class:@"YYFeedListExample"];
    [self.tableView reloadData];
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
