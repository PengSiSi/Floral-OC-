//
//  AuthorModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorModel : NSObject
/**
 *   "author": {
 "articleCount": 0,
 "attentionCount": 0,
 "attentioned": false,
 "auth": "专家",
 "bbsCount": 0,
 "birthday": "",
 "championM": false,
 "championW": false,
 "championY": false,
 "city": "",
 "content": "定义自己的美好生活\n",
 "countryCode": "",
 "createDate": "",
 "dingYue": false,
 "email": "",
 "experience": 97,
 "fansCount": 0,
 "gag": false,
 "gagBeginDate": "",
 "gagEndDate": "",
 "headImg": "http://static.htxq.net/UploadFiles/headimg/20160422164405309.jpg",
 "id": "4a3dab7f-1168-4a61-930c-f6bc0f989f32",
 "identity": "",
 "imQQ": "",
 "imWeibo": "",
 "imWeixin": "",
 "initSubscibeNum": 10000,
 "integral": 392,
 "isAddress": 1,
 "j_PUSH_CODE": "",
 "jian": false,
 "level": 0,
 "listContent": [],
 "loginDate": "",
 "market": "",
 "messageCount": 0,
 "mobile": "18618234090",
 "mySubscibeNum": 0,
 "newAuth": "1",
 "newPassword": "",
 "occSelected": 0,
 "occupation": "",
 "password": "",
 "realName": "",
 "sex": "",
 "speciality": "",
 "state": "",
 "subscibeNum": 140015,
 "terminal": "",
 "token": "",
 "uplevelPercent": "",
 "userName": "花田小憩",
 "validDate_M": "",
 "validDate_W": "",
 "validDate_Y": ""
 
 */
@property (nonatomic,copy) NSString *auth;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *headImg;
@property (nonatomic,copy) NSString *messageCount;
@property (nonatomic,copy) NSString *fansCount;
@property (nonatomic,copy) NSString *userName;

@end
