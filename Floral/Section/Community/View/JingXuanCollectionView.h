//
//  JingXuanCollectionView.h
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionHeaderReusableView.h"
@class JingXuanCollectionView;

@protocol JingXuanCollectionViewDelegate <NSObject>

/**
 *  collectionViewcell被点击协议
 *
 *  @param collection JingXuanCollectionView
 *  @param indexPath  选中的item
 */
- (void)didSelectJingXuanCollectionView: (JingXuanCollectionView *)collection indexPath: (NSIndexPath *)indexPath;

@end

@interface JingXuanCollectionView : UIView

@property (nonatomic,strong) NSMutableArray *dataArray; /* */
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) CollectionHeaderReusableView *reusableView;
@property (nonatomic, assign) id<JingXuanCollectionViewDelegate>delegate;

// 刷新表视图
- (void)reloadData;

@end
