//
//  ShopCartCell.m
//  Floral
//
//  Created by 思 彭 on 16/10/1.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ShopCartCell.h"
#import "ShopCartModel.h"
#import "UIImageView+WebCache.h"

@implementation ShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ShopCartModel *)model{
    
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.model.skuList[0][@"fnAttachment"]] placeholderImage:nil];
    self.nameLabel.text = self.model.fnGoodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"%f",self.model.fnPrice];
}

@end
