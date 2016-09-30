//
//  MainTabBarController.m
//  Floral
//
//  Created by 思 彭 on 16/9/8.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "ThemeViewController.h"
#import "MallsViewController.h"
#import "ProfileViewController.h"
#import "CommunityViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>
{
    NSInteger selectedIndex;
    ProfileViewController *profileVc;
}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setUpChildViewController];
}

// 创建子控制器
- (void)setUpChildViewController{
    
    profileVc = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    [self addChildViewController:[[ThemeViewController alloc]init] notmalimageNamed:@"tb_0" selectedImage:@"tb_0_selected" title:@"Theme"];
    [self addChildViewController:[[CommunityViewController alloc]init] notmalimageNamed:@"tb_1" selectedImage:@"tb_1_selected" title:@"Community"];
    [self addChildViewController:[[MallsViewController alloc]init] notmalimageNamed:@"tb_1" selectedImage:@"tb_1_selected" title:@"Malls"];
    [self addChildViewController:profileVc notmalimageNamed:@"tb_2" selectedImage:@"tb_2_selected" title:@"Profile"];
}

// 包装子控制器
- (void)addChildViewController:(UIViewController *)childController notmalimageNamed:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title
{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childController.title = title;
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : TABBAR_GRAY_COLOR,NSFontAttributeName : TABBARITEM_FONT} forState:UIControlStateNormal];
    [self addChildViewController:nav];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

@end
