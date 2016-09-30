//
//  ShangChengCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/23.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ShangChengCell.h"
#import "UIImageView+WebCache.h"
#import "ShopModel.h"

@implementation ShangChengCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setModel:(pGoods *)model{
    
    _model = model;
    [self.bg sd_setImageWithURL:[NSURL URLWithString:self.model.fnAttachment] placeholderImage:nil];
    self.titlelabel.text = self.model.fnEnName;
    self.desLabel.text = self.model.fnName;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld",((skuList*)(self.model.skuList[0])).fnPrice];
}
@end
