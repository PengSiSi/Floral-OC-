//
//  AddPublishHeaderView.h
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickRecommendClick)();

@interface AddPublishHeaderView : UIView

@property (nonatomic,copy) ClickRecommendClick block; /*<#id#>*/

- (CGFloat)getHeight;

@end
