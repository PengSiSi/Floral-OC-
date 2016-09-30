
//
//  Macros_Color.h
//  baiduMap
//
//  Created by Mike on 16/3/29.
//  Copyright © 2016年 Mike. All rights reserved.
//

#ifndef Macros_Color_h
#define Macros_Color_h

// Method Macro
#define ColorRGB(r, g, b) ([UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f])

#define ColorRGBA(r, g, b, a) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)])

// Constants
// 主色调：绿色
#define MAIN_GREEN_COLOR ([UIColor colorWithHex:@"#2fb99d"])

//TabBarItem的字体颜色
#define TABBAR_GRAY_COLOR ColorRGB(105,105,105)

//主题页面 type颜色
#define THEME_ORANGE_COLOR ColorRGB(255,218,105)

// 字体灰色
#define GRAY_COLOR ColorRGB(190,190,190)

// vie为浅灰色背景颜色
#define VIEW_GRAY_COLOR ColorRGBA(211,211,211,0.5)

// 字体橙色
#define PRICE_COLOR ColorRGB(255,218,185)

// 黑色
#define BLACK_COLOR ColorRGB(0,0,0)

// 白色
#define WHITE_COLOR ColorRGB(255,255,255)

#endif /* Macros_Color_h */
