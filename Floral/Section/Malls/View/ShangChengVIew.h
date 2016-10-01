//
//  ShangChengVIew.h
//  Floral
//
//  Created by 思 彭 on 16/10/1.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShangChengVIew : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *desLabe;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)goButton:(id)sender;

@end
