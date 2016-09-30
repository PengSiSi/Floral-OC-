//
//  SuggestFeedbackViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "SuggestFeedbackViewController.h"
#import "textViewPlaceHolder.h"

@interface SuggestFeedbackViewController ()
{
    textViewPlaceHolder *textView;
}
@end

@implementation SuggestFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTextView];
    [self createBottonButton];
}

- (void)createTextView{
    
    textView = [[textViewPlaceHolder alloc]initWithFrame:CGRectMake(10, 10, K_SCREEN_WIDTH - 20, 200)];
    textView.textColor = [UIColor blackColor];
    textView.layer.borderWidth = 1.0f;
    textView.placeHolderText = @"请把您的建议和意见写于此处......";
    textView.placeHolderColor = [UIColor grayColor];
    textView.layer.borderColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:.8].CGColor;
    textView.layer.cornerRadius = 10.0f;
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
}

- (void)createBottonButton{
   
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(10, textView.bottom + 20, K_SCREEN_WIDTH - 20, 49);
    bottomButton.layer.borderWidth = 1.0f;
    bottomButton.layer.borderColor = [UIColor grayColor].CGColor;
    bottomButton.backgroundColor =[UIColor grayColor];
    [bottomButton setTitle:@"提交" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)commitButtonClick{
    
    NSLog(@"提交");
    [self.navigationController popViewControllerAnimated:YES];
}
@end
