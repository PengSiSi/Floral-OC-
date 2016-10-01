//
//  ShopCartCell2.h
//  Floral
//
//  Created by 思 彭 on 16/10/1.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCartModel;
@class ShopCartCell2;

@protocol ShopCartCell2Delegate <NSObject>

- (void)didDelOrderButtonClick: (ShopCartCell2 *)cell;
- (void)didPayButtonClick: (ShopCartCell2 *)cell;

@end

@interface ShopCartCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *fareLabel;
- (IBAction)deleteOrderClick:(id)sender;
- (IBAction)payButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@property (nonatomic,strong) ShopCartModel *model; /*<#name#>*/
@property (nonatomic,assign) id<ShopCartCell2Delegate>delegate; /*<#number#>*/

@end
