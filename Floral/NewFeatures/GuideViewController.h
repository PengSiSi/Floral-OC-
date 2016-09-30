//
//  GuideViewController.h
//  Floral
//
//  Created by 思 彭 on 16/9/8.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "BaseViewController.h"

/**
 *  滑动到最后一页
 */
typedef void(^scrollFinish)();

@interface GuideViewController : BaseViewController

@property (nonatomic, copy) scrollFinish scrollEnd;

@end
