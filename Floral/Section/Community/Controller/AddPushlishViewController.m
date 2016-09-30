//
//  AddPushlishViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "AddPushlishViewController.h"
#import "UIBarButtonItem+Create.h"
#import "AddPublisherCell.h"
#import "AddPublishHeaderView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "PublishModel.h"

static NSString *const identify = @"cell";

@interface AddPushlishViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentPageIndex;
    NSInteger pageSize;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIView *maskView;

@end

@implementation AddPushlishViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    pageSize = 10;
    currentPageIndex = 0;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加订阅";
    pageSize = 10;
    currentPageIndex = 0;
    [self setNavItem];
    [self createUI];
    [self createMJRefresh];
//    [self loadData];
    [self createHeaderView];
}

- (void)loadData{
    
    [SVProgressHUD show];
    NSString *currentPageIndexStr = [NSString stringWithFormat:@"%ld",currentPageIndex];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%ld",pageSize];
    NSDictionary *param = PublishParameter(currentPageIndexStr,@"getJianUserList", pageSizeStr, @"ee995481-3a02-45f1-889f-348d737a9336");
    [HTTPTool GET:Publish_URL headers:nil parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        arr = [PublishModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.dataArray addObjectsFromArray:arr];
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}

- (void)createMJRefresh {
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPageIndex = 0;
        [self loadData];
    }];;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        currentPageIndex = 0;
        pageSize += 10;
        [self loadData];
    }];
}

- (void)createUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"AddPublisherCell" bundle:nil] forCellReuseIdentifier:identify];
}

- (void)createHeaderView{
    
    AddPublishHeaderView *headView = [[AddPublishHeaderView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 160)];
    headView.block = ^(){
        NSLog(@"推荐给好友...");
        [self createMaskView];
    };
    self.tableView.tableHeaderView = headView;
}

- (void)createMaskView{

    if (!self.maskView) {
        
        self.maskView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.maskView.backgroundColor = [UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:.8];
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, K_SCREEN_WIDTH, 50)];
        [self.maskView addSubview:buttonView];
        
        // maskView添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeMaskView)];
        [self.maskView addGestureRecognizer:tap];
        // 创建四个按钮
        CGFloat width = K_SCREEN_WIDTH / 4;
        CGFloat height = 50;
        NSArray *imgArray = @[@"s_weixin_50x50",@"s_weibo_50x50",@"s_qq_50x50",@"s_pengyouquan_50x50"];
        for (NSInteger i = 0; i < 4; i++) {
            UIButton *button = [[UIButton alloc]init];
            button.frame = CGRectMake(i * width, 0, width, height);
            [button setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            [buttonView addSubview:button];
        }
        [UIView animateWithDuration:2.0 animations:^{
            
            [self.view addSubview:self.maskView];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AddPublisherCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = VIEW_GRAY_COLOR;
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UILabel *sectionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, K_SCREEN_WIDTH, 50)];
//    sectionTitleLabel.text = @"    用户推荐";
//    sectionTitleLabel.font = [UIFont systemFontOfSize:15];
//    return sectionTitleLabel;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

#pragma mark - setNav

- (void)setNavItem{
    
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highLightedImage:nil target:self action:@selector(backItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

#pragma mark - private method

- (void)backItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)removeMaskView{

    [self.maskView removeFromSuperview];
    self.maskView = nil;
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
