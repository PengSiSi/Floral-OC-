//
//  JiFengViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/12.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "JiFengViewController.h"

@implementation JiFengViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"积分";
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.top10View];
}

- (Top10View *)top10View{
    
    if (!_top10View) {
        _top10View = [[Top10View alloc]initWithFrame:CGRectMake(0, 230, K_SCREEN_WIDTH, K_SCREEN_HEIGHT)];
    }
    return _top10View;
}
@end
