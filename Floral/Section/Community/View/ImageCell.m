//
//  ImageCell.m
//  ImageShowCell
//
//  Created by 思 彭 on 16/9/29.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ImageCell.h"
#import "UIImageView+WebCache.h"

@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageName:(NSString *)imageName{
    
    _imageName = imageName;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageName]];
}
@end
