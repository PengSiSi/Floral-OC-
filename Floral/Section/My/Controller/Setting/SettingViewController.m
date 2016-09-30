//
//  SettingViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/13.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "SettingViewController.h"
#import "ProfileViewController.h"
#import "Setting0Cell.h"
#import "Setting1Cell.h"
#import "SDImageCache.h"
#import "SuggestFeedbackViewController.h"
#import "PersonalInfoViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SettingViewController

#pragma mark - life cycle

//视图将要显示时,重写计算缓存大小
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //刷新表视图
    [_tableView reloadData];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = self.tableView.backgroundColor;
    self.title = @"设置";
    [self initWithData];
    [self createUI];
    [self createBottonButton];
}
#pragma mark - setUI

- (void)createUI{
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Setting0Cell class]) bundle:nil] forCellReuseIdentifier:@"Setting0Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Setting1Cell class]) bundle:nil] forCellReuseIdentifier:@"Setting1Cell"];
    [self.view addSubview:self.tableView];
}

#pragma mark - InitData

- (void)initWithData{
    
    self.dataArray = @[@[@"个人资料",@"账号管理",@"账号绑定",@"积分规则",@"认证规则"],@[@"关于花田小憩",@"商业合作",@"意见反馈",@"给我们评分"],@[@"清理缓存",@"启动推送"]];
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

    if (indexPath.section == 2 && indexPath.row == 0) {
        Setting0Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Setting0Cell" forIndexPath:indexPath];
        [self configureCell:cell indexPath:indexPath];
        [self caculateCache:cell];
        return cell;
    }
    else if (indexPath.section == 2 && indexPath.row == 1){
        Setting1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Setting1Cell" forIndexPath:indexPath];
        [self configureCell:cell indexPath:indexPath];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // 设置cell的弧度
    [self configureCell:cell indexPath:indexPath];
    return cell;
}

- (void)caculateCache: (Setting0Cell *)cell{
   
    //SDImageCache(图片缓存类,单例)
    SDImageCache *imgCache = [SDImageCache sharedImageCache];
    /**
     *  计算缓存大小,使用SDWebImage提供的方法,计算缓存
     */
    NSInteger size = [imgCache getSize];
    cell.clearCacheLabel.text = [NSString stringWithFormat:@"%.1fM",size / 1024 / 1024.0];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 个人资料
    if (indexPath.section == 0 && indexPath.row == 0) {
        PersonalInfoViewController *personVc = [[PersonalInfoViewController alloc]init];
        [self.navigationController pushViewController:personVc animated:YES];
    }
    // 清除缓存
    if (indexPath.section == 2 && indexPath.row == 0) {
        //弹出视图
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:@"是否清除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    // 意见反馈
    if (indexPath.section == 1 && indexPath.row == 2) {
        SuggestFeedbackViewController *suggestVc = [[SuggestFeedbackViewController alloc]init];
        [self.navigationController pushViewController:suggestVc animated:YES];
    }
}

- (void)configureCell: (UITableViewCell *)cell indexPath: (NSIndexPath *)indexPath{
    
    NSArray *arr = self.dataArray[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = CELL_FONT;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *bgView = (UIView *)[cell viewWithTag:125];
    if (!bgView) {
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(cell.frame))];
        bgView.tag = 125;
        bgView.backgroundColor = [UIColor clearColor];
        [cell insertSubview:bgView atIndex:0];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        if (arr.count - 1 == indexPath.row) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(bgView.frame)) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
            maskLayer.frame = bgView.bounds;
            maskLayer.fillColor = [UIColor whiteColor].CGColor;
            maskLayer.strokeColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
            maskLayer.path = maskPath.CGPath;
        }else if (indexPath.row == 0){
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(bgView.frame)) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
            maskLayer.frame = bgView.bounds;
            maskLayer.fillColor = [UIColor whiteColor].CGColor;
            maskLayer.strokeColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
            maskLayer.path = maskPath.CGPath;
        }
        else{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(bgView.frame))];
            maskLayer.frame = bgView.bounds;
            maskLayer.fillColor = [UIColor whiteColor].CGColor;
            maskLayer.strokeColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
            maskLayer.path = maskPath.CGPath;
        }
        [bgView.layer addSublayer:maskLayer];
    }
}

#pragma mark - createBottonButton

- (void)createBottonButton{
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(0, K_SCREEN_HEIGHT - 49 - 64, K_SCREEN_WIDTH, 49);
    bottomButton.backgroundColor =[UIColor blackColor];
    [bottomButton setTitle:@"退出" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //确定按钮被点击
    if (buttonIndex == 1) {
        //清空缓存
        [[SDImageCache sharedImageCache] clearDisk];
        //清空内存中的图片
        [[SDImageCache sharedImageCache] clearMemory];
        //刷新表视图
        [_tableView reloadData];
    }
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, K_SCREEN_WIDTH - 20, K_SCREEN_HEIGHT - 49 - 64) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        [_tableView setSeparatorColor:[UIColor clearColor]];
        _tableView.delegate = self;
     
    }
    return _tableView;
}

- (void)exitButtonClick{
    
    ProfileViewController *profilr = [[ProfileViewController alloc]init];
    [self.navigationController pushViewController:profilr animated:YES];
    
}
@end
