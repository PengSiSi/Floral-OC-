//
//  MallDetailViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/23.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "MallDetailViewController.h"
#import "UIBarButtonItem+Create.h"
#import "ShoppingCartViewController.h"
#import "ProfileViewController.h"
#import "VerifyOrderViewController.h"

@interface MallDetailViewController ()

@property (nonatomic, strong) UIView *maskView;

@end

@implementation MallDetailViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.fnName;
    [self setNav];
    [self createBottomView];
}

#pragma mark - setUI

- (void)setNav{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"Image"] highLightedImage:nil target:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createBottomView{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, K_SCREEN_HEIGHT - 44 - 64, K_SCREEN_WIDTH, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    NSArray *buttonTitle = @[@"",@"加入购物车",@"购买"];
    NSArray *colorsArray = @[WHITE_COLOR,GRAY_COLOR,BLACK_COLOR];
    // 创建三个按钮
    CGFloat width = K_SCREEN_WIDTH / 3;
    CGFloat height = 44;
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, 0, width, height);
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        button.backgroundColor = colorsArray[i];
        if (i == 0) {
            [button setTitleColor:BLACK_COLOR forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"f_cart_23x21"] forState:UIControlStateNormal];
            NSString *priceStr = [[NSString stringWithFormat:@"%f",self.model.fnMarketPrice] componentsSeparatedByString:@"."][0];
            [button setTitle:priceStr forState:UIControlStateNormal];
            // 设置左边和图片的间隙
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        }
        else{
            
            [button setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        }
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
    }
}

- (void)createMaskView{
    
    if (!self.maskView) {
        
        self.maskView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.maskView.backgroundColor = [UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:.8];
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, K_SCREEN_WIDTH, 50)];
        [self.maskView addSubview:buttonView];
        
        // maskView添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeMaskView:)];
        [self.maskView addGestureRecognizer:tap];
        // 创建四个按钮
        CGFloat width = K_SCREEN_WIDTH / 4;
        CGFloat height = 50;
        NSArray *imgArray = @[@"s_weixin_50x50",@"s_weibo_50x50",@"s_qq_50x50",@"s_pengyouquan_50x50"];
        for (NSInteger i = 0; i < 4; i++) {
            UIButton *button = [[UIButton alloc]init];
            button.frame = CGRectMake(i * width, 0, width, height);
            [button setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            [buttonView addSubview:button];
        }
        [UIView animateWithDuration:2.0 animations:^{
            
            [self.view addSubview:self.maskView];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - private method

// 返回
- (void)leftItemClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 分享
- (void)rightItemClick{
    
//    [self.view addSubview:self.maskView];
    [self createMaskView];
}

- (void)removeMaskView: (UITapGestureRecognizer *)tap{

    [self.maskView removeFromSuperview];
    self.maskView = nil;
}

- (void)bottomButtonClick: (UIButton *)button{
    
    if (button.tag == 0) {
        // 购物车
        ShoppingCartViewController *shopCartVc = [[ShoppingCartViewController alloc]init];
        [self.navigationController pushViewController:shopCartVc animated:YES];
    }
    if (button.tag == 1){
        // 加入购物车
//        if ([USERDEFAULT_OBJ4KEY(isLogginApp) isEqualToString:@"0"]) {
            // 进行登录
//            ProfileViewController *profileVc = [[ProfileViewController alloc]init];
//            [self.navigationController pushViewController:profileVc animated:YES];
//        }
//        else
//        {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
//        }
    }
    if (button.tag == 2) {
        // 购买
//        if ([USERDEFAULT_OBJ4KEY(isLogginApp) isEqualToString:@"0"]) {
            // 进行登录
//            ProfileViewController *profileVc = [[ProfileViewController alloc]init];
//            [self.navigationController pushViewController:profileVc animated:YES];
            
//        }
//        else
//        {
            VerifyOrderViewController *verifyorderVc = [[VerifyOrderViewController alloc]init];
            [self.navigationController pushViewController:verifyorderVc animated:YES];
//        }
    }
}

@end
