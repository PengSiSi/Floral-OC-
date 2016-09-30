//
//  Top10View.m
//  Floral
//
//  Created by 思 彭 on 16/9/11.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "Top10View.h"
#import "DetailCollectionViewCell.h"

@interface Top10View ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation Top10View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCollectionView];
    }
    return self;
}

- (void)createCollectionView{
    
    CGFloat space = 20;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((K_SCREEN_WIDTH - 3 * space)/2, (K_SCREEN_WIDTH - 3 * space)/2);
    layout.minimumLineSpacing = space;
    layout.minimumInteritemSpacing = space;
    layout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - K_STATUS_BAR_AND_NAVI_BAR_HEIGHT) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:@"DetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DetailCollectionViewCell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}



@end
