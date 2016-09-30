//
//  ExpandViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/12.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ExpandViewController.h"
#import "UIBarButtonItem+Create.h"
#import "UIImage+Rotate.h"
#import "SectionViewController.h"
#import "ExpandViewController.h"

@interface ExpandViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    BOOL flag[3]; // NO 代表展开  YES 收起
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (assign, nonatomic) BOOL isExpand;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (nonatomic,strong) NSArray *headerArray;

@end

@implementation ExpandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithData];
    [self setNav];
    [self createTableView];
    
}

- (void)setNav{
    
    //    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu"] highLightedImage:nil target:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"menu"]imageByRotateRight90] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"f_search"] highLightedImage:nil target:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)initWithData{
    
    self.dataArray = @[@[@"鲜切花",@"神秘箱"],
                       @[@"花艺课堂"],
                       @[@"花器",@"工具",@"书籍",@"周边"]
                       ];
    self.headerArray = @[@"花植",@"活动",@"杂物"];
}

- (void)createTableView{
    
    [self.view addSubview:self.tableView];
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BOOL f = flag[section];
    // 设置一进来就是折叠状态
    if (!f) { // yes :收起
        return 0;
    }else{
        
        NSArray *arr = self.dataArray[section];
        return arr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isExpand && self.selectedIndexPath == indexPath) {
        return 121;
    } else {
        return 44;
    }
}

//设置组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 50);
    [btn setImage:[UIImage imageNamed:@"hp_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"hp_arrow_up"] forState:UIControlStateSelected];
    // 设置文字在做,按钮在右
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.frame.size.width - btn.imageView.frame.origin.x - btn.imageView.frame.size.width, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -(btn.frame.size.width - btn.imageView.frame.size.width ), 0, 0);
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = section;
    NSString *titleStr = self.headerArray[section];
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return btn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 42;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (void)clickAction:(UIButton *)btn{
    
    //点击时,更改flag数组中元素的状态
    NSInteger index = btn.tag; //0
    flag[index] = !flag[index];
    //刷新所有单元格
    //    [_tableView reloadData];
    //刷新组
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SectionViewController *sectionVc = [[SectionViewController alloc]init];
    [self.navigationController pushViewController:sectionVc animated:YES];
}

#pragma mark - private method

- (void)leftItemClick: (UIButton *)button{
    
    button.selected = !button.selected;
   
}

- (void)rightItemClick{
    
    [self.view addSubview:self.tableView];
}


#pragma mark - 懒加载

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
