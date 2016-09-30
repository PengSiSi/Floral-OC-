//
//  ThemeListModel.m
//  Floral
//
//  Created by 思 彭 on 16/9/9.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ThemeCategoryModel.h"


@implementation ThemeCategoryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{ @"ThemeId" : @"id"};
}

@end
