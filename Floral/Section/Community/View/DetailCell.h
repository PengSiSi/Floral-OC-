//
//  DetailCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TieZiListModel.h"
@class DetailCell;

@protocol DetailCellDelegate <NSObject>

- (void)DidClickMoreButton: (DetailCell *)cell;
- (void)DidClickZanButton: (DetailCell *)cell;
- (void)DidClickCommentButton: (DetailCell *)cell;
- (void)DidClickShareButton: (DetailCell *)cell;

@end
@interface DetailCell : UITableViewCell

@property (nonatomic,strong) TieZiListModel *model;
@property (nonatomic, assign) id<DetailCellDelegate>delegate;


@end
