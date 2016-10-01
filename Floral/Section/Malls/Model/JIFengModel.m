//
//  JIFengModel.m
//  Floral
//
//  Created by 思 彭 on 16/10/1.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "JIFengModel.h"
#import "ShopModel.h"

//@implementation sku
//
//@end
//

@implementation JIFengModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{NSStringFromClass([sku class]) : @"skuList",
             NSStringFromClass([specList class]) : @"specList"
             };
}

@end
