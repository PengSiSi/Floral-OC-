//
//  PublishModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublishModel : NSObject

/**
 *  "articleCount": 0,
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
 "experience": 0,
 "fansCount": 0,
 "gag": false,
 "gagBeginDate": "",
 "gagEndDate": "",
 "headImg": "http://static.htxq.net/UploadFiles/headimg/20160913094756716.jpg",
 "id": "40d37615-2098-41ed-b00d-92778a86d86b",
 "identity": "",
 "imQQ": "",
 "imWeibo": "",
 "imWeixin": "",
 "initSubscibeNum": 0,
 "integral": 0,
 "isAddress": 0,
 "j_PUSH_CODE": "",
 "jian": false,
 "level": 0,
 "listContent": [],
 "loginDate": "",
 "market": "",
 "messageCount": 0,
 "mobile": "",
 "mySubscibeNum": 0,
 "newAuth": "",
 "newPassword": "",
 "occSelected": 0,
 "occupation": "",
 "password": "",
 "realName": "",
 "sex": "",
 "speciality": "",
 "state": "",
 "subscibeNum": 0,
 "terminal": "",
 "token": "",
 "uplevelPercent": "",
 "userName": "大丁丁",
 "validDate_M": "",
 "validDate_W": "",
 "validDate_Y": ""
 */

@property (nonatomic,copy) NSString *userName; /*<#id#>*/
@property (nonatomic,copy) NSString *headImg; /*<#id#>*/

@end
