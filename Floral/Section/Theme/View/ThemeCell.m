//
//  ThemeCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/9.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ThemeCell.h"
#import "ThemeListModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CircleImage.h"
#import "VideoViewController.h"

@interface ThemeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation ThemeCell

- (void)awakeFromNib {
    
    self.typeLabel.textColor = THEME_ORANGE_COLOR;
    self.titleLabel.font = CELL_FONT;
    self.contentLabel.textColor = GRAY_COLOR;
    self.contentLabel.font = CELL_CONTENT_FONT;
    self.avaterImgView.layer.cornerRadius = 33;
    self.avaterImgView.layer.masksToBounds = YES;
    self.avaterImgView.userInteractionEnabled = YES;
    self.avaterImgView.layer.borderColor = [UIColor grayColor].CGColor;
    self.avaterImgView.layer.borderWidth = 1;
    
    // 头像添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.avaterImgView addGestureRecognizer:tap];
    self.VideoPlayView.hidden = YES;
    self.VideoPlayView.userInteractionEnabled = YES;
    // 播放视频添加手势
    UITapGestureRecognizer *videoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoTapClick:)];
    [self.VideoPlayView addGestureRecognizer:videoTap];
}

- (void)setListModel:(ThemeListModel *)listModel{
    
    _listModel = listModel;
    [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.listModel.author.headImg]];
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.listModel.smallIcon] placeholderImage:[UIImage imageNamed:@"20160425175259881847"]];
    self.typeLabel.text = [NSString stringWithFormat:@"[ %@ ]",self.listModel.category.name];
    self.titleLabel.text = self.listModel.title;
    self.contentLabel.text = self.listModel.desc;
    self.userNameLabel.text = self.listModel.userName;
    [self.lookButton setTitle:[NSString stringWithFormat:@"%ld",self.listModel.read] forState:UIControlStateNormal];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",self.listModel.newFavo] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%ld",self.listModel.fnCommentNum] forState:UIControlStateNormal];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AddVideoFlag:) name:@"AddVideoFlag" object:nil];
}

- (IBAction)lookButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didLookButtonClick:)]) {
        [self.delegate didLookButtonClick:self];
    }
}

- (IBAction)likeButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(didLikeButtonClick:)]) {
        [self.delegate didLikeButtonClick:self];
    }
}

- (IBAction)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didCommentButtonClick:)]) {
        [self.delegate didCommentButtonClick:self];
    }
}

- (void)tapClick: (UITapGestureRecognizer *)tap{
    
    NSLog(@"点击头像...");
    //注意:这里和cell的点击不冲突
    if ([self.delegate respondsToSelector:@selector(didAvaterClick:)]) {
        [self.delegate didAvaterClick:self];
    }
}

- (void)videoTapClick: (UITapGestureRecognizer *)tap{
   
    NSLog(@"点击视频播放...");
    if ([self.delegate respondsToSelector:@selector(didVideoPlayClick::)]) {
        [self.delegate didVideoPlayClick:self];
    }
}
@end
