//
//  PopOptionsView.h
//  Floral
//
//  Created by 思 彭 on 16/9/11.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopOptionsView;
@protocol PopOptionsViewDelegate <NSObject>

- (void)popOptionsView:(PopOptionsView *)view didSelectOptionAtIndex:(NSUInteger)index;
@end

@interface PopOptionsView : UIView

- (instancetype)initWithWidth:(CGFloat)width contentHeight:(CGFloat)contentHeight delegate:(id<PopOptionsViewDelegate>)delegate itemNames:(NSArray *)itemNames itemImageNames:(NSArray *)itemImageNames hasTriangle:(BOOL)hasTriangle triangleHeight:(CGFloat)triangleHeight triangleTopXOffSet:(CGFloat)triangleTopXOffSet;

// style
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, strong) UIColor *viewBackgroudColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;


@end
