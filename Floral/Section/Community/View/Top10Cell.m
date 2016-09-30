//
//  Top10Cell.m
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "Top10Cell.h"
#import "UIImageView+WebCache.h"
#import "PublishModel.h"

@interface Top10Cell ()

@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@end

@implementation Top10Cell

- (void)awakeFromNib {
    // Initialization code
    self.avaterImgView.layer.cornerRadius = 55.0/2;
    self.avaterImgView.layer.masksToBounds = YES;
    self.userNameLabel.font = CELL_CONTENT_FONT;
    self.rankLabel.font = Rank_CELL_FONT;
}

- (void)setModel:(PublishModel *)model{
    
    _model = model;
    if ([self.model.headImg isEqualToString:@""]) {
        self.avaterImgView.image = [UIImage imageNamed:@"pc_default_avatar_68"];
    }
    else{
        
        [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.model.headImg]];
    }
    if (self.model.userName.length == 0) {
        
        self.userNameLabel.text = @"匿名用户";
    }
    else{
        self.userNameLabel.text = self.model.userName;
    }
    self.rankLabel.text = [NSString stringWithFormat:@"%ld",self.rank];
}

@end
