//
//  JingXuanCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TieZiListModel;

@interface JingXuanCell1 : UICollectionViewCell

@property (nonatomic,strong) TieZiListModel *model;
@property (nonatomic,assign) BOOL isShowPhoto; /*判断是不是需要展示*/
@property (nonatomic,strong) NSString *imgName;

@end
