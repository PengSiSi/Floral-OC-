//
//  ThemeViewController.h
//  Floral
//
//  Created by 思 彭 on 16/9/8.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "BaseViewController.h"
@class ThemeCell;

@interface ThemeViewController : BaseViewController
{
    ThemeCell *cell;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
