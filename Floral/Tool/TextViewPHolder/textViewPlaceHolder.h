//
//  textViewPlaceHolder.h
//  TextViewPlaceHolder
//
//  Created by 思 彭 on 16/7/13.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface textViewPlaceHolder : UITextView

@property (nonatomic, assign) BOOL isHidePlaceHolder; // 是否显示placeHolder
@property (nonatomic, strong) UIColor *placeHolderColor;// placeHolder颜色
@property (nonatomic , strong) NSString *placeHolderText;// placeHolder文字

@end
