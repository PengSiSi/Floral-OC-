//
//  ProfileViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/8.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ProfileViewController.h"
#import "MainTabBarController.h"
#import "UserModel.h"
#import "SelectCountryViewController.h"
#import "MyViewController.h"

@interface ProfileViewController ()

//返回按钮
- (IBAction)backButtonClick:(id)sender;

//关闭按钮
- (IBAction)closeButtonClick:(id)sender;

//地区
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
//电话号码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
//选择地区
- (IBAction)selectLocationClick:(id)sender;
//注册
- (IBAction)registerClick:(id)sender;
//忘记密码
- (IBAction)forgetButtonClick:(id)sender;
//登录
- (IBAction)logginButtonClick:(id)sender;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *logginButton;
//微信登录
- (IBAction)weiXinButtonClick:(id)sender;
//微博登录
- (IBAction)weiBoButtonClick:(id)sender;
//QQ登录
- (IBAction)QQButtonClick:(id)sender;

@end

@implementation ProfileViewController


#pragma mark - life Cycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

//这里没有调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
#warning 为什么没有调用

    if (self = [super initWithCoder:aDecoder]) {
        
//        self.navigationController.navigationBar.hidden = YES;
//        self.tabBarController.tabBar.hidden = YES;
        self.logginButton.layer.borderColor = [UIColor grayColor].CGColor;
        self.logginButton.layer.borderWidth = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}


- (IBAction)selectLocationClick:(id)sender {
    
    NSLog(@"选择国家地区...");
    SelectCountryViewController *selectCountryVc = [[SelectCountryViewController alloc]init];
    selectCountryVc.selectCountryblock = ^(NSString *seleStr){
        
        self.locationTextField.text = seleStr;
    };
    [self.navigationController pushViewController:selectCountryVc animated:YES];
}

- (IBAction)registerClick:(id)sender {
    
    NSLog(@"注册账号...");
}

- (IBAction)forgetButtonClick:(id)sender {
    
    NSLog(@"忘记密码...");
}

- (IBAction)logginButtonClick:(id)sender {
    
    [SVProgressHUD show];
    
    // 模拟请求网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UserModel *userModel = [[UserModel alloc]init];
        userModel.phoneNumber = self.phoneNumberTextField.text;
        userModel.password = self.passwordTextField.text;
        userModel.location = self.locationTextField.text;
        //验证账号密码
        if (userModel.phoneNumber != nil && userModel.location != nil && [userModel.password isEqualToString:@"111"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            USERDEFAULT_SETOBJ4KEY(@"1", isLogginApp);
//            [self closeButtonClick:sender];
            MyViewController *myVc = [[MyViewController alloc]init];
            [self.navigationController pushViewController:myVc animated:YES];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"验证失败,请重新登录!"];
        }
    });
}

- (IBAction)weiXinButtonClick:(id)sender {
    
    NSLog(@"微信登录...");
}

- (IBAction)weiBoButtonClick:(id)sender {
    
    NSLog(@"微博登录...");
}

- (IBAction)QQButtonClick:(id)sender {
    
    NSLog(@"QQ登录...");
    MyViewController *myVc = [[MyViewController alloc]init];
    [self.navigationController pushViewController:myVc animated:YES];
}

- (IBAction)backButtonClick:(id)sender {
    
//    [self closeButtonClick:sender];
}

- (IBAction)closeButtonClick:(id)sender {

    MainTabBarController *tabbarVc = (MainTabBarController *)[[UIApplication sharedApplication].windows firstObject].rootViewController;
    tabbarVc.selectedIndex = self.preSelectIndex;
    tabbarVc.tabBar.hidden = NO;
}
@end
