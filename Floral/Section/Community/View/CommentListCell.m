//
//  CommentListCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/23.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "CommentListCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+Utilities.h"

@interface CommentListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
- (IBAction)moreButtonClick:(id)sender;

@end

@implementation CommentListCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.avaterImgView.layer.cornerRadius = 25;
    self.avaterImgView.layer.masksToBounds = YES;
    self.userNameLabel.textColor = [UIColor blackColor];
    self.userNameLabel.font = PUBLISH_CELL_FONT;
    self.desLabel.textColor = GRAY_COLOR;
    self.userNameLabel.font = CELL_FONT;
    self.desLabel.font = PUBLISH_CELL_FONT;
    self.timeLabel.textColor = GRAY_COLOR;
    self.timeLabel.font = PUBLISH_CELL_FONT;
    [self.replyButton addTarget:self action:@selector(replyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(CommentModel *)model{
    
    _model = model;
    [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.model.writer.headImg] placeholderImage:nil];
    self.userNameLabel.text = self.model.writer.userName;
//    self.timeLabel.text = [self dealCreateDate:self.model.createDate];
    // 判空处理
    if (self.model.createDate.length) {
        
        NSString *timeString = [self.model.createDate componentsSeparatedByString:@"."][0];
        self.timeLabel.text = [self dealCreateDate:timeString];
    }
    self.desLabel.text = self.model.content;
}

/**
 *  发布日期处理
 *
 *  @param createString 服务器请求日期数据字符串
 *
 *  @return 返回处理后的显示的字符串
 */
- (NSString *)dealCreateDate: (NSString *)createString{
    
    // 1.把帖子发布时间字符串转换成(NSDate)日期对象 => NSDateFormatter
    // NSDateFormatter:NSStreing与NSDate互转
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 发布日期对象
    NSDate *createDate = [fmt dateFromString:createString];
    
    // 获取日历类对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取日期组件
    NSDateComponents *cmp = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:createDate toDate:[NSDate date] options:NSCalendarWrapComponents];
    
    NSString *timeStr = createString;
    
    if ([createDate isThisYear]) {
        if ([createDate isToday]) {
            
            // 获取日期差值
            if (cmp.hour >= 1) {
                timeStr = [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            } else if (cmp.minute >= 2) {
                timeStr = [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            } else { // 刚刚
                timeStr = @"刚刚";
            }
        } else if ([createDate isYesterday]) { // 昨天
            // 昨天 21:10
            fmt.dateFormat = @"昨天 HH:mm";
            timeStr = [fmt stringFromDate:createDate];
            
        } else { // 昨天之前 08-05 21:10:08
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            timeStr = [fmt stringFromDate:createDate];
        }
    }
    return timeStr;
}


/**
 "更多"按钮被点击

 @param sender button
 */
- (IBAction)moreButtonClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickMoreButton:)]) {
        [self.delegate didClickMoreButton: self];
    }
}

// 回复按钮被点击
- (void)replyButtonClick: (UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(didReplyButton:)]) {
        [self.delegate didReplyButton:self];
    }
}

@end
