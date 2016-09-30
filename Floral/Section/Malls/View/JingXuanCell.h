//
//  JingXuanCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JingXuanModel;

@interface JingXuanCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *recommendImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic,strong) JingXuanModel *model; /*<#name#>*/

@end
