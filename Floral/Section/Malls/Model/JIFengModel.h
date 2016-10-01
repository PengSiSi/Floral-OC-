//
//  JIFengModel.h
//  Floral
//
//  Created by 思 彭 on 16/10/1.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JIFengModel : NSObject

@property (nonatomic,copy) NSString *fnName; /*<#id#>*/
@property (nonatomic,copy) NSString *fnEnName; /*<#id#>*/
@property (nonatomic,strong) NSArray *skuList; /*<#name#>*/
@property (nonatomic,strong) NSArray *specList; /*<#name#>*/
@property (nonatomic,copy) NSString *fnAttachment; /*<#id#>*/
@property (nonatomic,copy) NSString *fnMarketPrice; /*<#id#>*/

@end
