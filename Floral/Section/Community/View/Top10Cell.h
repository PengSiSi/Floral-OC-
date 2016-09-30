//
//  Top10Cell.h
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PublishModel;

@interface Top10Cell : UITableViewCell

@property (nonatomic,strong) PublishModel *model; /*<#name#>*/
@property (nonatomic,strong) NSIndexPath *indexPath; /*<#name#>*/

@property (nonatomic, assign) NSInteger rank;


@end
