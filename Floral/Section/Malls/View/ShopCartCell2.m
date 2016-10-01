//
//  ShopCartCell2.m
//  Floral
//
//  Created by 思 彭 on 16/10/1.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ShopCartCell2.h"
#import "ShopCartModel.h"

@implementation ShopCartCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.delButton.layer.cornerRadius = 3.0f;
    self.delButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.delButton.layer.borderWidth = 0.5f;
    self.payButton.layer.cornerRadius = 3.0f;
    self.payButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.payButton.layer.borderWidth = 0.5f;
}

- (void)setModel:(ShopCartModel *)model{
    
    _model = model;
    self.totalLabel.text = [NSString stringWithFormat:@"总计: %.2f",self.model.fnPrice * self.model.fnQuantity];
}

- (IBAction)deleteOrderClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(didDelOrderButtonClick:)]) {
        [self.delegate didDelOrderButtonClick: self];
    }
}

- (IBAction)payButtonClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(didPayButtonClick:)]) {
        [self.delegate didPayButtonClick: self];
    }
}
@end
