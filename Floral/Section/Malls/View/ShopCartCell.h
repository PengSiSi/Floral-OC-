//
//  ShopCartCell.h
//  Floral
//
//  Created by 思 彭 on 16/10/1.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCartModel;

@interface ShopCartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic,strong) ShopCartModel *model; /*<#name#>*/


@end
