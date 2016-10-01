//
//  JingXuanCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "JingXuanCell.h"
#import "UIImageView+WebCache.h"
#import "JingXuanModel.h"

@implementation JingXuanCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.titleLabel.textColor = GRAY_COLOR;
    self.priceLabel.textColor = PRICE_COLOR;
}   
- (void)setModel:(JingXuanModel *)model{
    
    _model = model;
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.model.fnAttachment] placeholderImage:nil];
    self.titleLabel.text = self.model.fnGoodsCode;
    self.desLabel.text = self.model.fnName;
    NSString *priceStr = [NSString stringWithFormat:@"%f",self.model.fnMarketPrice];
    self.priceLabel.text = [NSString stringWithFormat:@"%@",[priceStr componentsSeparatedByString:@"."][0]];
}

@end
