//
//  ShopModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/23.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skuList : NSObject


/**
 "fnId": "3a9c6d4e-2ed0-4df3-90d8-95993f5881e3",
 "fnSkuName": "贝壳花瓶（白色）",
 "fnGoodsId": "bfae4577-4662-4968-b419-04b91b7b9247",
 "fnTotalInQuantity": 25,
 "fnTotalOutQuantity": 0,
 "fnCurrentQuantity": 25,
 "fnNewestInQuantity": 25,
 "fnNewestOutQuantity": 0,
 "fnPrice": 65.0,
 "fnMarketPrice": null,
 "fnCost": null,
 "fnDiscount": null,
 "fnSkuCode": "HP030",
 "fnItemId": "86617adb-1879-40cd-8735-efdcd06fa099",
 "fnMerchantsId": "htxq",
 */
@property (nonatomic,copy) NSString *fnId; /*<#id#>*/
@property (nonatomic,copy) NSString *fnSkuName; /*<#id#>*/
@property (nonatomic,copy) NSString *fnTotalInQuantity; /*<#id#>*/
@property (nonatomic,copy) NSString *fnCurrentQuantity; /*<#id#>*/
@property (nonatomic,assign) NSInteger fnPrice; /*<#id#>*/
@property (nonatomic,copy) NSString *fnSkuCode; /*<#id#>*/
@property (nonatomic,copy) NSString *fnMerchantsId; /*<#id#>*/

@end

@interface sku: NSObject

/**
 "fnId": "3a9c6d4e-2ed0-4df3-90d8-95993f5881e3",
 "fnSkuName": "贝壳花瓶（白色）",
 "fnGoodsId": "bfae4577-4662-4968-b419-04b91b7b9247",
 "fnTotalInQuantity": 25,
 "fnTotalOutQuantity": 0,
 "fnCurrentQuantity": 25,
 "fnNewestInQuantity": 25,
 "fnNewestOutQuantity": 0,
 "fnPrice": 65.0,
 "fnMarketPrice": null,
 */
@property (nonatomic,copy) NSString *fnId; /*<#id#>*/
@property (nonatomic,copy) NSString *fnSkuName; /*<#id#>*/
@property (nonatomic,copy) NSString *fnTotalInQuantity; /*<#id#>*/
@property (nonatomic,copy) NSString *fnCurrentQuantity; /*<#id#>*/
@property (nonatomic,copy) NSString *fnPrice; /*<#id#>*/
@property (nonatomic,copy) NSString *fnSpecName; /*<#id#>*/

@end

@interface specList: NSObject


/**
 "fnId": "0aa93240-26ac-48d5-9d85-547365b85d32",
 "fnSpecName": "1个",
 "fnGoodsId": "bfae4577-4662-4968-b419-04b91b7b9247",
 "fnGoodsName": "贝壳花瓶（白色）",
 "fnSequence": 1,
 "fnIsUse": 1,
 "fnCreateDate": 1473665609000,
 "sku": {
 "fnId": "3a9c6d4e-2ed0-4df3-90d8-95993f5881e3",
 "fnSkuName": "贝壳花瓶（白色）",
 "fnGoodsId": "bfae4577-4662-4968-b419-04b91b7b9247",
 "fnTotalInQuantity": 25,
 "fnTotalOutQuantity": 0,
 "fnCurrentQuantity": 25,
 "fnNewestInQuantity": 25,
 "fnNewestOutQuantity": 0,
 "fnPrice": 65.0,
 */
@property (nonatomic,copy) NSString *fnId; /*<#id#>*/
@property (nonatomic,copy) NSString *fnSpecName; /*<#id#>*/
@property (nonatomic,copy) NSString *fnGoodsName; /*<#id#>*/
@property (nonatomic,copy) NSString *fnSequence; /*<#id#>*/
@property (nonatomic,copy) NSString *fnIsUse; /*<#id#>*/
@property (nonatomic,strong) sku *sku; /*<#name#>*/

@end

@interface pGoods: NSObject


/**
 "fnId": "bfae4577-4662-4968-b419-04b91b7b9247",
 "fnName": "海风贝花瓶（白色）",
 "fnGoodsCode": "HP030",
 "fnSpec": "8cm x 10.5cm x 10.5cm",
 "fnMaterial": "陶瓷",
 "fnFirstTitle": null,
 "fnFirstEnTitle": null,
 "fnFirstDesc": "PHA+5pyJ5Lq66K
 */
@property (nonatomic,copy) NSString *fnId; /*<#name#>*/
@property (nonatomic,copy) NSString *fnName; /*<#name#>*/
@property (nonatomic,copy) NSString *fnGoodsCode; /*<#name#>*/
@property (nonatomic,copy) NSString *fnSpec; /*<#name#>*/
@property (nonatomic,copy) NSString *fnMaterial; /*<#name#>*/
@property (nonatomic,copy) NSString *fnFirstDesc; /*<#name#>*/
@property (nonatomic,strong) NSArray *skuList; /*<#name#>*/
@property (nonatomic,strong) NSArray *specList;
@property (nonatomic,copy) NSString *fnAttachment; /*<#id#>*/
@property (nonatomic,copy) NSString *fnEnName; /*<#id#>*/


@end

@interface childrenList: NSObject

@property (nonatomic,strong) pGoods *pGoods; /*<#name#>*/

@end

@interface ShopModel : NSObject


/**
 "fnId": "ef837d9e-41be-415c-a675-ab5e4890f57d",
 "fnName": "陶器专场",
 "fnCreateDate": null,
 "fnIsUse": 1,
 "fnDesc": "POTTERY",
 "fnAttachment": null,
 "fnEnName": null,
 "fnSequence": 999,
 "childrenList": [
 {
 "fnId": "0655c974-19d4-406e-b422-bdfa02f2f14c",
 "fnThemeId": "ef837d9e-41be-415c-a675-ab5e4890f57d",
 "fnGoodsId": "bfae4577-4662-4968-b419-04b91b7b9247",
 "fnSequence": 1,
 "fnCreateDate": 1474457382000,
 "fnType": null,
 "pGoods": {
 "fnId": "bfae4577-4662-4968-b419-04b91b7b9247",
 "fnName": "海风贝花瓶（白色）",
 "fnGoodsCode": "HP030",
 "fnSpec": "8cm x 10.5cm x 10.5cm",
 "fnMaterial": "陶瓷",
 "fnFirstTitle": null,
 "fnFirstEnTitle": null,
 "fnFirstDesc": "PHA+5pyJ5Lq66K+05rW36L6555qE6LSd5aOz6YeM5Lya5bim552A576O5Lq66bG855qE5q2M5aOw\n77yM6L+Z5piv5Lyg6K+055qE576O5Li944CC5aaC5p6c6K+05pS26ZuG6LSd5aOz77yM5bCx5Lya\n5Ye6546w5aWH6L+577yM6YKj5LmI5bCG5LiA5Liq6LSd5aOz6Iqx55O25pGG5Zyo5a626YeM77yM\n6Iez5bCR5Y+v5Lul5YC+5ZCs5Zac5oKm44CCPC9wPg==",
 "fnSecondTitle": null,
 "fnSecondEnTitle": null,

 */
@property (nonatomic,copy) NSString *fnName; /*<#id#>*/
@property (nonatomic,copy) NSString *fnDesc; /*<#id#>*/
@property (nonatomic,copy) NSString *fnSequence; /*<#id#>*/
@property (nonatomic,strong) NSArray *childrenList; /*<#id#>*/

@end
