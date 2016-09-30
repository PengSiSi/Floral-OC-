//
//  Top10ViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "Top10ViewController.h"
#import "PublishModel.h"
#import "Top10Cell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UIBarButtonItem+Create.h"

static NSString *const identify = @"Top10Cell";

@interface Top10ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation Top10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"本周排行TOP10";
    [self createUI];
    [self loadData];
    [self setNavItem];
}

- (void)loadData{
    
    [SVProgressHUD show];
    [HTTPTool GET:Top10_URL headers:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (void)createUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"Top10Cell" bundle:nil] forCellReuseIdentifier:identify];
}


#pragma mark - setNav

- (void)setNavItem{
    
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highLightedImage:nil target:self action:@selector(backItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Top10Cell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = VIEW_GRAY_COLOR;
    cell.rank = indexPath.row + 1;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:identify cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self configureTableViewCell:cell atIndexPath:indexPath];
    }];
}

- (void)configureTableViewCell:(Top10Cell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.fd_enforceFrameLayout = NO;
    cell.model = self.dataArray[indexPath.row];
}

#pragma mark - private method

- (void)backItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
