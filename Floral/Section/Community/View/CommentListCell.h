//
//  CommentListCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/23.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@class CommentListCell;

@protocol CommentCellDelegate <NSObject>


// "更多"按钮被点击
- (void)didClickMoreButton: (CommentListCell *)cell;
// "回复"按钮被点击
- (void)didReplyButton: (CommentListCell*)cell;

@end

@interface CommentListCell : UITableViewCell

@property (nonatomic,strong) CommentModel *model; /*<#name#>*/

@property (nonatomic, assign) id<CommentCellDelegate>delegate;

@end
