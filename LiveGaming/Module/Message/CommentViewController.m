//
//  CommentViewController.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/15.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentReplyCell.h"
#import "PersonCommentDetailViewController.h"
#import "Models.h"
#import "CommonMacro.h"

@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *replyComments;
@property (nonatomic,assign) NSInteger page;
@end

@implementation CommentViewController
#pragma mark chatters 懒加载
- (NSMutableArray *)replyComments
{
    if (!_replyComments) {
        _replyComments = [[NSMutableArray alloc]init];
    }
    return _replyComments;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self.replyComments removeAllObjects];
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingBlock:^{
        self.page ++;
        [self loadData];
    }];
  
}
#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.replyComments.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *indentfir = @"CommentReplyCell";
    CommentReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfir];
    ReplyCommentModel *commentModel = self.replyComments[indexPath.row];
    cell.nameLabel.text = commentModel.Content;
    cell.timeLabel.text =[[NSDateManager shareInstance] formatterString:commentModel.CreateTime];
    cell.chatLabel.text = commentModel.LastReply;
    if (commentModel.Status == 0) {
        cell.redLabel.hidden = YES;
    }else{
        cell.redLabel.hidden = NO;
        [[NSNotificationCenter defaultCenter]postNotificationName:KMessageNotfification object:self];
    }
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:@"1"] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    return cell;
}
#pragma mark Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Messages" bundle:nil];
    PersonCommentDetailViewController *personCommentVC = [storyBoard instantiateViewControllerWithIdentifier:@"PersonCommentDetailViewController"];
    [self.navigationController pushViewController:personCommentVC animated:YES];
}

- (void)loadData{
    ReplyCommentApi *replyComment = [[ReplyCommentApi alloc]initWithUserId:@"6585463e-4a5d-48aa-801a-a785cfa2ff5c" CurrentPage:[NSString stringWithFormat:@"%ld",self.page ]];
    [replyComment startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *josn = request.responseJSONObject;
        if ([josn[@"StateCode"] integerValue] == 1) {
            NSArray *replyLists = [josn objectForKey:@"ReplyList"];
            for (NSDictionary *replyCommentDic in replyLists) {
                ReplyCommentModel *replyComment = [ReplyCommentModel yy_modelWithDictionary:replyCommentDic];
                [self.replyComments addObject:replyComment];
            }
            [self.tableView reloadData];
        }else{

        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(YTKBaseRequest *request) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
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
