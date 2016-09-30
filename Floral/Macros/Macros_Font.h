//
//  Macros_Font.h
//  baiduMap
//
//  Created by Mike on 16/3/29.
//  Copyright © 2016年 Mike. All rights reserved.
//

#ifndef Macros_Font_h
#define Macros_Font_h

#define TABBARITEM_FONT [UIFont fontWithName:@"STHeitiTC-Medium" size:12.f]

//详情信息字体
#define DETAIL_LIST_BASEINFO_FONT [UIScreen mainScreen].bounds.size.width > 320 ? [UIFont systemFontOfSize:15] : [UIFont systemFontOfSize:12]

// 设置cell字体
#define CELL_FONT [UIScreen mainScreen].bounds.size.width > 320 ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:12]
// 设置cell内容字体
#define CELL_CONTENT_FONT [UIScreen mainScreen].bounds.size.width > 320 ? [UIFont systemFontOfSize:15] : [UIFont systemFontOfSize:12]

// 设置社区导航栏按钮字体
#define NAV_BUTTON_FONT [UIScreen mainScreen].bounds.size.width > 320 ? [UIFont systemFontOfSize:14] : [UIFont systemFontOfSize:12]

// 设置订阅页面cell字体
#define PUBLISH_CELL_FONT [UIScreen mainScreen].bounds.size.width > 320 ? [UIFont systemFontOfSize:13] : [UIFont systemFontOfSize:11]

// 设置排名cell大字体
#define Rank_CELL_FONT [UIScreen mainScreen].bounds.size.width > 320 ? [UIFont systemFontOfSize:22] : [UIFont systemFontOfSize:15]

#endif /* Macros_Font_h */
