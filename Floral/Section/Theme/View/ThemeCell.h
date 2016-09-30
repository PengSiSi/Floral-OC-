//
//  ThemeCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/9.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThemeCell;
@class ThemeListModel;

@protocol ThemeListDelegate <NSObject>

- (void)didLookButtonClick: (ThemeCell *)cell;
- (void)didLikeButtonClick: (ThemeCell *)cell;
- (void)didCommentButtonClick: (ThemeCell *)cell;
- (void)didAvaterClick: (ThemeCell *)cell;
- (void)didVideoPlayClick: (ThemeCell *)cell;

@end

@interface ThemeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *VideoPlayView;

@property (nonatomic,strong) ThemeListModel *listModel; /*<#name#>*/

@property (nonatomic, assign) id<ThemeListDelegate>delegate;

@property (nonatomic, assign) BOOL isAddVideo;



@end
