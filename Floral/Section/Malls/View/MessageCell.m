//
//  MessageCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/24.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.messageTextView.placeHolderText = @"请在此处留下你想要的卡片内容";
    self.messageTextView.placeHolderColor = GRAY_COLOR;
    self.messageTextView.layer.borderWidth = 0.5;
    self.messageTextView.layer.borderColor = GRAY_COLOR.CGColor;
}

@end
