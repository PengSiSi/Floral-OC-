//
//  PopOptionsView.m
//  Floral
//
//  Created by 思 彭 on 16/9/11.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "PopOptionsView.h"

UIImage *tintedImage(UIImage *originImage, UIColor *tintColor) {
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, originImage.scale);
    CGRect rect = CGRectMake(0, 0, originImage.size.width, originImage.size.height);
    [tintColor set];
    UIRectFill(rect);
    [originImage drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@interface PopOptionsView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, weak) id<PopOptionsViewDelegate> delegate;
@property (nonatomic, strong) NSArray *itemNames;
@property (nonatomic, strong) NSArray *itemImageNames;
@property (nonatomic, assign) BOOL hasTriangle;
@property (nonatomic, assign) CGFloat triangleHeight;
@property (nonatomic, assign) CGFloat triangleTopXOffSet;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PopOptionsView

- (instancetype)initWithWidth:(CGFloat)width contentHeight:(CGFloat)contentHeight delegate:(id<PopOptionsViewDelegate>)delegate itemNames:(NSArray *)itemNames itemImageNames:(NSArray *)itemImageNames hasTriangle:(BOOL)hasTriangle triangleHeight:(CGFloat)triangleHeight triangleTopXOffSet:(CGFloat)triangleTopXOffSet {
    if (self = [super init]) {
        CGRect frame = self.frame;
        frame.size.width = width;
        frame.size.height = hasTriangle ? contentHeight + triangleHeight : contentHeight;
        self.frame = frame;
        _contentWidth = width;
        _contentHeight = contentHeight;
        _delegate = delegate;
        _itemNames = itemNames;
        _itemImageNames = itemImageNames;
        _hasTriangle = hasTriangle;
        _triangleHeight = triangleHeight;
        _triangleTopXOffSet = triangleTopXOffSet;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, triangleHeight, width, contentHeight)];
        [self addSubview:tableView];
        _tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor clearColor];
    self.viewBackgroudColor = [UIColor colorWithRed:63 / 255.0 green:63 / 255.0 blue:63 / 255.0 alpha:1];
    self.separatorColor = [UIColor colorWithRed:132 / 255.0 green:132 / 255.0 blue:132 / 255.0 alpha:1];
    _textColor = [UIColor whiteColor];
    _textFont = [UIFont systemFontOfSize:15.f];
    
    _tableView.layer.cornerRadius = 2.f;
    _tableView.layer.masksToBounds = YES;
    _tableView.scrollEnabled = NO;
    _tableView.separatorInset = UIEdgeInsetsZero;
    
}
#pragma mark - setter

- (void)setViewBackgroudColor:(UIColor *)viewBackgroudColor {
    _viewBackgroudColor = viewBackgroudColor;
    
    _tableView.backgroundColor = _viewBackgroudColor;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _tableView.separatorColor = separatorColor;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
        cell.backgroundColor = _viewBackgroudColor;
        
        UIView *view = [[UIView alloc] init];
        CGFloat minusValue = 0.1;
        CGFloat r = 0, g = 0, b = 0, a = 0;
        [_viewBackgroudColor getRed:&r green:&g blue:&b alpha:&a];
        r -= minusValue; g -= minusValue; b -= minusValue;
        if (r < 0.f) r = 0.f;
        if (g < 0.f) g = 0.f;
        if (b < 0.f) b = 0.f;
        view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
        cell.selectedBackgroundView = view;
        
        cell.textLabel.textColor = _textColor;
        cell.textLabel.font = _textFont;
        cell.textLabel.textAlignment = _textAlignment;
    }
    cell.textLabel.text = _itemNames[indexPath.row];
    if (_itemImageNames.count > indexPath.row) {
        UIImage *originImage = [UIImage imageNamed:_itemImageNames[indexPath.row]];
        //        cell.imageView.image = tintedImage(originImage, _textColor);
        cell.imageView.image = originImage;
    } else {
        cell.imageView.image = nil;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(popOptionsView:didSelectOptionAtIndex:)]) {
        [self.delegate popOptionsView:self didSelectOptionAtIndex:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _itemNames.count ? (_contentHeight + 1) / (CGFloat)_itemNames.count : 44.f;
}

#pragma mark - redraw

- (void)drawRect:(CGRect)rect {
    if (_hasTriangle) {
        CGPoint originPoint = {_triangleTopXOffSet - _triangleHeight / sqrt(3.0), _triangleHeight};
        CGPoint topPoint = {_triangleTopXOffSet, 0};
        CGPoint rightPoint = {_triangleTopXOffSet + _triangleHeight / sqrt(3.0), _triangleHeight};
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, originPoint.x, originPoint.y);
        CGContextAddLineToPoint(context, topPoint.x, topPoint.y);
        CGContextAddLineToPoint(context, rightPoint.x, rightPoint.y);
        CGContextClosePath(context);
        [_viewBackgroudColor setFill];
        [_viewBackgroudColor setStroke];
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

@end
