//
//  CollectionHeaderReusableView.m
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "CollectionHeaderReusableView.h"
#import "SDCycleScrollView.h"

@interface CollectionHeaderReusableView ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *sdScrollView;

@end
@implementation CollectionHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSDScrollView];
    }
    return self;
}

- (void)createSDScrollView{
    
    UIView *view = [[UICollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 230)];
    [self addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    self.sdScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 200)];
    self.sdScrollView.delegate = self;
    [view addSubview:self.sdScrollView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.sdScrollView.bottom, K_SCREEN_WIDTH, 30)];
    label.text = @"  每日精选";
    label.font = [UIFont systemFontOfSize:15.0f];
    [view addSubview:label];
}

- (void)setImgArray:(NSArray *)imgArray{
    
    _imgArray = imgArray;
    self.sdScrollView.imageURLStringsGroup = self.imgArray;
}

#pragma mark - SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}


@end
