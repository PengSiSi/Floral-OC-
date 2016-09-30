//
//  GuideViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/8.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}
@end

@implementation GuideViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     *  创建子视图
     */
    [self createUI];
}

- (void)createUI{

    NSArray *guideImgArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"gp_bg_0"],[UIImage imageNamed:@"gp_bg_1"],[UIImage imageNamed:@"gp_bg_2"],nil];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(K_SCREEN_WIDTH * guideImgArr.count, K_SCREEN_HEIGHT);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    for (NSInteger i = 0; i<guideImgArr.count; i++) {
        
        UIImageView *itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + K_SCREEN_WIDTH * i, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
        itemImageView.userInteractionEnabled = YES;
        itemImageView.image = guideImgArr[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        if (i == guideImgArr.count - 1) {
            [itemImageView addGestureRecognizer:tap];
        }
        [scrollView addSubview:itemImageView];
    }
    [self.view addSubview:scrollView];
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((K_SCREEN_WIDTH-100)/2, K_SCREEN_HEIGHT - 80, 100, 50)];
    pageControl.numberOfPages = guideImgArr.count;
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger i = scrollView.contentOffset.x / K_SCREEN_WIDTH;
    pageControl.currentPage = i;
}

#pragma mark - private method

- (void)tap: (UITapGestureRecognizer *)tap{
    
    self.scrollEnd();
}

@end
