//
//  ThemeListModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/9.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeCategoryModel : NSObject

/**
 "createDate": "2016-08-26 18:58:09.0",
 "enName": "Flower",
 "id": "8dba5958-7da0-4ce9-b1e9-5b92343519a7",
 "img": "http://static.htxq.net/UploadFiles/2016/08/26/20160826192049498465.jpg",
 "name": "花艺教学",
 "order": 8
 
 */

@property (nonatomic,copy) NSString *createDate; /*<#id#>*/
@property (nonatomic,copy) NSString *enName; /*<#id#>*/
@property (nonatomic,copy) NSString *img; /*<#id#>*/
@property (nonatomic,copy) NSString *ThemeId; /*<#id#>*/
@property (nonatomic,copy) NSString *name; /*<#id#>*/
@property (nonatomic,assign) NSInteger order; /*<#id#>*/

@end
