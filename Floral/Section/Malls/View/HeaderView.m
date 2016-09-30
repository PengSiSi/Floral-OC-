//
//  HeaderView.m
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "HeaderView.h"
#import "SDCycleScrollView.h"

@interface HeaderView ()<SDCycleScrollViewDelegate>

{
    UIView *lineView;
    NSInteger buttonTag;
}
@property (nonatomic,strong) SDCycleScrollView *sdScrollView;

@end

@implementation HeaderView

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
    
    // 标签视图
    UIView *tagView = [[UIView alloc]init];
    [view addSubview:tagView];
    __weak typeof(self) weakSelf = self;
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.top.equalTo(weakSelf.sdScrollView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    NSArray *titles = @[@"精选",@"商城",@"积分"];
    CGFloat width = (K_SCREEN_WIDTH - 80) / 3;
    CGFloat height = 20;
    CGFloat margin = 20;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width + margin, 0, width, height);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.tag = i + 1;
        [button addTarget:self action:@selector(tagButtonCick:) forControlEvents:UIControlEventTouchUpInside];
        [tagView addSubview:button];
        if (i == 0) {
            
            lineView = [[UIView alloc]initWithFrame:CGRectMake(button.center.x - 20, button.bottom, button.width / 2 - 10, 3)];
            lineView.backgroundColor = [UIColor grayColor];
            [tagView addSubview:lineView];
        }
    }
}

- (void)setImageArray:(NSArray *)imageArray{
    
    _imageArray = imageArray;
    self.sdScrollView.imageURLStringsGroup = self.imageArray;
}

- (void)tagButtonCick: (UIButton *)button{
    
    [UIView animateWithDuration:.3 animations:^{
        
        lineView.frame = CGRectMake(button.center.x - 20, button.bottom, button.width / 2 - 10, 3);
    }];
    if ([self.delegate respondsToSelector:@selector(didTagButton:)]) {
        [self.delegate didTagButton:button.tag];
    }
}


@end
