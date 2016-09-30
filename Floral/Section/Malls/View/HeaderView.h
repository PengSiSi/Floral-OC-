//
//  HeaderView.h
//  Floral
//
//  Created by 思 彭 on 16/9/14.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headViewDelegate <NSObject>

- (void)didTagButton: (NSInteger)buttonTag;

@end
@interface HeaderView : UICollectionReusableView


@property (nonatomic, assign) id<headViewDelegate>delegate;
@property (nonatomic,strong) NSArray *imageArray;

@end
