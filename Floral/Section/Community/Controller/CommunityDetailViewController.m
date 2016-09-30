//
//  CommunityDetailViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "CommunityDetailViewController.h"
#import "UIBarButtonItem+Create.h"
#import "TieZiListModel.h"
#import "DetailCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CommentListCell.h"
#import "CommentModel.h"

static NSString *const identify = @"DetailCell";
static NSString *const commentIdentify = @"CommentCell";

@interface CommunityDetailViewController ()<UITableViewDataSource,UITableViewDelegate,DetailCellDelegate,UIActionSheetDelegate,CommentCellDelegate,UITextFieldDelegate>
{
    NSInteger pageSize;
    NSInteger currentPageIndex;
    UIView *bgView;
    UITextField *commentTF;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *commentDataArray;

@end

@implementation CommunityDetailViewController

#pragma mark - life Cycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    currentPageIndex = 0;
    pageSize = 10;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPageIndex = 0;
    pageSize = 10;
    [self setNavItem];
    [self loadCommentListData];
    [self addRefresh];
    [self createUI];
    [self createBottomView];
    self.title = @"帖子详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //监听 键盘升起时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听 键盘下落时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 加载数据

- (void)loadCommentListData{
    
    [SVProgressHUD show];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%ld",pageSize];
    NSString *currentIndexStr = [NSString stringWithFormat:@"%ld",currentPageIndex];
    NSDictionary *param = CommentListParameter(currentIndexStr, @"getBbsList", pageSizeStr, @"ee995481-3a02-45f1-889f-348d737a9336", @"aae0fcc8-d3f3-4558-befd-f98ff8f71d52");
    [HTTPTool POST:CommentList_URL headers:nil parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
       
        self.commentDataArray = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self createUI];
        [self.tableView reloadData];
        [self.tableView .mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView .mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}

#pragma mark - 添加刷新

- (void)addRefresh{
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPageIndex = 0;
        [self loadCommentListData];
    }];;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        currentPageIndex = 0;
        pageSize = pageSize + 10;
        [self loadCommentListData];
    }];
}

#pragma mark - createUI

- (void)createUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 44 - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:identify];
     [self.tableView registerNib:[UINib nibWithNibName:@"CommentListCell" bundle:nil] forCellReuseIdentifier:commentIdentify];
}

#pragma mark - 添加底部视图

- (void)createBottomView{

    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, K_SCREEN_HEIGHT - 44 - 64 , K_SCREEN_WIDTH, 44)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    commentTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, bgView.width - 20 - 60, bgView.height - 20)];
    commentTF.placeholder = @"评论";
    commentTF.delegate = self;
    commentTF.borderStyle = UITextBorderStyleRoundedRect;
    commentTF.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:commentTF];
    // 发送按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(commentTF.right + 10, 10, 40, 20);
    [button setTitle:@"发送" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [bgView addSubview:button];
}

#pragma mark - setNav

- (void)setNavItem{
    
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highLightedImage:nil target:self action:@selector(backItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }
    else{
        return self.commentDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        cell.delegate = self;
        return cell;
    }
    else{
        CommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentify forIndexPath:indexPath];
        cell.model = self.commentDataArray[indexPath.row];
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 10;
    }
    else{
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        return 70;
    }
//    return [tableView fd_heightForCellWithIdentifier:identify cacheByIndexPath:indexPath configuration:^(id cell) {
//        
//        [self configureTableViewCell:cell atIndexPath:indexPath];
//    }];
    return self.model.cellHeight;
    
}

- (void)configureTableViewCell:(id)cell atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [cell isKindOfClass:[DetailCell class]]) {
        DetailCell *detailCell = (DetailCell *)cell;
        detailCell.fd_enforceFrameLayout = NO;
        detailCell.model = self.model;
    }
}
    
    
#pragma mark - DetailCellDelegate

- (void)DidClickMoreButton:(DetailCell *)cell{

    [self didMoreButton];
}

#pragma mark - CommentCellDelegate

- (void)didClickMoreButton:(CommentListCell *)cell{
    
    [self didMoreButton];
}

- (void)didReplyButton:(CommentListCell *)cell{
    
    NSLog(@"点击回复");
    [commentTF becomeFirstResponder];
}

- (void)didMoreButton{
    
    NSLog(@"更多");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *titleStr = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([titleStr isEqualToString:@"举报"]) {
        NSLog(@"举报");
        [SVProgressHUD showSuccessWithStatus:@"已举报"];
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - private method

- (void)backItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 键盘

-(void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue];
    [UIView animateWithDuration:duration animations:^{
        
        bgView.frame = CGRectMake(0, K_SCREEN_HEIGHT - height - 100, K_SCREEN_WIDTH, 44);
    }];
}

-(void)keyboardWillHide:(NSNotification *)aNotification {

    bgView.frame = CGRectMake(0, K_SCREEN_HEIGHT - 44 - 64 , K_SCREEN_WIDTH, 44);
}

#pragma mark - 懒加载

- (NSMutableArray *)commentDataArray{
    
    if (!_commentDataArray) {
        _commentDataArray = [NSMutableArray array];
    }
    return _commentDataArray;
}

@end
