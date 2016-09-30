//
//  MyOrderViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/13.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "MyOrderViewController.h"
#import "AllMyOrderViewController.h"
#import "UnPayViewController.h"
#import "DidPayViewController.h"
#import "FinishViewController.h"

@interface MyOrderViewController ()

@property (nonatomic, strong) NSArray *titles;
@end
@implementation MyOrderViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"我的订单";
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.pageAnimatable = YES;
        self.menuItemWidth = K_SCREEN_WIDTH/4; //每个MenuItem的宽度
        self.menuHeight = 64;//导航栏那高度
        self.postNotification = YES;
        self.bounces = YES;
        self.menuViewStyle = WMMenuViewStyleLine; //带下划线效果
        self.progressColor = [UIColor grayColor]; //进度条颜色
        self.titleColorSelected = [UIColor blackColor]; //标题选中时的颜色
        self.titleColorNormal = [UIColor grayColor];  //标题非选中的颜色
        self.menuBGColor = [UIColor whiteColor];
        
    }
    return self;
}

- (NSArray *)titles {
    
    return @[@"全部",@"待付款",@"已付款",@"完成"];
}

#pragma mark - WMPageControllerDataSource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    switch (index) {
        case 0: {
            AllMyOrderViewController *allVC = [[AllMyOrderViewController alloc] init];
            return allVC;
            break;
        }
        case 1: {
            UnPayViewController *unPay = [[UnPayViewController alloc] init];
            return unPay;
            break;
        }
        case 2: {
            DidPayViewController *didPayVC = [[DidPayViewController alloc] init];
            return didPayVC;
            break;
        }
        default: {
            FinishViewController *finishVC = [[FinishViewController alloc] init];
            return finishVC;
            break;
        }
    }
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titles[index];
}


@end
