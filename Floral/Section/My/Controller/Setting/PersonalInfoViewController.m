//
//  PersonalInfoViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "UIBarButtonItem+Create.h"
#import "PersonInfoCell.h"
#import "XFDaterView.h"

@interface PersonalInfoViewController ()<UITableViewDataSource,UITableViewDelegate,XFDaterViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString *date;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) XFDaterView *dataPickView;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) NSArray *cityArray;
@property (nonatomic,strong) NSString *proCityStr;
@property (nonatomic,strong) NSString *proNameStr;
@property (nonatomic,strong) NSArray *cityArr;
@property (nonatomic,strong) NSMutableArray *arr1;
@property (nonatomic,strong) NSMutableArray *arr2;


@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setupUI];
    [self initData];
}

- (void)setupUI{
   
    [self.view addSubview:self.tableView];
    // 注册cell
    [self.tableView registerClass:[PersonInfoCell class] forCellReuseIdentifier:@"cell"];
}

- (void)setNav{
    UIBarButtonItem *saveItem = [UIBarButtonItem barButtonItemWithTitle:@"保存" tintColor:[UIColor grayColor] target:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = saveItem;
}

- (void)initData{

    self.dataArray = @[@"",@"昵称",@"性别",@"出生年月",@"所在城市",@"职业",@"个人签名"];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
    self.cityArray = [NSArray arrayWithContentsOfFile:path];
    self.arr1 = [NSMutableArray array];
    self.arr2 = [NSMutableArray array];
    for(int i = 0;i<self.cityArray.count;i++) {
        [self.arr1 addObject:self.cityArray[i][@"state"]];
    }
    NSArray *arr = self.cityArray[0][@"cities"];
    [self.arr2 addObjectsFromArray:[arr mutableCopy]];
}

- (void)saveClick{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PersonInfoCell *cell;
    if (indexPath.section == 0) {
        
       cell = [PersonInfoCell initWithItemName:self.dataArray[indexPath.section] canInput:NO withAvatarImage:YES];
    }
    else if (indexPath.section == 6){
        
        cell = [PersonInfoCell initWithItemName:self.dataArray[indexPath.section] canInput:YES withAvatarImage:NO];
    }
    else{
        cell = [PersonInfoCell initWithItemName:self.dataArray[indexPath.section] canInput:NO withAvatarImage:NO];
    }
    cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:.8];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    // 赋值
    if (indexPath.section == 3) {
        cell.contentLabel.text = date;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 50;
    }
    else if (indexPath.section == 6){
        
        return 100;
    }
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
    // 选择年月日
        _dataPickView=[[XFDaterView alloc]initWithFrame:CGRectZero];
        _dataPickView.delegate=self;
        [_dataPickView showInView:self.view animated:YES];
    }
    // 选择所在城市
    if (indexPath.section == 4) {
        
        [self.view addSubview:self.pickerView];
    }
}

#pragma mark - XFDaterViewDelegate

- (void)daterViewDidClicked:(XFDaterView *)daterView{
    NSLog(@"dateString=%@ ,timeString=%@",daterView.dateString,daterView.timeString);
    date = daterView.dateString;
    [self.tableView reloadData];
}

- (void)daterViewDidCancel:(XFDaterView *)daterView{
    
}

#pragma mark - UIPickViewDataSource


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        
    {
        return self.arr1.count;
    }
    
    else{

        return self.arr2.count;
    }
   
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0)
    {
        return self.arr1[row];
    }
    else {
        return self.arr2[row];
    }
}

#pragma mark delegate 选中行的信息

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        [self.arr2 removeAllObjects];
        NSInteger rowarr1 = [pickerView selectedRowInComponent:0];
        [self.arr2 addObjectsFromArray: self.cityArray[rowarr1][@"cities"]];
        [self.pickerView reloadComponent:1];
    }
    else
    {
        //刷新
        NSString *str = [NSString stringWithFormat:@"%@----%@",self.arr1[[pickerView selectedRowInComponent:0]],self.arr2[[pickerView selectedRowInComponent:1]]];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction  *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction  *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, K_SCREEN_WIDTH - 20, K_SCREEN_HEIGHT - 49 - 64) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

- (UIPickerView *)pickerView{
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, K_SCREEN_HEIGHT - 300, K_SCREEN_WIDTH, 300)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        // 显示选中框
        _pickerView.showsSelectionIndicator=YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}
@end
