//
//  MyViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/11.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "MyViewController.h"
#import "UIBarButtonItem+Create.h"
#import "MyHeaderView.h"
#import "MyPublishViewController.h"
#import "MyOrderViewController.h"
#import "SettingViewController.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"思思";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self initWithDataArray];
    [self createTableView];
    [self createHeaderView];
}

#pragma mark - 创建导航栏

- (void)setNav{
   
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highLightedImage:nil target:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"pc_setting_40x40"] highLightedImage:nil target:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initWithDataArray{
   
    self.dataArray = @[@[@"我的发布",@"我的消息"],@[@"我的订单",@"购物车",@"我的积分"],@[@"其他"]];
    self.imageArray = @[@[@"tb_0_selected",@"tb_1_selected"],@[@"tb_2_selected",@"tb_2_selected",@"p_favorite_s_16x15_"],@[@"tb_0_selected"]];
}

- (void)createHeaderView{
    
    MyHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MyHeaderView class]) owner:self options:nil]lastObject];
    headerView.block = ^(){
      
        NSLog(@"更换头像...");
    };
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - createTableView

- (void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = self.dataArray[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"我的发布");
        MyPublishViewController *publishVc = [[MyPublishViewController alloc]init];
        [self.navigationController pushViewController:publishVc animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSLog(@"我的订单");
        MyOrderViewController *orderVc = [[MyOrderViewController alloc]init];
        [self.navigationController pushViewController:orderVc animated:YES];
    }
}

- (void)leftItemClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingButtonClick{
    
    SettingViewController *settingVc = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
@end
