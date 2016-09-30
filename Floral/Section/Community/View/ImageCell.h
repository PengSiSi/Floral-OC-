//
//  ImageCell.h
//  ImageShowCell
//
//  Created by 思 彭 on 16/9/29.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UICollectionViewCell

@property (nonatomic,strong) NSString *imageName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
