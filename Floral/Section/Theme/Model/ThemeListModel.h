//
//  ThemeListModel.h
//  Floral
//
//  Created by 思 彭 on 16/9/9.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeCategoryModel.h"
#import "AuthorModel.h"

@interface ThemeListModel : NSObject

/**
 *  "result": [
 {
 "appoint": 10,
 "author": {
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
 "content": "夜市NightChic 创始人",
 "countryCode": "",
 "createDate": "",
 "dingYue": false,
 "email": "",
 "experience": 73,
 "fansCount": 0,
 "gag": false,
 "gagBeginDate": "",
 "gagEndDate": "",
 "headImg": "http://static.htxq.net/UploadFiles/headimg/20160813004833105.jpg",
 "id": "7a301cf4-3a7d-4dfd-a216-020a572ea055",
 "identity": "作家",
 "imQQ": "",
 "imWeibo": "",
 "imWeixin": "",
 "initSubscibeNum": 0,
 "integral": 152,
 "isAddress": 1,
 "j_PUSH_CODE": "",
 "jian": false,
 "level": 0,
 "listContent": [],
 "loginDate": "",
 "market": "",
 "messageCount": 0,
 "mobile": "18575554595",
 "mySubscibeNum": 0,
 "newAuth": "2",
 "newPassword": "",
 "occSelected": 0,
 "occupation": "",
 "password": "",
 "realName": "",
 "sex": "",
 "speciality": "",
 "state": "",
 "subscibeNum": 2724,
 "terminal": "",
 "token": "",
 "uplevelPercent": "",
 "userName": "晚妹",
 "validDate_M": "",
 "validDate_W": "",
 "validDate_Y": ""
 },
 "category": {
 "createDate": "2016-06-06 18:33:52.0",
 "enName": "Enjoy",
 "id": "649e2ff5-f03d-4305-a0eb-c53193cadfef",
 "img": "http://static.htxq.net/UploadFiles/2016/08/26/20160826233530504789.jpg",
 "name": "跨界鉴赏",
 "order": 1
 },
 "check": true,
 "content": "",
 "content2": "",
 "content3": "",
 "contentTitle1": "",
 "contentTitle2": "",
 "contentTitle3": "",
 "createDate": "2016-09-09 13:35:59.0",
 "desc": "人对自然植物的亲近感，来自于原始的情怀，虽然如今我们身处钢筋水泥，也向往着山谷幽林。没办法住在森林里，那就在卧室里造一个森林吧！",
 "descIcon": "",
 "descTitle": "",
 "favo": 0,
 "fnCommentNum": 0,
 "fnCuringNum": 0,
 "fnDifficultyNum": 0,
 "fnGoodsIds": "",
 "fnHumidityNum": 0,
 "fnIsVph": 0,
 "fnVphReadNum": 0,
 "goodsList": [],
 "hasAddFavo": false,
 "hasAppoint": false,
 "id": "a4dbf392-13f2-4dee-9e45-0cf1e332ecda",
 "keywords": "晚妹，卧室，森林",
 "newAppoint": 10,
 "newFavo": 0,
 "newRead": 130,
 "order": 414,
 "pageUrl": "http://m.htxq.net//servlet/SysArticleServlet?action=preview&artId=a4dbf392-13f2-4dee-9e45-0cf1e332ecda",
 "pass": 1,
 "pushTime": "",
 "read": 390,
 "share": 0,
 "sharePageUrl": "http://m.htxq.net//servlet/SysArticleServlet?action=sharePreview&artId=a4dbf392-13f2-4dee-9e45-0cf1e332ecda",
 "smallIcon": "http://static.htxq.net/UploadFiles/2016/09/09/20160909093907846868.jpg",
 "title": "在卧室里造一个森林",
 "top": false,
 "video": false,
 "videoUrl": ""
 },

 */

@property (nonatomic,strong) AuthorModel *author; /*<#name#>*/
@property (nonatomic,copy) NSString *content; /*<#id#>*/
@property (nonatomic,copy) NSString *smallIcon; /*<#id#>*/
@property (nonatomic,copy) NSString *title; /*<#id#>*/
@property (nonatomic,copy) NSString *desc; /*<#id#>*/
@property (nonatomic,copy) NSString *name; /*<#id#>*/
@property (nonatomic,copy) NSString *userName; /*<#id#>*/
@property (nonatomic,copy) NSString *identity; /*<#id#>*/
@property (nonatomic,assign) NSInteger fnCommentNum; /*评论*/
@property (nonatomic,strong) ThemeCategoryModel *category;
@property (nonatomic,assign) NSInteger newFavo; // 喜欢
@property (nonatomic,assign) NSInteger read;
@property (nonatomic,strong) NSString *pageUrl; /*<#name#>*/

@end

