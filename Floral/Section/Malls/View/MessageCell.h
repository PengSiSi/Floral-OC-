//
//  MessageCell.h
//  Floral
//
//  Created by 思 彭 on 16/9/24.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "textViewPlaceHolder.h"

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet textViewPlaceHolder *messageTextView;

@end
