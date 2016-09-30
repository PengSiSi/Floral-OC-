//
//  MyHeaderView.m
//  Floral
//
//  Created by 思 彭 on 16/9/11.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *avaterImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishLabel;

@end

@implementation MyHeaderView

- (void)awakeFromNib{
    
    self.avaterImageView.layer.masksToBounds = YES;
    self.avaterImageView.layer.cornerRadius = 35;
    self.avaterImageView.layer.borderWidth = .5f;
    self.avaterImageView.layer.borderColor = [UIColor grayColor].CGColor;
    [self addTapGeste];
}

/**
 *  添加"更换头像"手势
 */
- (void)addTapGeste{
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvaterImageView)];
    // 注意打开交互
    self.avaterImageView.userInteractionEnabled = YES;
    [self.avaterImageView addGestureRecognizer:gest];
}

- (void)tapAvaterImageView{
    
    if (self.block) {
        self.block();
    }
}
@end
