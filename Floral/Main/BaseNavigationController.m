//
//  BaseNavigationController.m
//  baiduMap
//
//  Created by Mike on 16/3/30.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIBarButtonItem+Create.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+ (void)initialize {
    [super initialize];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UINavigationBar *navBarAppearance = [UINavigationBar appearanceWhenContainedIn:self, nil];
#pragma clang diagnostic pop
    [navBarAppearance setShadowImage:[[UIImage alloc] init]];
    [navBarAppearance setBackgroundImage:[UIImage imageNamed:@"above_background_image"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : TABBAR_GRAY_COLOR};
    navBarAppearance.titleTextAttributes = attrs;
    navBarAppearance.tintColor = [UIColor whiteColor];
    if (IOS8_OR_LATER) {
        navBarAppearance.translucent = NO;
    }
}

- (instancetype)init {
    self = [super init];
    if (!IOS8_OR_LATER) {
        self.navigationBar.translucent = NO;
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (!IOS8_OR_LATER) {
        self.navigationBar.translucent = NO;
    }
    return self;
}

#pragma mark -  override method in `UINavigationController`

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        // default back button item
        UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"return_icon"] highLightedImage:nil target:self action:@selector(backItemDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = item;
    }
    self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
}

#pragma mark - back handle

- (void)backItemDidClicked:(UIButton *)sender {
    [self popViewControllerAnimated:YES];
}

@end
