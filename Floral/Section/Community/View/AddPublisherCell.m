//
//  AddPublisherCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "AddPublisherCell.h"
#import "PublishModel.h"
#import "UIImageView+WebCache.h"

@interface AddPublisherCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
@property (weak, nonatomic) IBOutlet UIButton *publishButtonClick;

@end

@implementation AddPublisherCell

- (void)awakeFromNib{
    
    self.avaterImgView.layer.cornerRadius = 56.0/2;
    self.avaterImgView.layer.masksToBounds = YES;
    self.titleLabel.font = CELL_CONTENT_FONT;
    self.titleLabel.textColor = [UIColor blackColor];
    self.contentLabel.font = PUBLISH_CELL_FONT;
    self.contentLabel.textColor = GRAY_COLOR;
    self.avaterImgView.image = [UIImage imageNamed:@"pc_default_avatar_68"];
}

- (void)setModel:(PublishModel *)model{
    
    _model = model;
    if (self.model.userName.length == 0) {
        
        self.titleLabel.text = @"匿名用户";
    }
    else{
        self.titleLabel.text = self.model.userName;
    }
    if ([self.model.headImg isEqualToString:@""]) {
        
        self.avaterImgView.image = [UIImage imageNamed:@"pc_default_avatar_68"];
    }
    else{
        
        [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.model.headImg]];
    }
    self.contentLabel.text = @"这个人很懒,什么也没有留下";
}
@end