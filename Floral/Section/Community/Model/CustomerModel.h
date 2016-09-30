//
//  CustomerModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerModel : NSObject

/**
 *   "articleCount": 0,
 "attentionCount": 0,
 "attentioned": false,
 "auth": "",
 "bbsCount": 0,
 "birthday": "",
 "championM": false,
 "championW": false,
 "championY": false,
 "city": "",
 "content": "",
 "countryCode": "",
 "createDate": "",
 "dingYue": false,
 "email": "",
 "experience": 1,
 "fansCount": 0,
 "gag": false,
 "gagBeginDate": "",
 "gagEndDate": "",
 "headImg": "http://static.htxq.net/UploadFiles/headimg/20160810163113113.jpg",
 "id": "0c74489a-f6cd-4a4b-ad59-6fa96760a98b",
 "identity": "",
 "imQQ": "",
 "imWeibo": "",
 "imWeixin": "",
 "initSubscibeNum": 0,
 "integral": 314,
 "isAddress": 0,
 "j_PUSH_CODE": "",
 "jian": false,
 "level": 0,
 "listContent": [],
 "loginDate": "",
 "market": "",
 "messageCount": 0,
 "mobile": "0c74489a-f6cd-4a4b-ad59-6fa96760a98b",
 "mySubscibeNum": 0,
 "newAuth": "",
 "newPassword": "",
 "occSelected": 0,
 "occupation": "花艺",
 "password": "",
 "realName": "",
 "sex": "",
 "speciality": "",
 "state": "",
 "subscibeNum": 0,
 "terminal": "",
 "token": "",
 "uplevelPercent": "",
 "userName": "婧儿",
 "validDate_M": "",
 "validDate_W": "",
 "validDate_Y": ""

 */
@property (nonatomic,copy) NSString *headImg; /*<#id#>*/
@property (nonatomic,copy) NSString *userName; /*<#id#>*/
@property (nonatomic,copy) NSString *occupation; /*<#id#>*/
@property (nonatomic,copy) NSString *content; /*<#id#>*/

@end
