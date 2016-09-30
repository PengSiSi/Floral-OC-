//
//  JingXuanModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/23.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JingXuanModel : NSObject

/**
 "fnId": "6ba7d293-1e4f-44a4-8e57-93a5c440df9e",
 "fnName": "神秘箱（单次体验）98元",
 "fnGoodsCode": "SMX005",
 "fnSpec": "60cm x 30cm x 17cm（礼盒）",
 "fnMaterial": "精选12-15支鲜切花（特殊品种除外）",
 "fnFirstTitle": null,
 "fnFirstEnTitle": null,
 "fnFirstDesc": null,
 "fnSecondTitle": null,
 "fnSecondEnTitle": null,
 "fnAttachment": "http://static.htxq.net/UploadFiles/2016/08/02/20160802144546260948.jpeg",
 "fnAttachmentSnap": "http://static.htxq.net/UploadFiles/2016/08/02/snap_20160802144546260948.jpeg",
 "fnUpdateDate": 1472359387000,
 "fnStartSaleDate": null,
 "fnEndSaleDate": null,
 "fnOnSaleDate": null,
 "fnInitClickNum": 0,
 "fnAppClickNum": 27258,
 "fnAppointNum": 15356,
 "fnShareClickNum": 0,
 "fnMarketPrice": 98.0,
 "fnLimitArea": "北京市区（6环内）",
 "fnGoodsType": 0,
 "fnEnName": "A SURPRISE",
 "fnKeyWords": "一周一花,神秘箱,每周一花,花材盒",
 */
@property (nonatomic,copy) NSString *fnId; /*<#id#>*/
@property (nonatomic,copy) NSString *fnName; /*<#id#>*/
@property (nonatomic,copy) NSString *fnGoodsCode; /*<#id#>*/
@property (nonatomic,copy) NSString *fnSpec; /*<#id#>*/
@property (nonatomic,copy) NSString *fnMaterial; /*<#id#>*/
@property (nonatomic,copy) NSString *fnAttachment; /*<#id#>*/
@property (nonatomic,copy) NSString *fnLimitArea; /*<#id#>*/
@property (nonatomic,assign) CGFloat fnMarketPrice; /*<#id#>*/


@end
