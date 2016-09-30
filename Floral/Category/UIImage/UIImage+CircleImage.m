//
//  UIImage+CircleImage.m
//  小技巧Text
//
//  Created by 思 彭 on 16/8/19.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
