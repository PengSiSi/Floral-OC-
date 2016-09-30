//
//  ThemeViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/8.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ThemeViewController.h"
#import "UIBarButtonItem+Create.h"
#import "ThemeCell.h"
#import "ThemeCategoryModel.h"
#import "ThemeListModel.h"
#import "ThemeDetailViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ThemeAvaterDetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "UIImage+Rotate.h"
#import "Top10View.h"
#import "PopOptionsView.h"
#import "VideoViewController.h"
#import "ArticleViewController.h"

static NSString *const identify = @"ThemeCell";

/**
 *  Item的tag值
 */
typedef NS_ENUM(NSUInteger, ItemTag) {
    /**
     *  菜单
     */
    MenuTag,
    /**
     *  主页
     */
    MainTag,
    /**
     *  搜索
     */
    SearchTag,
};

@interface ThemeViewController ()<UITableViewDataSource,UITableViewDelegate,ThemeListDelegate,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,PopOptionsViewDelegate>
{
    UIView *maskView;
    BOOL isCollectionView;
    BOOL TopLine0View;
    NSInteger currentPageIndex;
}

@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) Top10View *top10View;

@end

@implementation ThemeViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    isCollectionView = NO;
    currentPageIndex = 0;
    [self setNav];
    [self createTableView];
    [self createMJRefresh];
}

#pragma mark - loadData

- (void)loadCategory{
    
    [SVProgressHUD show];
    [HTTPTool GET:Category_List_URL headers:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"获取成功"]) {
            self.categoryArray = [[ThemeCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]] mutableCopy];
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
}

- (void)loadData: (NSInteger)currentPageIndex1{
    
    [SVProgressHUD show];
    NSString *currentPageIndexStr = [NSString stringWithFormat:@"%ld",currentPageIndex];
    NSDictionary *param = ThemeListParameter(currentPageIndexStr, @"10");
    [HTTPTool GET:Theme_List_URL headers:nil parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        if ([responseObject[@"msg"] isEqualToString:@"返回列表"]) {
            self.dataArray = [[ThemeListModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]] mutableCopy];
        }
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
        [self loadData:currentPageIndex];
    }];;
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        currentPageIndex++;
        [self loadData:currentPageIndex];
    }];
}

#pragma mark - createTableView

- (void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ThemeCell class]) bundle:nil] forCellReuseIdentifier:identify];
}

#pragma mark - 创建导航栏

- (void)setNav{
    
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu"] highLightedImage:[[UIImage imageNamed:@"menu"] imageByRotateRight90] target:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu"] highLightedImage:nil target:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    rightItem.tag = MainTag;
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"f_search"] highLightedImage:nil target:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    searchItem.tag = SearchTag;
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItems = @[searchItem,rightItem];
    self.navigationItem.titleView = [self titleView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.listModel = self.dataArray[indexPath.section];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:identify cacheByIndexPath:indexPath configuration:^(ThemeCell *cell) {
        
        cell.listModel = self.dataArray[indexPath.section];
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThemeDetailViewController *detailVc = [[ThemeDetailViewController alloc]init];
    detailVc.pageUrl = ((ThemeListModel *)(self.dataArray[indexPath.row])).pageUrl;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - UiCollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UiCollectionViewDelegate

- (UIView *)titleView{
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 49)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((K_SCREEN_WIDTH - 120) / 2, 0, 40, 49)];
    titleLabel.text = @"专题";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:titleLabel];
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(titleLabel.right - 10, 0, 50, 49);
    [titleButton setImage:[UIImage imageNamed:@"hp_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"hp_arrow_up"] forState:UIControlStateSelected];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:titleButton];
    return titleView;
}

#pragma mark - ThemeListDelegate

- (void)didLookButtonClick:(ThemeCell *)cell{
    
    NSLog(@"看看...");
}

- (void)didCommentButtonClick:(ThemeCell *)cell{
  
    NSLog(@"评论...");
}

- (void)didLikeButtonClick:(ThemeCell *)cell{
    
    NSLog(@"点赞...");

}

- (void)didAvaterClick:(ThemeCell *)cell{
    
    NSLog(@"点击头像");
    ThemeAvaterDetailViewController *avaterDetailVc = [[ThemeAvaterDetailViewController alloc]init];
    [self.navigationController pushViewController:avaterDetailVc animated:YES];
}

#pragma mark - PopOptionsViewDelegate

- (void)popOptionsView:(PopOptionsView *)view didSelectOptionAtIndex:(NSUInteger)index{
    if (index == 0) {
        NSLog(@"文章");
        ArticleViewController *articleVc = [[ArticleViewController alloc]init];
        [self.navigationController pushViewController:articleVc animated:YES];
    }
    else{
        NSLog(@"视频");
        VideoViewController *videoVc = [[VideoViewController alloc]init];
        [self.navigationController pushViewController:videoVc animated:YES];
    }
}

#pragma mark - private Method

- (void)leftItemClick{
  
    UIImage *image = [UIImage imageNamed:@"menu"];
    self.navigationItem.leftBarButtonItem.image = [image imageByRotateRight90];
    TopLine0View = !TopLine0View;
    if (TopLine0View == YES) {
        [self.collectionView removeFromSuperview];
        [self.tableView removeFromSuperview];
        self.top10View.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
        [self.view addSubview:self.top10View];
    }
    else{
        [self.top10View removeFromSuperview];
        [self.view addSubview:self.tableView];
    }
}

- (void)itemClick: (UIBarButtonItem *)item{
    
    switch (item.tag) {
        case MenuTag:
            isCollectionView = !isCollectionView;
            NSLog(@"菜单");
            if (isCollectionView == YES) {
                [self.tableView removeFromSuperview];
                [self.view addSubview:self.collectionView];
            }
            else{

                [self.collectionView removeFromSuperview];
                [self.view addSubview:self.tableView];
                isCollectionView = NO;
            }
            break;
        case MainTag:
            NSLog(@"主页");
            break;
        case SearchTag:
        NSLog(@"搜索");
            [self createSearchBar];
            [[UIApplication sharedApplication].keyWindow addSubview:self.searchBar];
            break;
        default:
            break;
    }
}

- (void)createSearchBar{
    
    maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = .5;
    maskView.userInteractionEnabled = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    self.searchBar.backgroundColor = [UIColor redColor];
    self.searchBar.frame = CGRectMake(0, 64, K_SCREEN_WIDTH, 49);
    [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.searchBar.placeholder = @"请输入搜索关键字";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove:)];
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    [maskView addGestureRecognizer:tap];
}

#pragma mark - UISearchBar Delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = YES;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}
//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [self.searchBar removeFromSuperview];
    [maskView removeFromSuperview];
  
}


- (void)titleButtonClick: (UIButton *)button{
    
    button.selected = !button.selected;
    NSLog(@"选择");
    PopOptionsView *popView = [[PopOptionsView alloc]initWithWidth:70 contentHeight:40 delegate:self itemNames:@[@"文章",@"视频"] itemImageNames:nil hasTriangle:YES triangleHeight:7 triangleTopXOffSet:30];
    popView.textFont = [UIFont systemFontOfSize:15.0f];
    popView.frame = CGRectMake((K_SCREEN_WIDTH - 80) / 2 + 5, 0, 100, 50);
    popView.viewBackgroudColor = [UIColor whiteColor];
    popView.textColor = [UIColor grayColor];
    [self.view addSubview:popView];
    
}

- (void)remove: (UITapGestureRecognizer *)tap{

    [maskView removeFromSuperview];
    [self.searchBar removeFromSuperview];
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)categoryArray{
    
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }
    return _categoryArray;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        CGFloat space = 20;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((K_SCREEN_WIDTH - 3 * space)/2, 198);
        layout.minimumLineSpacing = space;
        layout.minimumInteritemSpacing = space;
        layout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - K_STATUS_BAR_AND_NAVI_BAR_HEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
        [self.view addSubview:_collectionView];
        [_collectionView registerNib:[UINib nibWithNibName:@"DetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DetailCollectionViewCell"];
    }
    return _collectionView;
}

#pragma mark - 懒加载

- (Top10View *)top10View{
    
    if (!_top10View) {
        _top10View = [[Top10View alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
    }
    return _top10View;
}
@end
