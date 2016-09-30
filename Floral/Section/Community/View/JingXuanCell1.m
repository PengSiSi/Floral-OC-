//
//  JingXuanCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "JingXuanCell1.h"
#import "TieZiListModel.h"
#import "UIImageView+WebCache.h"

@interface JingXuanCell1 ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation JingXuanCell1

- (void)awakeFromNib {
    // Initialization code
    self.imgView.image = [UIImage imageNamed:@"LOGO_85x85_"];
}

- (void)setModel:(TieZiListModel *)model{
    
    _model = model;
    NSString *imgUrl = self.model.attachment;
    NSString *imgStrUrl = [imgUrl componentsSeparatedByString:@","][0];
    if (self.isShowPhoto) {
        // 多张图片
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgName] placeholderImage:[UIImage imageNamed:@"LOGO_85x85_"]];
    }
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgStrUrl] placeholderImage:[UIImage imageNamed:@"LOGO_85x85_"]];
}
@end
