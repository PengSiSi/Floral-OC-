//
//  AppDelegate.m
//  Floral
//
//  Created by 思 彭 on 16/9/8.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "GuideViewController.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@property (nonatomic, strong) MainTabBarController *tabBarVc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [IQKeyboardManager sharedManager].enable = YES;
    USERDEFAULT_SETOBJ4KEY(@"0", isLogginApp);
    
    // 创建窗口
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.tabBarVc = [[MainTabBarController alloc]init];
    //将启动完后的状态栏显示出来
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    // 第一次启动 显示引导页
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:isNotFirstOpenApp] == nil) {
        [userDefaults setBool:NO forKey:isNotFirstOpenApp];
        // 显示引导页
        GuideViewController *guideVc = [[GuideViewController alloc]init];
        self.window.rootViewController = guideVc;
        //回调跳转主页
        guideVc.scrollEnd = ^(){
        
            CATransition *transition = [CATransition animation];
            transition.duration = 0.7f;
            transition.type = @"pageCurl";//    pageCurl
            transition.removedOnCompletion = YES;
            [self.window.layer addAnimation:transition forKey:@"transition"];
            self.window.rootViewController = self.tabBarVc;
        };
    }
    else{
        
        [self jumpMainVc];
    }
    return YES;
}

- (void)jumpMainVc{
    
    self.window.rootViewController = self.tabBarVc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
