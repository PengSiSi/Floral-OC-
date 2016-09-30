//
//  Macro_String.h
//  zichan
//
//  Created by Mike on 16/5/16.
//  Copyright © 2016年 Mike. All rights reserved.
//

#ifndef Macro_String_h
#define Macro_String_h

// user default access
#define USERDEFAULT_OBJ4KEY(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define USERDEFAULT_SETOBJ4KEY(obj, key) [[NSUserDefaults standardUserDefaults]setObject:obj forKey:key]

#define USERDEFAULT_BOOL4KEY(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define USERDEFAULT_SETBOOL4KEY(bool, key) [[NSUserDefaults standardUserDefaults] setBool:bool forKey:key]

#define kServerURL (@"kServerURL")
#define isNotFirstOpenApp (@"isFirstOpenApp")
#define isLogginApp (@"isLoggin")

#define kUserName (@"userName")
#define kUserPassword (@"password")
#define kUserLocation (@"location")


// net request status
#define STR_REQUEST_LOADING (@"加载中...")
#define STR_REQUEST_SUCCESS (@"请求成功")
#define STR_REQUEST_ERROR (@"请求失败")
#define STR_REQUEST_NODATA (@"暂无数据")
#define STR_REQUEST_NOACCESS (@"无权限")
#define STR_REQUEST_OVERTIME (@"请求超时")
#define STR_DOWNLOAD_SUCCESS (@"下载成功")
#define STR_DOWNLOAD_FAILED (@"下载失败")
#define STR_PASSWORD_ERROR (@"密码错误")
#define STR_REQUEST_OPERATEFAILED (@"操作失败")
#define STR_SAVE_SUCCESS (@"保存成功")
#define STR_SAVE_ERROR (@"保存不成功")
#define STR_SEARCH_NORESULT (@"没有此条件的资产哟")
#define KREQUESTDURATION 1.0

// key constants
#define STR_IS_LOGIN (@"login")
#define kUserLoginname (@"loginname")
#define kUserPassword (@"password")

/**
 *  是否第一次出现,0表示第一次出现，1表示出现了好多次
 */
#define KNOTIFY_FIRSTSHOW @"kfirstShow"

#endif /* Macro_String_h */
