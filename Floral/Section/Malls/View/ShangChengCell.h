//
//  ShangChengCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/23.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class pGoods;

@interface ShangChengCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bg;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic,strong) pGoods *model; /*<#name#>*/

@end
