//
//  VideoViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "VideoViewController.h"
#import "ThemeListModel.h"
#import "ThemeCell.h"
#import "UIBarButtonItem+Create.h"

static NSString *const identify = @"ThemeCell";


@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate,ThemeListDelegate>
{
    NSInteger currentPageIndex;
}
@end

@implementation VideoViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    ((ThemeCell *)cell).isAddVideo = YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"视频";
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH - 100, 64)];
    titleLabel.text = @"视频";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    [self loadData:currentPageIndex];
    [self createMJRefresh];
    [self setNavItem];
}

- (void)setNavItem{
    
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"back"] highLightedImage:nil target:self action:@selector(backItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.rightBarButtonItems = nil;

}

- (void)loadData: (NSInteger)currentPageIndex1{
    
    [SVProgressHUD show];
    NSString *currentPageIndexStr = [NSString stringWithFormat:@"%ld",currentPageIndex];
    NSDictionary *param = VideoParameter(currentPageIndexStr, @"mainList_NewVersion", @"true");
    [HTTPTool POST:Video_URL headers:nil parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        self.dataArray = [[ThemeListModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]] mutableCopy];
        [self.tableView reloadData];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"AddVideoFlag" object:nil userInfo:nil];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)createMJRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPageIndex = 0;
        [self loadData:currentPageIndex];
    }];;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        currentPageIndex++;
        [self loadData:currentPageIndex];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.listModel = self.dataArray[indexPath.section];
    cell.delegate = self;
    cell.VideoPlayView.hidden = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didVideoPlayClick:(ThemeCell *)cell{
    
    NSLog(@"播放视频...");
    
}

- (void)backItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end