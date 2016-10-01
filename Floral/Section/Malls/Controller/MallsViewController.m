//
//  MallsViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/12.
//  Copyright © 2016年 思 彭. All rights reserved.
// 商城界面

#import "MallsViewController.h"
#import "UIImage+Rotate.h"
#import "UIBarButtonItem+Create.h"
#import "SDCycleScrollView.h"
#import "ScrollImageModel.h"
#import "Top10View.h"
#import "JiFengViewController.h"
#import "DetailCollectionViewCell.h"
#import "HeaderView.h"
#import "JingXuanCell.h"
#import "JiFengCell.h"
#import "JingXuanModel.h"
#import "ShangChengCell.h"
#import "ShopModel.h"
#import "MallDetailViewController.h"
#import "ShangChengVIew.h"
#import "JIFengModel.h"

@interface MallsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate,headViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
{
    UIView *lineView;
    NSInteger btnTag;
    UICollectionViewFlowLayout *layout;
    UIView *maskView;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *shopDataArray;
@property (nonatomic,strong) NSMutableArray *jiFenDataArray;

@property (nonatomic,strong) Top10View *top10View;
@property (nonatomic,strong) UICollectionView *collectionView; // 积分
@property (nonatomic,strong) UICollectionView *JXCollectionView;// 精选
@property (nonatomic,strong) UICollectionView *shopCollectionView; // 商城
@property (nonatomic,strong) HeaderView *headerView;
@property (nonatomic,strong) ShangChengVIew *shangChengHeadView;
@property (nonatomic,strong) UISearchBar *searchBar;

@end

@implementation MallsViewController

#pragma mark - life cycle

- (void)viewDidLoad{
    btnTag = 1;
    [super viewDidLoad];
    [self requestScrollViewData];
    [self setNav];
    [self createUI];
}

#pragma mark - setUI

- (void)createUI{

    [self createJingXuanCollectionView];
    [self loadData];
}

#pragma mark - requestData

// "精选"数据请求
- (void)loadData{
    
    [SVProgressHUD show];
    [HTTPTool GET:ShopJingXuanList_URL headers:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject---%@",responseObject);
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        if ([responseObject[@"msg"] isEqualToString:@"操作成功"]) {
            [SVProgressHUD dismiss];
            self.dataArray = [JingXuanModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
//        [self.view addSubview:self.collectionView];
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

// "积分"数据请求
- (void)loadJiFengData{
    
    [SVProgressHUD show];
    [HTTPTool GET:JiFenList_URL headers:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject---%@",responseObject);
        if (self.jiFenDataArray.count > 0) {
            [self.jiFenDataArray removeAllObjects];
        }
//        if ([responseObject[@"msg"] isEqualToString:@"操作成功"]) {
            [SVProgressHUD dismiss];
            self.jiFenDataArray = [JIFengModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
//            [self.view addSubview:self.collectionView];
            [self.collectionView reloadData];
//        }
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

// "商城"数据请求
- (void)loadShopData{
    
    [SVProgressHUD show];
    [HTTPTool GET:ShangChengList_URL headers:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject---%@",responseObject);
        if (self.shopDataArray.count > 0) {
            [self.shopDataArray removeAllObjects];
        }
        if ([responseObject[@"msg"] isEqualToString:@"操作成功"]) {
            [SVProgressHUD dismiss];
            self.shopDataArray = [ShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
//            [self.view addSubview:self.collectionView];
            [self.collectionView reloadData];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - 请求轮播视图数据

- (void)requestScrollViewData{
    
    [SVProgressHUD show];
    [HTTPTool GET:Mall_Images_URL headers:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject---%@",responseObject);
        if ([responseObject[@"msg"] isEqualToString:@"操作成功"]) {
            [SVProgressHUD dismiss];
            self.dataArray = [ScrollImageModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self dealScrollViewImage];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

/**
 处理轮播图片
 */

- (void)dealScrollViewImage{
    NSMutableArray *imageArray = [NSMutableArray array];
    for (ScrollImageModel *model in self.dataArray) {
        [imageArray addObject:model.fnImageUrl];
    }
    self.headerView.imageArray = [imageArray copy];
}

#pragma mark - 创建collectionView

// 加载精选collectionView
- (void)createJingXuanCollectionView{
    
    CGFloat space = 10;
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(K_SCREEN_WIDTH, 250);
    layout.minimumLineSpacing = space;
    layout.minimumInteritemSpacing = space;
    layout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - K_STATUS_BAR_AND_NAVI_BAR_HEIGHT) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"JingXuanCell" bundle:nil] forCellWithReuseIdentifier:@"JingXuanCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ShangChengCell" bundle:nil] forCellWithReuseIdentifier:@"ShangChengCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"JiFengCell" bundle:nil] forCellWithReuseIdentifier:@"JiFengCell"];
    [self.collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
     [self.collectionView registerClass:[ShangChengVIew class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ShangChengView"];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (btnTag == 2) {
        return self.shopDataArray.count;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (btnTag == 1) {
        return self.dataArray.count;
    }
    if (btnTag == 2) {
        ShopModel *model = self.shopDataArray[section];
        return model.childrenList.count;
    }
    if (btnTag == 3) {
        
        return self.jiFenDataArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (btnTag == 1) {
        JingXuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JingXuanCell" forIndexPath:indexPath];
        if (self.dataArray.count > 0) {
            
            cell.model = self.dataArray[indexPath.row];
        }
        return cell;
    }
    if (btnTag == 2) {
        
        ShangChengCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangChengCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        ShopModel *model = self.shopDataArray[indexPath.section];
        childrenList *childList = (childrenList*)model.childrenList[indexPath.row];
        pGoods *goodModel = childList.pGoods;
        cell.model = goodModel;
        return cell;
    }
    if (btnTag == 3) {
        
            JiFengCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JiFengCell" forIndexPath:indexPath];
            if (self.jiFenDataArray.count > 0) {
                
                cell.model = self.jiFenDataArray[indexPath.row];
                return cell;
        }
        return nil;
    }

    else{
        return [[UICollectionViewCell alloc]init];
    }
}

#pragma mark - UICollectionViewDelegate

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        if (kind == UICollectionElementKindSectionHeader) {
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            self.headerView.backgroundColor = [UIColor yellowColor];
            self.headerView.delegate = self;
            return self.headerView;
        }
    }
    if (indexPath.section == 1) {

        return nil;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        if (btnTag == 1) {
            
            return (CGSize){K_SCREEN_WIDTH - 20,230};
        }
        if (btnTag == 2) {
            
            return (CGSize){(K_SCREEN_WIDTH - 10) / 2,230};
        }
        if (btnTag == 3) {
            
            return (CGSize){(K_SCREEN_WIDTH - 10) / 2,230};
        }
        else
            
            return (CGSize){0,0};
    }
    return CGSizeZero;
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (btnTag == 1) {
        
        return UIEdgeInsetsMake(0,0,0,0);
    }
    if (btnTag == 2) {
        
        return UIEdgeInsetsMake(0,0,0,0);
    } if (btnTag == 3) {
        
        return UIEdgeInsetsMake(0,0,0,0);
    }
    else
        return UIEdgeInsetsMake(0,0,0,0);

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (btnTag == 1) {
       
        MallDetailViewController *mallDetailVc = [[MallDetailViewController alloc]init];
        mallDetailVc.model = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:mallDetailVc animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (btnTag == 1) {
        return CGSizeMake(K_SCREEN_WIDTH, 250);
    }
    if (btnTag == 2) {
        return CGSizeMake((K_SCREEN_WIDTH - 15) / 2, (K_SCREEN_WIDTH - 15) / 2);
    }
    if (btnTag == 3) {
        return CGSizeMake((K_SCREEN_WIDTH - 15) / 2, (K_SCREEN_WIDTH - 15) / 2 + 50);
    }
    return CGSizeZero;
}

#pragma mark - SetNav

- (void)setNav{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"menu"]imageByRotateRight90] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"f_search"] highLightedImage:nil target:self action:@selector(rightSeachItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - headViewDelegate

- (void)didTagButton:(NSInteger)buttonTag{
    
    btnTag = buttonTag;
    if (btnTag == 1) {
        [self loadData];
    }
    if (btnTag == 2) {
        [self loadShopData];
    }
    if (btnTag == 3) {
        [self loadJiFengData];
    }
    [self.collectionView reloadData];
}

#pragma mark - SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}


#pragma mark - private method

- (void)leftItemClick{
    
}

- (void)rightSeachItemClick{
    NSLog(@"搜索");
    [self createSearchBar];
    [[UIApplication sharedApplication].keyWindow addSubview:self.searchBar];
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
    self.searchBar.frame = CGRectMake(0, 20, K_SCREEN_WIDTH, 49);
    [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.searchBar.placeholder = @"请输入搜索关键字";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove:)];
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    [maskView addGestureRecognizer:tap];
}

- (void)remove: (UITapGestureRecognizer *)tap{
    
    [maskView removeFromSuperview];
    [self.searchBar removeFromSuperview];
}

// 积分换取
- (void)jiFengGet: (UIButton *)button{
    
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)shopDataArray{
    
    if (!_shopDataArray) {
        _shopDataArray = [NSMutableArray array];
    }
    return _shopDataArray;
}

- (NSMutableArray *)jiFenDataArray{
    
    if (!_jiFenDataArray) {
        _jiFenDataArray = [NSMutableArray array];
    }
    return _jiFenDataArray;
}

@end
