//
//  BaseViewController.m
//  baiduMap
//
//  Created by Mike on 16/3/30.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
