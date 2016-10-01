//
//  ShoppingCartViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/24.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShopCartCell.h"
#import "ShopCartCell2.h"
#import "ShopCartModel.h"

static NSString *const identify1 = @"ShopCartCell";
static NSString *const identify2 = @"ShopCartCell2";

@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,ShopCartCell2Delegate>
{
    BOOL isSelected;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIView *bottomView;

@end

@implementation ShoppingCartViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    [self setNavBackItem];
    [self loadData];
    [self setUI];
}

- (void)loadData{
    
    [SVProgressHUD show];
    [HTTPTool GET:ShopCartList_URL headers:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject---%@",responseObject);
            [SVProgressHUD dismiss];
        self.dataArray = [ShopCartModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"cartGoodsList"]];
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

- (void)setUI{

    [self.view addSubview:self.tableView];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCartCell" bundle:nil] forCellReuseIdentifier:identify1];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopCartCell2" bundle:nil] forCellReuseIdentifier:identify2];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - setNav

- (void)setNavBackItem{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button addTarget:self action:@selector(leftBackItemClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton.frame = CGRectMake(0, 0, 40, 40);
        [selectedButton addTarget:self action:@selector(tapSelected:) forControlEvents:UIControlEventTouchUpInside];
        [selectedButton setImage:[UIImage imageNamed:@"f_check_12x12"] forState:UIControlStateNormal];
        [selectedButton setImage:[UIImage imageNamed:@"f_check_s_15x12"] forState:UIControlStateSelected];
        [cell.contentView addSubview:selectedButton];
        return cell;
    }
    if (indexPath.row == 1) {
        ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:identify1 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.model = self.dataArray[indexPath.section];
        return cell;
    }
    if (indexPath.row == 2) {
        ShopCartCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify2 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.model = self.dataArray[indexPath.section];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 44;
    }
    if (indexPath.row == 1) {
        return 171;
    }
    if (indexPath.row == 2) {
        return 73;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001f;
}

#pragma mark - ShopCartCell2Delegate

- (void)didPayButtonClick:(ShopCartCell2 *)cell{
    
    
}

- (void)didDelOrderButtonClick:(ShopCartCell2 *)cell{
    
}

#pragma mark - private Method

- (void)leftBackItemClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapSelected: (UIButton *)button{
    
    button.selected = !button.selected;
    isSelected = button.selected;
    if (isSelected == YES) {
        
        [self.view addSubview:self.bottomView];
        self.tableView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 44 - 64);
    }
    else{
        [self.bottomView removeFromSuperview];
        self.bottomView = nil;
        self.tableView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
    }
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, K_SCREEN_HEIGHT - 44 - 64, K_SCREEN_WIDTH, 44)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

@end
