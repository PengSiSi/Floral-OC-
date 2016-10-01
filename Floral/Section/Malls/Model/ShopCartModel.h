//
//  ShopCartModel.h
//  Floral
//
//  Created by 思 彭 on 16/10/1.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartModel : NSObject

@property (nonatomic,copy) NSString *fnCartId; /*<#name#>*/
@property (nonatomic,strong) NSDictionary *fnCreateDate; /*<#name#>*/
@property (nonatomic,copy) NSString *fnGoodsName; /*<#name#>*/
@property (nonatomic,assign) CGFloat fnPrice; /*<#name#>*/
@property (nonatomic,assign) CGFloat fnQuantity; /*<#name#>*/
@property (nonatomic,strong) NSDictionary *fnUpdateDate; /*<#name#>*/
@property (nonatomic,strong) NSArray *skuList; /*<#name#>*/

@end
