//
//  SelectCountryViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/9.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "SelectCountryViewController.h"
#import "SelectCountryCell.h"
#import "WHOrderedDictionary.h"

static NSString *const identifier = @"SelectCountryCell";

@interface SelectCountryViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSDictionary *rootDict;
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation SelectCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择国家和地区";
    [self loadData];
    [self setsearch];
    [self createTableView];
}

#pragma mark - loadData

- (void)loadData{
  
    rootDict = [WHOrderedDictionary dictionary];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"country" ofType:@"plist"];
    rootDict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"rootDic = %@",rootDict);
    [self.tableView reloadData];
}

#pragma mark - setUpUI

- (void)createTableView{
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    self.tableView.tableHeaderView = self.searchBar;
    [self registerCell];
}

- (void)registerCell{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SelectCountryCell class]) bundle:nil] forCellReuseIdentifier:identifier];
}

//添加搜索框
- (void)setsearch {
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.searchBar.placeholder = @"搜索国家和地区";
    [self.searchBar sizeToFit];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.navigationController.navigationBar addGestureRecognizer:tap];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [rootDict allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *allKeys = rootDict.allKeys;
    NSArray *array = rootDict[allKeys[section]];
    return array.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *allKeys = rootDict.allKeys;
    NSArray *array = rootDict[allKeys[indexPath.section]];
    NSString *countryString =  array[indexPath.row];
    NSArray *separatedArray = [countryString componentsSeparatedByString:@"+"];
    cell.countryLabel.text = [separatedArray firstObject];
    cell.countryNumberLabel.text = [NSString stringWithFormat:@"+%@",[separatedArray lastObject]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *allKeys = rootDict.allKeys;
    NSArray *array = rootDict[allKeys[indexPath.section]];
    NSString *countryString =  array[indexPath.row];
    if (self.selectCountryblock) {
        self.selectCountryblock(countryString);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSArray *allKeys = rootDict.allKeys;
    NSArray *array = rootDict[allKeys[section]];
    if (array.count > 0) {
        
        return 30;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSArray *allKeys = rootDict.allKeys;
    NSArray *array = rootDict[allKeys[section]];
    if (array.count > 0) {
        
        return allKeys[section];
    }
    return nil;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return  rootDict.allKeys;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = YES;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}

//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    NSString *searchText = searchBar.text;
    NSArray *allKeys = rootDict.allKeys;
    
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    for (NSInteger i = 0; i < allKeys.count; i++) {
        
        NSArray *array = rootDict[allKeys[i]];
        for (NSString *str in array) {
            if ([str hasPrefix:searchText]) {
                
                [self.dataArray addObject:str];
            }
        }
        [self.tableView reloadData];
    }
    [searchBar resignFirstResponder];
}

#pragma mark - private Method

- (void)tapClick:(UITapGestureRecognizer *)tap {
    
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    [self.searchBar removeFromSuperview];
}


#pragma mark - lazy Loading

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


@end
