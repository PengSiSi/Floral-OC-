//
//  TieZiListModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerModel.h"

@interface TieZiListModel : NSObject
/**
 *        "appoint": 2,
 "attachment": "http://static.htxq.net/UploadFiles/2016/09/21/20160921091855829.jpg,http://static.htxq.net/UploadFiles/2016/09/21/20160921091855886.jpg",
 "attachmentSnap": "http://static.htxq.net/UploadFiles/2016/09/21/snap_285_20160921091855829.jpg,http://static.htxq.net/UploadFiles/2016/09/21/snap_285_20160921091855886.jpg",
 "audit": 0,
 "circleType": {
 "createDate": "",
 "sort": 0,
 "type": "",
 "typeId": "afe78aff-8c30-4beb-a7e2-95d0cbeea3c6"
 },
 "comment": 0,
 "content": "MORNING",
 "createDate": "2016-09-21 09:18:55.0",
 "customer": {
 "articleCount": 0,
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
 },
 "hasAppoint": false,
 "id": "dedd77ee-81c1-46b5-aa61-ad3be94a835c",
 "jian": true,
 "jianXuhao": 0,
 "jingIcon": "",
 "keywords": "",
 "lastAdminName": "",
 "lastOperTime": "",
 "newest": false,
 "newestXuhao": 0,
 "read": 22,
 "release": 1,
 "share": 0,
 "sharePageUrl": "http://m.htxq.net//servlet/UserBbsServlet?action=sharePreview&bbsId=dedd77ee-81c1-46b5-aa61-ad3be94a835c",
 "title": ""
 }
 */
@property (nonatomic,copy) NSString *content; /*<#id#>*/
@property (nonatomic,copy) NSString *createDate; /*<#id#>*/
@property (nonatomic,strong) CustomerModel *customer;
@property (nonatomic,copy) NSString *sharePageUrl; /*<#id#>*/
@property (nonatomic,assign) NSInteger share; /*<#id#>*/
@property (nonatomic,assign) NSInteger read; /*<#id#>*/
@property (nonatomic,assign) NSInteger comment; /*<#id#>*/
@property (nonatomic,strong) NSString *attachment;
@property (nonatomic,copy) NSString *attachmentSnap; /*<#id#>*/
    
@property (nonatomic,assign) CGFloat cellHeight; /*<#number#>*/

@end
