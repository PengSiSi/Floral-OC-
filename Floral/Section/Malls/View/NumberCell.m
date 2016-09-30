//
//  NumberCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/24.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "NumberCell.h"

@interface NumberCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberlabel;
- (IBAction)reduceButtonClick:(id)sender;
- (IBAction)addButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *numberLabel;

@end

@implementation NumberCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


- (IBAction)reduceButtonClick:(id)sender {
    
    NSLog(@"减少");
}

- (IBAction)addButtonClick:(id)sender {
    NSLog(@"增加");

}
@end
