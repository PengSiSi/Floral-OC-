//
//  ScrollImageModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollImageModel : NSObject

/**
 *  "fnId": "c7ea095a-01fb-4652-9571-d27c3c7cbeeb",
 "fnAid": "c42a3c6f-6c75-427e-b590-05c512137fa0",
 "fnTitle": "时尚手机壳：你的伴读时光",
 "fnStartDate": 1472054400000,
 "fnEndDate": 1474819200000,
 "fnImageUrl": "http://static.htxq.net/UploadFiles/2016/08/25/20160825182548586860.jpg",
 "fnUrl": "da729869-f281-46d3-87d9-3d9c0e498f05",
 "fnContent": null,
 "fnEnable": 1,
 "fnCreateDate": null,
 "fnType": "0",
 "fnOrder": 90
 */

@property (nonatomic,copy) NSString *fnId; /*<#id#>*/
@property (nonatomic,copy) NSString *fnAid; /*<#id#>*/
@property (nonatomic,copy) NSString *fnTitle; /*<#id#>*/
@property (nonatomic,copy) NSString *fnStartDate; /*<#id#>*/
@property (nonatomic,copy) NSString *fnImageUrl; /*<#id#>*/
@property (nonatomic,copy) NSString *fnUrl; /*<#id#>*/
@property (nonatomic,copy) NSString *fnContent; /*<#id#>*/
@property (nonatomic,copy) NSString *fnEnable; /*<#id#>*/
@property (nonatomic,copy) NSString *fnCreateDate; /*<#id#>*/
@property (nonatomic,copy) NSString *fnType; /*<#id#>*/
@property (nonatomic,copy) NSString *fnOrder; /*<#id#>*/

@end
