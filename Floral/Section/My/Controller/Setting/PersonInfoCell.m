//
//  PersonInfoCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "PersonInfoCell.h"

@interface PersonInfoCell ()<UITextViewDelegate>
{
    UILabel *commitLabel;
}

@end

@implementation PersonInfoCell

+ (instancetype)initWithItemName:(NSString *)itemName canInput:(BOOL)canInput withAvatarImage:(BOOL)isAvatarImage{
    
    return [[self alloc]initWithItemName:itemName canInput:canInput withAvatarImage:isAvatarImage];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateDate:) name:@"selectDate" object:nil];
}

- (instancetype)initWithItemName:(NSString *)itemName canInput:(BOOL)canInput withAvatarImage:(BOOL)isAvatarImage{
    
    if (self = [super init]) {
        _itemName = itemName;
        _canInput = canInput;
        _isAvatarImage = isAvatarImage;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    if (self.isAvatarImage) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.contentView addSubview:imgView];
        [imgView setImage:[UIImage imageNamed:@"LOGO_85x85_"]];
        imgView.layer.cornerRadius = 25.0f;
        imgView.layer.masksToBounds = YES;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imgView.right + 10, 15, 100, 20)];
        label.text = @"更换头像";
        label.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:label];
    }
    else if (self.canInput){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
        label.textColor = [UIColor lightGrayColor];
        label.text = self.itemName;
        [self.contentView addSubview:label];
        commitLabel = [[UILabel alloc]initWithFrame:CGRectMake(K_SCREEN_WIDTH - 120, 10, 100, 20)];
        commitLabel.text = @"15个字以内";
        commitLabel.textColor = [UIColor lightGrayColor];
        commitLabel.backgroundColor = [UIColor clearColor];
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(label.right + 5, label.top, K_SCREEN_WIDTH - label.width - 20, 30)];
        [self.contentView addSubview:self.textView];
        self.textView.delegate = self;
        self.textView.font = [UIFont systemFontOfSize:15.0f];
        self.textView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:commitLabel];
    }
    else{
        self.itemNameLabel = [[UILabel alloc]init];
        self.itemNameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.itemNameLabel];
        self.itemNameLabel.textColor = [UIColor lightGrayColor];
        self.itemNameLabel.text = self.itemName;
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.contentLabel];
        [self layout];
    }
}

- (void)layout{
    
    __weak typeof(self) weakSelf = self;
    [self.itemNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(weakSelf.contentView).offset(10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.itemNameLabel.mas_right).offset(20);
        make.top.equalTo(weakSelf.itemNameLabel);
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    commitLabel.hidden = YES;
}

@end
