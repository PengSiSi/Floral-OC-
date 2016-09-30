//
//  VerifyOrderViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/24.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "VerifyOrderViewController.h"
#import "UIBarButtonItem+Create.h"
#import "VerifyOrderCell0.h"
#import "ModelSizeCell.h"
#import "SumFooterView.h"
#import "MessageCell.h"
#import "NumberCell.h"
#import "SelectedCell.h"

@interface VerifyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSArray *infoArray;

@end

@implementation VerifyOrderViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.infoArray = @[@"匿名配送(我们将为您的购物信息保密,以花田小憩的名义将宝贝送出)",@"需要发票"];
    [self setNav];
    [self createTableView];
    [self createFooterView];
    [self createBottomView];
}


#pragma mark - SetUI

- (void)createTableView{
    
    [self.view addSubview:self.tableView];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"VerifyOrderCell0" bundle:nil] forCellReuseIdentifier:@"VerifyOrderCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ModelSizeCell" bundle:nil] forCellReuseIdentifier:@"ModelSizeCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"NumberCell" bundle:nil] forCellReuseIdentifier:@"NumberCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectedCell" bundle:nil] forCellReuseIdentifier:@"SelectedCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SumFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SumFooterView"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)setNav{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)createFooterView{

    SumFooterView *footerView = [[[NSBundle mainBundle]loadNibNamed:@"SumFooterView" owner:self options:nil]lastObject];
    footerView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, 150);
    self.tableView.tableFooterView = footerView;
}

- (void)createBottomView{

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, K_SCREEN_HEIGHT - 44 - 64, K_SCREEN_WIDTH, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UILabel *sumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH * 2/3, 44)];
    sumLabel.text = @"    合计: 98";
    sumLabel.font = CELL_CONTENT_FONT;
    [bottomView addSubview:sumLabel];
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(sumLabel.right, 0, K_SCREEN_WIDTH - sumLabel.width, 44);
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.backgroundColor = BLACK_COLOR;
    [bottomView addSubview:confirmButton];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 1;
    }
    else if (section == 2){
        return 3;
    }
    else if (section == 3){
        return 2;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        VerifyOrderCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"VerifyOrderCell0" forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"local"];
        cell.textLabel.text = @"请填写您的收货地址";
        cell.textLabel.font = CELL_CONTENT_FONT;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            
            NumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumberCell" forIndexPath:indexPath];
            return cell;
        }
        else if (indexPath.row == 1) {
            
            ModelSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ModelSizeCell" forIndexPath:indexPath];
            return cell;
        }
        else if (indexPath.row == 2) {
            
            MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
            return cell;
        }
    }
    else if (indexPath.section == 3){
    
            SelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedCell" forIndexPath:indexPath];
            cell.contentLabel.text = self.infoArray[indexPath.row];
            return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    else if (indexPath.section == 1){
        return 44;
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 50.0f;
        }
        else if (indexPath.row == 1 ){
            return 44;
        }
        else{
            return 120.0f;
        }
    }
    else if (indexPath.section == 3){
        return 50.0f;
    }
    return 0;
}

#pragma mark - private method

- (void)leftItemClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 44) style:UITableViewStyleGrouped];
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

@end
