//
//  DetailCell.m
//  Floral
//
//  Created by 思 彭 on 16/9/21.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+Utilities.h"
#import "JingXuanCell1.h"
#import "ImageCell.h"
#import "ImageCollectionView.h"

@interface DetailCell ()
{
    NSArray *imagesArray;  // 详情多张图片展示
}
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**
 *  更多
 */
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
/**
 *  "更多"按钮被点击
 *
 *  @param sender <#sender description#>
 */
- (IBAction)moreBUttonClick:(id)sender;
/**
 *  collectionView
 */
@property (weak, nonatomic) IBOutlet UIView *imagesView;
/**
 *  赞
 */
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/**
 *  分享
 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *morningLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *morningLabelTop;
@property (nonatomic,strong) ImageCollectionView *collectionView;

@end

@implementation DetailCell

- (void)awakeFromNib {

    [super awakeFromNib];
    // Xcode 8必须自己设置,不然不显示
    self.avaterImgView.layer.cornerRadius = 25;
    self.avaterImgView.layer.masksToBounds = YES;
    self.userNameLabel.font = CELL_FONT;
    self.contentLabel.font = PUBLISH_CELL_FONT;
    self.timeLabel.font = PUBLISH_CELL_FONT;
    self.morningLabel.font = PUBLISH_CELL_FONT;
    self.userNameLabel.textColor = [UIColor blackColor];
    self.contentLabel.textColor = GRAY_COLOR;
    self.timeLabel.textColor = GRAY_COLOR;
    self.morningLabel.textColor = GRAY_COLOR;
    [self.loveButton setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
    [self.commentButton setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
    [self.shareButton setTitleColor:GRAY_COLOR forState:UIControlStateNormal];
    self.loveButton.titleLabel.font = PUBLISH_CELL_FONT;
    self.commentButton.titleLabel.font = PUBLISH_CELL_FONT;
    self.shareButton.titleLabel.font = PUBLISH_CELL_FONT;
    
    // 创建collectionView
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((K_SCREEN_WIDTH - 15) / 2, (K_SCREEN_WIDTH - 15) / 2);
    layout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[ImageCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.imagesView addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ImageCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];

}

- (void)setModel:(TieZiListModel *)model{
    
    _model = model;
    [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:self.model.customer.headImg] placeholderImage:[UIImage imageNamed:@"p_avatar"]];
    self.userNameLabel.text = self.model.customer.userName;
    if ([self.model.customer.content isEqualToString:@""]) {
        
        self.contentLabel.text = @"这家伙很懒,什么也没留下";
    }
    else{
        self.contentLabel.text = self.model.content;
    }
    self.morningLabel.text = self.model.content;
    [self.loveButton setTitle:[NSString stringWithFormat:@"%ld",self.model.read] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%ld",self.model.comment] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",self.model.share] forState:UIControlStateNormal];
    // 判空处理
    if (self.model.createDate.length) {
        
        NSString *timeString = [self.model.createDate componentsSeparatedByString:@"."][0];
        self.timeLabel.text = [self dealCreateDate:timeString];
    }
    NSString *attachment = self.model.attachment;
    NSArray *imgArray = [attachment componentsSeparatedByString:@","];
    
    [self.collectionView reloadData];
    self.collectionView.frame = CGRectMake(0, self.imagesView.mj_y - 70, self.imagesView.width, [self getCollectionViewHeight]);
    self.model.cellHeight = 70 + 70 + [self getCollectionViewHeight];

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
 更多按钮被点击

 @param sender 点击的按钮
 */
- (IBAction)moreBUttonClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(DidClickMoreButton:)]) {
        [self.delegate DidClickMoreButton:self];
    }
}
- (IBAction)zanButtonClick:(id)sender {
    
    [sender setImage:[UIImage imageNamed:@"p_zan-selected"] forState:UIControlStateSelected];
}
- (IBAction)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DidClickCommentButton:)]) {
        [self.delegate DidClickCommentButton:self];
    }
}
- (IBAction)shareButtonClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(DidClickShareButton:)]) {
        [self.delegate DidClickShareButton:self];
    }
}

    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        
        NSString *attachment = self.model.attachment;
        NSArray *imgArray = [attachment componentsSeparatedByString:@","];
        return imgArray.count;
    }
    
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *attachment = self.model.attachment;
    cell.backgroundColor = [UIColor greenColor];
    NSArray *imgArray = [attachment componentsSeparatedByString:@","];
    cell.imageName = imgArray[indexPath.row];
    return cell;
}
    
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,5,0,5);
}
    
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((K_SCREEN_WIDTH - 15) / 2, (K_SCREEN_WIDTH - 15) / 2);
}
    
- (CGFloat)getCollectionViewHeight{
    
    CGFloat collectionViewHeight = 0.0;
    CGFloat height = 0.0;
    NSString *attachment = self.model.attachment;
    NSArray *imgArray = [attachment componentsSeparatedByString:@","];
    if (imgArray.count % 2 != 0) {
        
        height = imgArray.count / 2 + 1;
    }
    else{
        height = imgArray.count / 2;
    }
    collectionViewHeight = height * ((K_SCREEN_WIDTH - 15) / 2) + ((height + 1)* 5);
    return collectionViewHeight;
}

@end
