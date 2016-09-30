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

@interface MallsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate,headViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIView *lineView;
    NSInteger btnTag;
    UICollectionViewFlowLayout *layout;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *shopDataArray;
@property (nonatomic,strong) NSMutableArray *jiFenDataArray;

@property (nonatomic,strong) Top10View *top10View;
@property (nonatomic,strong) UICollectionView *collectionView; // 积分
@property (nonatomic,strong) UICollectionView *JXCollectionView;// 精选
@property (nonatomic,strong) UICollectionView *shopCollectionView; // 商城
@property (nonatomic,strong) HeaderView *headerView;

@end

@implementation MallsViewController

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
            [self.collectionView reloadData];
        }
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
        if ([responseObject[@"msg"] isEqualToString:@"操作成功"]) {
            [SVProgressHUD dismiss];
            self.jiFenDataArray = [JingXuanModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        [self.collectionView reloadData];
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
        }
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

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
    else
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (btnTag == 1) {
        JingXuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JingXuanCell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    if (btnTag == 2) {
        
        ShangChengCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShangChengCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
        ShopModel *model = self.shopDataArray[indexPath.section];
        NSArray *childList = model.childrenList;
        cell.model = childList[indexPath.row];
        return cell;
    }
    if (btnTag == 3) {
        
        JiFengCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JiFengCell" forIndexPath:indexPath];
//        cell.model = self.jiFenDataArray[indexPath.row];
        return cell;
    }

    else{
        return [[UICollectionViewCell alloc]init];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (kind == UICollectionElementKindSectionHeader) {
            
            self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            self.headerView.delegate = self;
            return self.headerView;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (btnTag == 1) {
        
        return (CGSize){K_SCREEN_WIDTH,250};
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

- (void)setNav{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [button setImage:[[UIImage imageNamed:@"menu"]imageByRotateRight90] forState:UIControlStateSelected];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"f_search"] highLightedImage:nil target:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
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

- (void)rightItemClick{
    
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
