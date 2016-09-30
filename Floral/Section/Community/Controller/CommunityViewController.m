//
//  CommunityViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "CommunityViewController.h"
#import "AddPushlishViewController.h"
#import "Top10ViewController.h"
#import "SDCycleScrollView.h"
#import "JingXuanCollectionView.h"
#import "ScrollModel.h"
#import "MJRefresh.h"
#import "TieZiListModel.h"
#import "JingXuanCollectionView.h"
#import "CommunityDetailViewController.h"


@interface CommunityViewController ()<JingXuanCollectionViewDelegate>

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) JingXuanCollectionView *jingXuanView;
@property (nonatomic,strong) NSMutableArray *dataMArray;

@end

@implementation CommunityViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.jingXuanView.collectionView.mj_header beginRefreshing];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self createTopView];
    [self createJingXuanView];
    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        [weakSelf requestScrollViewData];
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        [weakSelf loadData];
//    });
     [weakSelf requestScrollViewData];
     [weakSelf loadData];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - requestData

- (void)requestScrollViewData{
    [SVProgressHUD show];
    // 注意block中的循环引用,崩溃在SVProgress中的问题
    __weak typeof(self) weakSelf = self;
    [HTTPTool GET:Community_Scroll_URL headers:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject---%@",responseObject);
//        [SVProgressHUD dismiss];
        self.dataArray = [ScrollModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 注意在主线程赋值  否则崩溃
            weakSelf.jingXuanView.dataArray = self.dataMArray;
            [weakSelf dealScrollViewImage];
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)dealScrollViewImage{
    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *imageArray = [NSMutableArray array];
    for (ScrollModel *model in self.dataArray) {
        [imageArray addObject:model.imageUrl];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.jingXuanView.reusableView.imgArray = [imageArray copy];
    });
}

- (void)loadData{
    
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    NSDictionary *param = TieZiListParameter(@"0", @"getJianOrJingList", @"0", @"ee995481-3a02-45f1-889f-348d737a9336", @"荐");
    [HTTPTool GET:TieZiList_URL headers:nil parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
//        NSMutableArray *arr = [NSMutableArray array];
        self.dataMArray = [TieZiListModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.jingXuanView.dataArray = self.dataMArray;
//            [self.jingXuanView.collectionView reloadData];
            [weakSelf.jingXuanView reloadData];
            [weakSelf.jingXuanView.collectionView.mj_header endRefreshing];
            [weakSelf.jingXuanView.collectionView.mj_footer endRefreshing];
            [SVProgressHUD dismiss];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
            [weakSelf.jingXuanView.collectionView.mj_header endRefreshing];
            [weakSelf.jingXuanView.collectionView.mj_footer endRefreshing];
        });
    }];
}

- (void)createTopView{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, K_SCREEN_WIDTH, 44)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    // 创建五个按钮
    NSArray *titleArray = @[@"+",@"精选",@"圈子",@"订阅",@"TOP"];
    CGFloat width = K_SCREEN_WIDTH / titleArray.count;
    CGFloat height = 24;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, 10, width, height);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        button.titleLabel.font = NAV_BUTTON_FONT;
        button.tag = i;
        [button addTarget:self action:@selector(tagButtonCick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:button];
        if (i == 1) {
            
            self.lineView = [[UIView alloc]initWithFrame:CGRectMake(button.center.x - 20, button.bottom, button.width / 2 - 10, 3)];
            self.lineView.backgroundColor = [UIColor grayColor];
            [topView addSubview:self.lineView];
            
            [self createJingXuanView];
        }
    }
}

- (void)createJingXuanView{
    
    self.jingXuanView = [[JingXuanCollectionView alloc]initWithFrame:CGRectMake(0, 44, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 44)];
    self.jingXuanView.delegate = self;
    [self.view addSubview:self.jingXuanView];
}

- (void)tagButtonCick: (UIButton *)button{
    
    if (button.tag == 0 && button.tag == 4) {
        self.lineView.hidden = YES;
    }
    else{
        
        [UIView animateWithDuration:.3 animations:^{
            
            self.lineView.frame = CGRectMake(button.center.x - 10, button.bottom, button.width / 2 - 10, 3);
        }];
    }
    switch (button.tag) {
        case 0:
        {
            AddPushlishViewController *addPublishVc = [[AddPushlishViewController alloc]init];
            [self.navigationController pushViewController:addPublishVc animated:YES];
            break;
        }
        case 4:
        {
            Top10ViewController *topVc = [[Top10ViewController alloc]init];
            [self.navigationController pushViewController:topVc animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - JingXuanCollectionViewDelegate

- (void)didSelectJingXuanCollectionView:(JingXuanCollectionView *)collection indexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"collection = %@ indexPath= %@",collection,indexPath);
    CommunityDetailViewController *detailVc = [[CommunityDetailViewController alloc]init];
    detailVc.model = self.dataMArray[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)dataMArray{
    
    if (!_dataMArray) {
        _dataMArray = [NSMutableArray array];
    }
    return _dataMArray;
}
@end
