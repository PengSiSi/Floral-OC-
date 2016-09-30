//
//  MyPublishViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/12.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "MyPublishViewController.h"
#import "EditViewController.h"

@implementation MyPublishViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的发布";
    [self createSuspendButton];
}

/**
 *  创建悬浮按钮
 */
- (void)createSuspendButton{
    
    UIButton *buttnn = [UIButton buttonWithType:UIButtonTypeCustom];
    buttnn.frame = CGRectMake(K_SCREEN_WIDTH - 60, K_SCREEN_HEIGHT - 150, 40, 40);
    [buttnn setTitle:@" + " forState:UIControlStateNormal];
    buttnn.titleLabel.font = [UIFont systemFontOfSize:30.0f];
    buttnn.layer.cornerRadius = 20;
    buttnn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:buttnn];
    [buttnn addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)editButtonClick: (UIButton *)button{
    
    EditViewController *editVc = [[EditViewController alloc]init];
    [self.navigationController pushViewController:editVc animated:YES];
}

@end
