//
//  JingXuanCollectionView.m
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "JingXuanCollectionView.h"
#import "JingXuanCell1.h"
#import "SDCycleScrollView.h"

static NSString *const identify = @"JingXuanCell1";

@interface JingXuanCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *sdScrollView;

@end

@implementation JingXuanCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createCollectionView];
//        [self createSDScrollView];
    }
    return self;
}

- (void)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((K_SCREEN_WIDTH - 5)/2, (K_SCREEN_WIDTH - 5)/2);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,10, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 104) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self registerCell];
    [self addSubview:self.collectionView];
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)reloadData{
    
    [self.collectionView reloadData];
}

- (void)registerCell{
    
    [_collectionView registerNib:[UINib nibWithNibName:@"JingXuanCell1" bundle:nil] forCellWithReuseIdentifier:identify];
    [_collectionView registerClass:[CollectionHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    JingXuanCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeaderReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        self.reusableView = view;
        return self.reusableView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){K_SCREEN_WIDTH,230};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(didSelectJingXuanCollectionView:indexPath:)]) {
        [self.delegate didSelectJingXuanCollectionView:self indexPath:indexPath];
    }
}
@end
