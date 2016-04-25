//
//  NotificationViewController.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/16.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationCell.h"
@interface NotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *chatters;
@end

@implementation NotificationViewController

#pragma mark chatters 懒加载
- (NSMutableArray *)chatters
{
    if (!_chatters) {
        _chatters = [[NSMutableArray alloc]init];
    }
    return _chatters;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentfir = @"NotificationCell";
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfir];
    cell.nameLabel.text = @"系统信息";
    cell.timeLabel.text = @"09:20";
    cell.chatLabel.text = @"欢迎加入xxx";
    return cell;
}
#pragma mark Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
