//
//  AddPhotoCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/12.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddPhotoCell;

typedef void(^DidSelectAddPhoto)();

@protocol AddPhotoCellDelegate <NSObject>

- (void)didAddPhoto: (AddPhotoCell *)cell;

@end

@interface AddPhotoCell : UITableViewCell

@property (nonatomic,copy) DidSelectAddPhoto block; /*<#id#>*/
@property (nonatomic,strong) NSArray *imgArray;
@property (nonatomic,assign) id<AddPhotoCellDelegate>delegate; /*<#number#>*/

@end
