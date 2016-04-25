//
//  NotificationSettingViewController.m
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/8.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import "NotificationSettingViewController.h"
#import "BoolTableViewCell.h"
#import "SettingItem.h"
#import "Settings.h"

@interface NotificationSettingViewController () <UITableViewDataSource,UITableViewDelegate, BoolTableViewCellDelegate>


@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *settings;
@property(nonatomic, strong) NSMutableArray *structure;

@end

@implementation NotificationSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarTitle:@"推送通知"];
    [self addNavBack];
    

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64,0,0,0));
    }];
    
    
    [self loadStructureData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    NSDictionary *rList = self.settings[indexPath.row];
    
    int height = 44;
    
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.structure.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sectionContent = self.structure[section];
    return sectionContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BoolTableViewCell *cell = nil;
    
    static NSString *idinfo = @"cell1";
    
    cell = (BoolTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idinfo];
    if (cell == nil) {
        cell = [[BoolTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idinfo];
        
    }
    
    SettingItem *si = self.structure[indexPath.section][indexPath.row];
    cell.delegate = self;
    [cell setContentCell:si];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *online = self.settings[indexPath.row];
    
    DLog(@"%@", online);
}



#pragma mark -  CustomDelegate

- (void)switchChanger:(SettingItem *)item {

//    设置新的值，并且保存
    [self.manager.settings setValue:@(item.fieldValueBOOL) forKey:item.field];
}
#pragma mark -  event response
#pragma mark -  private methods

- (void)loadStructureData {
    
    
    
    
    //＊＊＊＊＊    隐私
    //  不公开账号
    //  黑名单
    //＊＊＊＊  推送通知
    //  wifi网络上传
    //  高清切换
    //  分享给朋友
    
    
    //＊＊＊  登出
    
    
    // *====================================================
    
    // *====================================================
    //  关于
    //  qq群
    //  联系作者
    //  评价
    //  更新
    //  开源协议
    //  常见问题
    // *====================================================
    
    _structure = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrayPart1  =[[NSMutableArray alloc] init];
//    [arrayPart1 addObject:@"声音"];
    
    
    SettingItem *si = [[SettingItem alloc] init];
    si.fieldName    = @"声音";
    si.field        = propertyKeyPathLastComponent(self.manager.settings.notificationVoiceStatus);
    si.fieldValueBOOL = self.manager.settings.notificationVoiceStatus;
    [arrayPart1 addObject:si];
    
    SettingItem *si2    = [[SettingItem alloc] init];
    si2.fieldName       = @"震动";
    si2.fieldValueBOOL   = self.manager.settings.notificationVibrationStatus;
    si2.field            = propertyKeyPathLastComponent(self.manager.settings.notificationVibrationStatus);

    [arrayPart1 addObject:si2];
    
    //    第一部分的array数据
    [_structure addObject:arrayPart1];
    
//    
//    NSMutableArray *arrayPart2  =[[NSMutableArray alloc] init];
//    
//    [arrayPart2 addObject:@"关于"];
//    
//    //    第二部分的array数据
//    
//    [_structure addObject:arrayPart2];
//    
    
    
    //    NSMutableArray *arrayPart3  =[[NSMutableArray alloc] init];
    //
    //    [arrayPart3 addObject:@"设置"];
    //
    //    //    第三部分的array数据
    //
    //    [_structure addObject:arrayPart3];
    
    
    
}


- (void)loadData {
    
}

#pragma mark -  getters and setters



#pragma mark -  getters and setters
- (UITableView *)tableView {
    
    if ( _tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.backgroundColor = Kbackground;
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource =self;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
        
    }
    return _tableView;
}

@end
