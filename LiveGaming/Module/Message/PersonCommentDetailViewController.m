//
//  PersonCommentDetailViewController.m
//  LiveGaming
//
//  Created by 丁星哲 on 16/3/19.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "PersonCommentDetailViewController.h"
#import "CommentCell.h"
#import "CommentView.h"
#import "CommonMacro.h"
@interface PersonCommentDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
// 用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
// 发布时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//  用户名字
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
//  评论
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
//  文章图片
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
//  文章标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
// 回复框的背景视图
@property (weak, nonatomic) IBOutlet UIView *keyBoardView;
//  回复框
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
//  回复框的底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardBottomConstraint;
@property (strong,nonatomic)CommentView *commentView;
@property (strong,nonatomic)NSMutableArray *detailArray;
@property (assign,nonatomic)NSInteger page;

@property (nonatomic,copy)NSString *articleLink2;    // 文章链接
@property (nonatomic,copy)NSString *userReplyTime;   // 回复时间
@property (nonatomic,copy)NSString *articleTitle;    // 文章标题
@property (nonatomic,copy)NSString *imageStr;        // 头像图片
@property (nonatomic,copy)NSString *articleId;       // 文章Id
@property (nonatomic,copy)NSString *userId;          // 用户Id
@end

@implementation PersonCommentDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (NSMutableArray *)detailArray
{
    if (_detailArray == nil) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.textFiled.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    // 增加监听,当键盘出现或改变时发出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 增加监听,当键盘退出时发出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘视图
    CommentView *backView = [[CommentView alloc]initWithFrame:self.view.frame];
    backView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:.8];
    self.commentView = backView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self.detailArray removeAllObjects];
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self loadData];
    }];

}
#pragma mark - keyBoard 弹出和隐藏
- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    [self showWindow:height];
}
// 展示评论框
- (void)showWindow:(NSInteger)height{
    self.commentView.backView.frame = CGRectMake(0, KSCREENHEIHGT - 180 - height, KSCREENWIDTH, 180);
    [self.commentView.textView becomeFirstResponder];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self.self.commentView];

}
- (void)keyBoardWillHide:(NSNotification *)notification{
    self.keyBoardBottomConstraint.constant = 0;
}
#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentfir = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfir];
    ReplydetailModel *detailModel = self.detailArray[indexPath.row];
    [cell setModels:detailModel];
   return cell;
}
#pragma mark Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark textFiled delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.textFiled resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.textFiled resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)loadData
{
    ReplyDetailApi *replyDetail = [[ReplyDetailApi alloc]initWithUserId:@"6585463E-4A5D-48AA-801A-A785CFA2FF5C" ArticleId:@"89FE610D-8697-4523-8FE4-11748EE1F921" CurrentPage:[NSString stringWithFormat:@"%ld",self.page] RepId:@"08247BC8-E11C-4CD1-80F3-AE4A7AAD8508"];
    [replyDetail startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = request.responseJSONObject;
        if ([dic[@"StateCode"] integerValue] == 1) {
            [self.userImage sd_setImageWithURL:[NSURL URLWithString:dic[@"Image"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            self.timeLabel.text = dic[@"UserReplyTime"];
            self.userNameLabel.text = dic[@"UserName"];
            self.commentLable.text = @"我爱你中国";
            [self.titleImage sd_setImageWithURL:[NSURL URLWithString:dic[@"ArticleLink2"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            self.titleLabel.text = dic[@"ArticleTitle"];
            NSArray *comments = dic[@"ReplyDetailList"];
            for (NSDictionary *commentsDic in comments) {
                ReplydetailModel *detail = [ReplydetailModel yy_modelWithDictionary:commentsDic];
                [self.detailArray addObject:detail];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        
        
        
        
        
    } failure:^(YTKBaseRequest *request) {
        
        
        
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
