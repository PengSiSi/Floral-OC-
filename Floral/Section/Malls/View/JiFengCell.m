//
//  JiFengCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "JiFengCell.h"
#import "JIFengModel.h"
#import "UIImageView+WebCache.h"

@implementation JiFengCell

- (void)awakeFromNib {

    [super awakeFromNib];
    self.titleLabel.font = CELL_CONTENT_FONT;
    self.desLabel.font = CELL_CONTENT_FONT;
    self.priceLabel.font = CELL_CONTENT_FONT;
}

- (void)setModel:(JIFengModel *)model{
    
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.model.fnAttachment] placeholderImage:nil];
    self.titleLabel.text = self.model.fnEnName;
    self.desLabel.text = self.model.fnName;
    self.priceLabel.text = [NSString stringWithFormat:@"积分: %@",self.model.fnMarketPrice];
}

@end
