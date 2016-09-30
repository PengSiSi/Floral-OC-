//
//  ArticleViewController.m
//  Floral
//
//  Created by 思 彭 on 16/9/20.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ArticleViewController.h"
#import "ThemeListModel.h"
#import "UIBarButtonItem+Create.h"

@interface ArticleViewController ()

//@property (nonatomic, strong) NSArray *dataArray;
{
    NSInteger currentPageIndex;
}
@end

@implementation ArticleViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"文章";
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH - 100, 64)];
    titleLabel.text = @"文章";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
//    self.navigationItem.titleView.hidden = YES;
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
    NSDictionary *param = ArticleParameter(currentPageIndexStr, @"mainList_NewVersion", @"false");
    [HTTPTool POST:Article_URL headers:nil parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
            self.dataArray = [[ThemeListModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]] mutableCopy];
        [self.tableView reloadData];
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

- (void)backItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
