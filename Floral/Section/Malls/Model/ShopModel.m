//
//  ShopModel.m
//  Floral
//
//  Created by 思 彭 on 16/9/23.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ShopModel.h"

@implementation sku

@end

@implementation skuList

@end

@implementation specList

@end

@implementation childrenList



@end

@implementation pGoods

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{NSStringFromClass([skuList class]) : @"skuList",
             NSStringFromClass([specList class]) : @"specList"
             };
}

@end


@implementation ShopModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{NSStringFromClass([childrenList class]) : @"childrenList"
             };
}
@end
