//
//  ModelSizeCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/24.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelSizeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *selectModelSizeLabel;

@property (weak, nonatomic) IBOutlet UIButton *satButton;
@property (weak, nonatomic) IBOutlet UIButton *weekdayButton;

- (IBAction)SatButton:(id)sender;
- (IBAction)weekdayButtonClick:(id)sender;

@end
