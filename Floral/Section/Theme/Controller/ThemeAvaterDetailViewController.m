//
//  ThemeAvaterDetailViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/11.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ThemeAvaterDetailViewController.h"
#import "UIBarButtonItem+Create.h"
#import "DetailCollectionViewCell.h"
#import "DetailHeaderView.h"

@interface ThemeAvaterDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate>

{
    UIImageView *navBarHairlineImageView;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation ThemeAvaterDetailViewController

#pragma mark - life cycle

//同样的在界面出现时候开启隐藏
-(void)viewWillAppear:(BOOL)animated
{
    navBarHairlineImageView.hidden = YES;
}

//在页面消失的时候就让出现
-(void)viewWillDidDisAppear:(BOOL)animated
{
    navBarHairlineImageView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self createheaderView];
    //再定义一个imageview来等同于这个黑线
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self createCollectionView];
}

- (void)createCollectionView{
    
    CGFloat space = 20;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((K_SCREEN_WIDTH - 3 * space)/2, (K_SCREEN_WIDTH - 3 * space)/2);
    layout.minimumLineSpacing = space;
    layout.minimumInteritemSpacing = space;
    layout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - K_STATUS_BAR_AND_NAVI_BAR_HEIGHT) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"DetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DetailCollectionViewCell"];
}

- (void)createheaderView{
    
    DetailHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"DetailHeaderView" owner:self options:nil]lastObject];
    headerView.frame = CGRectMake(0, 64, K_SCREEN_WIDTH, 200);
    [self.view addSubview:headerView];
}

- (UICollectionReusableView *)createSectionHeaderView{
    
    UICollectionReusableView *headerView = [[UICollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 40)];
    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        return [self createSectionHeaderView];
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setNav{
    
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highLightedImage:nil target:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - private method

- (void)backClick{
   
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


@end
