//
//  AddPhotoCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/12.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "AddPhotoCell.h"
#import "AddFlowLayout.h"

#define insetSpacing (5)

@interface AddPhotoCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation AddPhotoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self initDataArray];
        [self createSubViews];
       }
    return self;
}

- (void)initDataArray{
   
    [self.dataArray addObject:@"f_hs_activities_books_add_cover_icon"];
}

- (void)createSubViews{
    
    AddFlowLayout *layout = [[AddFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(5, 5, insetSpacing, insetSpacing);
    layout.minimumLineSpacing = insetSpacing;
    layout.minimumInteritemSpacing = insetSpacing;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    if (indexPath.row == self.dataArray.count - 1) {
        
        imgView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    }
    else{
        imgView.image = self.dataArray[indexPath.row];
    }
    [cell.contentView addSubview:imgView];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){80,80};
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.item == self.dataArray.count - 1) {
        if ([self.delegate respondsToSelector:@selector(didAddPhoto:)]) {
            [self.delegate didAddPhoto:self];
        }
    }
}

- (void)setImgArray:(NSArray *)imgArray{
    
    _imgArray = imgArray;
    for (UIImage *image in _imgArray) {
        
        [self.dataArray insertObject:image atIndex:0];
    }
    // 图片个数的通知
    NSString *count = [NSString stringWithFormat:@"%ld", self.dataArray.count - 1];
    [[NSNotificationCenter defaultCenter]postNotificationName:kAddCellPhotoCount object:nil userInfo:@{@"count" : count}];
    [self.collectionView reloadData];
    
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
