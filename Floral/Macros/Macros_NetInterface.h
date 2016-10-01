//
//  Macro_NetInterface.h
//  zichan
//
//  Created by Mike on 16/5/25.
//  Copyright © 2016年 Mike. All rights reserved.
//

#ifndef Macro_NetInterface_h
#define Macro_NetInterface_h

#define isNilOrNull(obj) (obj == nil || [obj isEqual:[NSNull null]])

#define setObjectForKey(object) \
do { \
    [dictionary setObject:object forKey:@#object]; \
} while (0)

#define setOptionalObjectForKey(object) \
do { \
    isNilOrNull(object) ?: [dictionary setObject:object forKey:@#object]; \
} while (0)

// baseURL
#define ZC_BASE_URL (@"http://192.168.50.143:8088/services/V1") // http://192.168.50.143:8088 http://111.207.253.203:9085 http://192.168.130.74:8080  http://192.168.50.26:9085

// ----------------------------------------------------------------------------

#pragma mark - 1.登录
// 1.登录 --GET
#define LOGIN_URL ([NSString stringWithFormat:@"%@/login", ZC_BASE_URL])
// 参数构造
NS_INLINE NSDictionary *ZCLoginParameter(NSString *loginname, NSString *password) {
    return NSDictionaryOfVariableBindings(loginname, password);
}

#pragma mark - 2.首页数据请求

// 1.获取所有的主题分类 --GET
#define Category_List_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/SysCategoryServlet?action=getList"])

//2.首页列表
#define Theme_List_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/SysArticleServlet?action=mainList"])
// 参数构造
NS_INLINE NSDictionary *ThemeListParameter(NSString *currentPageIndex, NSString *pageSize) {
    return NSDictionaryOfVariableBindings(currentPageIndex, pageSize);
}

//3.文章详情
#define Theme_Detail_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/SysArticleServlet?action=mainList"])
// 参数构造
NS_INLINE NSDictionary *ThemeDetailParameter(NSString *currentPageIndex, NSString *pageSize) {
    return NSDictionaryOfVariableBindings(currentPageIndex, pageSize);
}

// 文章列表   -post
#define Article_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/SysArticleServlet?action=mainList_NewVersion&currentPageIndex=0&isVideo=false"])
// 参数构造
NS_INLINE NSDictionary *ArticleParameter(NSString *currentPageIndex, NSString *action,NSString *isVideo) {
    return NSDictionaryOfVariableBindings(currentPageIndex, action,isVideo);
}

// 视频列表   -post
#define Video_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/SysArticleServlet?action=mainList_NewVersion"])
// 参数构造
NS_INLINE NSDictionary *VideoParameter(NSString *currentPageIndex, NSString *action,NSString *isVideo) {
    return NSDictionaryOfVariableBindings(currentPageIndex, action,isVideo);
}

// 订阅列表   -post
#define Publish_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/UserCustomerServlet"])
// 参数构造
NS_INLINE NSDictionary *PublishParameter(NSString *currentPageIndex, NSString *action,NSString *pageSize,NSString *userId) {
    return NSDictionaryOfVariableBindings(currentPageIndex, action,userId,pageSize);
}

// 本周排行Top10   -get
#define Top10_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/UserBbsServlet?action=TopBbsAuthor&(null)="])

// 社区轮播图列表   -get
#define Community_Scroll_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/SysAdvertisingServlet?action=getAdList"])

// 帖子列表   -post
#define TieZiList_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/UserBbsServlet"])
// 参数构造
NS_INLINE NSDictionary *TieZiListParameter(NSString *currentPageIndex, NSString *action,NSString *pageSize,NSString *userId,NSString *type) {
    return NSDictionaryOfVariableBindings(currentPageIndex, action,userId,pageSize,type);
}

// 评论列表   -post
#define CommentList_URL ([NSString stringWithFormat:@"http://m.htxq.net/servlet/UserCommentServlet"])
// ?action=getBbsList&currentPageIndex=0&pageSize=10&bbsId=aae0fcc8-d3f3-4558-befd-f98ff8f71d52&userId=ee995481-3a02-45f1-889f-348d737a9336

// 参数构造
NS_INLINE NSDictionary *CommentListParameter(NSString *currentPageIndex, NSString *action,NSString *pageSize,NSString *userId,NSString *bbsId) {
    return NSDictionaryOfVariableBindings(currentPageIndex, action,userId,pageSize,bbsId);
}

#pragma mark - 3.商城数据请求

//1.轮播图片数据请求

#define Mall_Images_URL ([NSString stringWithFormat:@"http://ec.htxq.net/rest/htxq/index/carousel"])

// 2.商城精选  GET
#define ShopJingXuanList_URL ([NSString stringWithFormat:@"http://ec.htxq.net/rest/htxq/index/jingList/1"])

// 积分列表
#define ShopJingXuanDetail_URL ([NSString stringWithFormat:@"http://ec.htxq.net/shop/PGoodsAction/goodsDetail.do"])

// 参数构造
NS_INLINE NSDictionary *ShopJingXuanDetailParameter(NSString *goodsId) {
    return NSDictionaryOfVariableBindings(goodsId);
}

// 商城列表
#define ShangChengList_URL ([NSString stringWithFormat:@"http://ec.htxq.net/rest/htxq/index/theme"])

// 积分列表
#define JiFenList_URL ([NSString stringWithFormat:@"http://ec.htxq.net/rest/htxq/index/jifenList/1"])

// 加入购物车  GET
#define Add_ShopCart_URL ([NSString stringWithFormat:@"http://ec.htxq.net/rest/htxq/cart/add"])

// 购物车列表  GET
#define ShopCartList_URL ([NSString stringWithFormat:@"http://ec.htxq.net/rest/htxq/cart/list/ee995481-3a02-45f1-889f-348d737a9336"])


#endif /* Macro_NetInterface_h */
