//
//  SettingViewController.m
//  
//
//  Created by zeng hui on 15/8/3.
//
//

#import "LGDSettingViewController.h"
#import "MeSettingTableViewCell.h"
#import "NoneTableViewCell.h"
#import "NotificationSettingViewController.h"
#import "BoolTableViewCell.h"
#import "SettingItem.h"
//#import "BlackListViewController.h"
//#import "Message.h"


@interface LGDSettingViewController () <UITableViewDataSource,UITableViewDelegate, BoolTableViewCellDelegate, UIAlertViewDelegate>


@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *settings;
@property(nonatomic, strong) NSMutableArray *structure;

@end

@implementation LGDSettingViewController


#pragma mark -  life cycle


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarTitle:@"设置"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
    
}
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
    
    
    SettingItem *si = self.structure[indexPath.section][indexPath.row];

    switch (si.cellType) {
        case CellTypeNone:
        {
            UITableViewCell *cell;
            
            static NSString *idinfo = @"cell1";
            
            cell = (NoneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idinfo];
            if (cell == nil) {
                cell = [[NoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idinfo];
            }
            
            SettingItem *si = self.structure[indexPath.section][indexPath.row];
            cell.textLabel.text = si.fieldName;
            
            return cell;
            break;
        }
        case CellTypeDisclosureIndicator:
        {
            
            UITableViewCell *cell;
            
            static NSString *idinfo = @"cell2";
            
            cell = (MeSettingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idinfo];
            if (cell == nil) {
                cell = [[MeSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idinfo];
            }
            
            SettingItem *si = self.structure[indexPath.section][indexPath.row];
            cell.textLabel.text = si.fieldName;
            
            return cell;

            break;
        }
        case CellTypeBool:
        {
            BoolTableViewCell *cell;
            
            static NSString *idinfo = @"cell3";
            
            cell = (BoolTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idinfo];
            if (cell == nil) {
                cell = [[BoolTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idinfo];
            }
            
            cell.delegate = self;
            SettingItem *si = self.structure[indexPath.section][indexPath.row];
            [cell setContentCell:si];
            return cell;
            break;
        }
        default:
            break;
    }


    
    return nil;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSDictionary *online = self.settings[indexPath.row];
//    
//    DLog(@"%@", online);
    SettingItem *si = self.structure[indexPath.section][indexPath.row];

    switch (si.cellType) {
        case CellTypeDisclosureIndicator:
        {
            UIViewController *vc = [[NSClassFromString(si.relationiewController) alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

            break;
        }
        case CellTypeNone:
        {
            if ([si.relationiewController isEqualToString:@"cleanallcache"]) {
                [self cleanAllCache];
            }
            
            if ([si.relationiewController isEqualToString:@"loginout"]) {
                [self loginOut];
            }
            
            break;
        }
        default:
            break;
    }
//    switch (indexPath.section) {
//        case 0:
//        {
//            
//            switch (indexPath.row) {
//                case 0:
//                    [self openNotification];
//                    break;
//                case 2:
//                    break;
//                case 3:
//                    
//                    [self openAbout];
//                    break;
//                default:
//                    break;
//            }
//            
//            break;
//        }
//        default:
//            break;
//    }
}

#pragma mark -  Alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self loginOutCleanUserData];
    }
}

#pragma mark -  CustomDelegate

- (void)switchChanger:(SettingItem *)item {
    
    
    //    设置新的值，并且保存
    [self.manager.settings setValue:@(item.fieldValueBOOL) forKey:item.field];

}

#pragma mark -  event response
#pragma mark -  private methods


- (void)loginOut {
    
    DLog(@"登出");
//    [[Message share] messageAlert:@"您确定要登出吗？" delegate:self ];

    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"提示"
                                                 message:@"您确定要登出吗？"
                                                delegate:self
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@"确定", nil];
    [av show];


}

- (void)loginOutCleanUserData {
    
    [self.manager.userViewModel loginOut];
}

- (void)cleanAllCache {
    
    DLog(@"清理所有的缓存文件");
}
                
- (void)openNotification {
    
    NotificationSettingViewController *nsv = [[NotificationSettingViewController alloc] init];
    [self.navigationController pushViewController:nsv animated:YES];
    
}

- (void)settinngAutoSaveAlbum {
    
}

//仅wifi网络上传
- (void)setWifiUplad{
    
}

// 打开关于
- (void)openAbout {
    
}

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

    
    SettingItem *sii1 = [[SettingItem alloc] init];
    sii1.cellType  = CellTypeDisclosureIndicator;
    sii1.relationiewController =  NSStringFromClass( [BaseViewController class] );
    sii1.fieldName = @"黑名单";
    [arrayPart1 addObject:sii1];
    
    
    SettingItem *si = [[SettingItem alloc] init];
    si.field        = propertyKeyPathLastComponent(self.manager.settings.notificationStatus);
    si.fieldValueBOOL = self.manager.settings.notificationStatus;
    si.cellType  = CellTypeDisclosureIndicator;
    si.relationiewController =  NSStringFromClass( [NotificationSettingViewController class] );
    si.fieldName = @"推送通知";
    [arrayPart1 addObject:si];
    
    SettingItem *sii2 = [[SettingItem alloc] init];
    sii2.fieldName = @"自动保存到相册";
    sii2.field        = propertyKeyPathLastComponent(self.manager.settings.isAutoSaveAlbum);
    sii2.fieldValueBOOL = self.manager.settings.isAutoSaveAlbum;
    sii2.cellType  = CellTypeBool;
    [arrayPart1 addObject:sii2];
    
    SettingItem *si1 = [[SettingItem alloc] init];
    si1.fieldName = @"清理缓存";
    si1.fieldValueBOOL = self.manager.settings.isAutoSaveAlbum;
    si1.cellType  = CellTypeNone;
    si1.relationiewController = @"cleanallcache";
    [arrayPart1 addObject:si1];
    
    SettingItem *si2 = [[SettingItem alloc] init];
    si2.fieldName = @"允许2G/3G/4G网络上传";
    si2.field        = propertyKeyPathLastComponent(self.manager.settings.isUploadForWWAN);
    si2.fieldValueBOOL = self.manager.settings.isUploadForWWAN;
    si2.cellType  = CellTypeBool;
    [arrayPart1 addObject:si2];
    
    SettingItem *sii3 = [[SettingItem alloc] init];
    sii3.fieldName = @"自动播放视频";
    sii3.field        = propertyKeyPathLastComponent(self.manager.settings.isAutoPlay);
    sii3.fieldValueBOOL = self.manager.settings.isAutoPlay;
    sii3.cellType  = CellTypeBool;
    [arrayPart1 addObject:sii3];
    
    
    
    [_structure addObject:arrayPart1];
    
    
    NSMutableArray *arrayPart2  =[[NSMutableArray alloc] init];
    SettingItem *si3 = [[SettingItem alloc] init];
    si3.fieldName = @"关于";
    si3.relationiewController =  NSStringFromClass( [UIViewController class] );
    si3.cellType  = CellTypeDisclosureIndicator;
    [arrayPart1 addObject:si3];
    
    [_structure addObject:arrayPart2];
    
    
    NSMutableArray *arrayPart3  =[[NSMutableArray alloc] init];
    SettingItem *si31 = [[SettingItem alloc] init];
    si31.fieldName = @"登出";
    si31.relationiewController =  @"loginout";
    si31.cellType  = CellTypeNone;
    si31.fieldValue = @"";
    [arrayPart3 addObject:si31];
    
    [_structure addObject:arrayPart3];
    

    
    
    
}

- (void)loadData {
    
}

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
