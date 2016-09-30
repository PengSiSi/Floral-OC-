//
//  ModelSizeCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/24.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ModelSizeCell.h"

@implementation ModelSizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.satButton.layer.cornerRadius = 3;
    self.satButton.layer.borderColor = GRAY_COLOR.CGColor;
    self.satButton.layer.borderWidth = 1;
    self.weekdayButton.layer.cornerRadius = 3;
    self.weekdayButton.layer.borderColor = GRAY_COLOR.CGColor;
    self.weekdayButton.layer.borderWidth = 1;

}



- (IBAction)SatButton:(id)sender {
}

- (IBAction)weekdayButtonClick:(id)sender {
}
@end
