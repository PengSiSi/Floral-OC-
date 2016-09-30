//
//  PersonInfoCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfoCell : UITableViewCell

@property (nonatomic,strong) UILabel *itemNameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic, assign) BOOL canInput;
@property (nonatomic, assign) BOOL isAvatarImage;
@property (nonatomic, copy) NSString *itemName;

- (instancetype)initWithItemName:(NSString *)itemName canInput:(BOOL)canInput withAvatarImage:(BOOL)isAvatarImage;

+ (instancetype)initWithItemName:(NSString *)itemName canInput:(BOOL)canInput withAvatarImage:(BOOL)isAvatarImage;

@end
