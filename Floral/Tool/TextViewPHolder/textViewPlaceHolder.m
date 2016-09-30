//
//  textViewPlaceHolder.m
//  TextViewPlaceHolder
//
//  Created by 思 彭 on 16/7/13.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "textViewPlaceHolder.h"

@implementation textViewPlaceHolder

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _placeHolderColor = [UIColor grayColor];
        
        // 接收输入文字的通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

// 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)textDidChange{
    
    if (self.text.length) {
        _isHidePlaceHolder = YES; // 隐藏
    }
    else{
        _isHidePlaceHolder = NO;  // 显示
    }
    [self setNeedsDisplay];
}

    // 重绘

- (void)setPlaceHolderText:(NSString *)placeHolderText{
    
    _placeHolderText = placeHolderText;
    [self setNeedsDisplay];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    if (_isHidePlaceHolder) {
        return;
    }
    
    // 设置画笔颜色
    [_placeHolderColor set];
    
    /*
     NSLineBreakByWordWrapping = 0,  保持单词的完整性
     NSLineBreakByCharWrapping,
     NSLineBreakByClipping,
     NSLineBreakByTruncatingHead,
     NSLineBreakByTruncatingTail,
     NSLineBreakByTruncatingMiddle
     */
    CGFloat paddingX = 2;
    CGFloat paddingY = self.font.lineHeight * 0.4;
    rect.origin.x = paddingX;
    rect.origin.y = paddingY;
    rect.size.height -= 2 * paddingY;
    rect.size.width -= 2 * paddingX;
    
    [_placeHolderText drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByWordWrapping];

}
@end
