//
//  ScrollModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollModel : NSObject

/**
 *   "AId": "c42a3c6f-6c75-427e-b590-05c512137fa0",
 "content": "            ",
 "createDate": "2016-09-12 18:52:29.0",
 "enable": true,
 "endDate": "2016-09-30",
 "id": "9461d2d3-e53e-4021-85f0-6cbdee8f4eb9",
 "imageUrl": "http://static.htxq.net/UploadFiles/2016/09/12/20160912185225878909.jpg",
 "order": 145,
 "startDate": "2016-09-12",
 "title": "挚爱之花有奖活动",
 "type": "活动",
 "url": "c39002ac-6355-48a1-9db4-4112e05520c9"

 */

@property (nonatomic,copy) NSString *createDate; /*<#id#>*/
@property (nonatomic,copy) NSString *endDate; /*<#id#>*/
@property (nonatomic,copy) NSString *imageUrl; /*<#id#>*/
@property (nonatomic,copy) NSString *title; /*<#id#>*/
@property (nonatomic,copy) NSString *url; /*<#id#>*/

@end
