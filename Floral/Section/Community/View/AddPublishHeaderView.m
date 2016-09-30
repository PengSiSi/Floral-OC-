//
//  AddPublishHeaderView.m
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "AddPublishHeaderView.h"

@interface AddPublishHeaderView ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *bottomLineView;
@property (nonatomic,strong) UIImageView *avaterImgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *pushButton;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,copy) NSString *searchString;
@property (nonatomic,strong) UILabel *userRecommendLabel;

@end

@implementation AddPublishHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    // 搜索框
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
//    [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//    self.searchBar.tintColor = VIEW_GRAY_COLOR;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.backgroundColor = [UIColor clearColor];
    [self.searchBar sizeToFit];
    [self addSubview:self.searchBar];
    // 上面线
    self.bottomLineView = [[UIView alloc]init];
    self.bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.bottomLineView];
    // 头像
    self.avaterImgView = [[UIImageView alloc]init];
    [self addSubview:self.avaterImgView];
    self.avaterImgView.layer.masksToBounds = YES;
    self.avaterImgView.layer.cornerRadius = 25;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.avaterImgView.backgroundColor = [UIColor redColor];
    self.avaterImgView.image = [UIImage imageNamed:@"LOGO_85x85_"];
    // 标题
    self.titleLabel = [[UILabel alloc]init];
    [self addSubview:self.titleLabel];
    self.titleLabel.text = @"推荐花田小憩给好友!";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    // 右箭头
    self.pushButton = [[UIButton alloc]init];
    [self addSubview:self.pushButton];
    [self.pushButton setImage:[UIImage imageNamed:@"goto"] forState:UIControlStateNormal];
    [self.pushButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.lineView];
    
    self.userRecommendLabel = [[UILabel alloc]init];
    self.userRecommendLabel.font = [UIFont systemFontOfSize:15];
    self.userRecommendLabel.text = @"    用户推荐";
    [self addSubview:self.userRecommendLabel];
    [self layout];
}

- (void)layout{
    
    __weak typeof(self) weakSelf = self;
//    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf).offset(20);
//        make.top.mas_equalTo(weakSelf).offset(5);
//        make.right.mas_equalTo(weakSelf).offset(-20);
//        make.height.mas_equalTo(30);
//    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.searchBar.mas_bottom).offset(5);
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(1);
    }];
    [self.avaterImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).offset(10);
        make.top.mas_equalTo(weakSelf.bottomLineView.mas_bottom).offset(10);
        make.width.height.mas_equalTo(50);
    }];
    self.avaterImgView.layer.masksToBounds = YES;
    self.avaterImgView.layer.cornerRadius = 25;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.avaterImgView.mas_right).offset(20);
        make.centerY.mas_equalTo(weakSelf.avaterImgView);
        make.height.mas_equalTo(weakSelf.avaterImgView);
    }];
    [self.pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-10);
        make.centerY.mas_equalTo(weakSelf.avaterImgView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.avaterImgView.mas_bottom).offset(7);
        make.height.mas_equalTo(1);
    }];
    [self.userRecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf).offset(10);
    }];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = YES;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchString = searchBar.text;
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}
- (void)tapClick:(UITapGestureRecognizer *)tap {
    
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}
//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    self.searchString = [NSString stringWithFormat:@"%@",searchBar.text];
}

- (CGFloat)getHeight{
    
    return self.lineView.bottom + 10;
}

- (void)click: (UIButton *)button{
    
    // 推荐给好友按钮被点击
    if (self.block) {
        self.block();
    }
}

@end
