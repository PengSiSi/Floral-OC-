//
//  XFDateView.m
//  XFPickerViewDemo

//  Copyright © 2016年 BigFly. All rights reserved.
//

#import "XFDaterView.h"
@interface XFDaterView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIView *daterContentView;
    UILabel *daterLab;
    UIPickerView *picker;
    UIButton *cancelBtn;
    UIButton *sureBtn;
    int nowYear;
    NSArray *dayArr1;
    NSArray *dayArr2;
    NSMutableArray *yearArr;
    NSMutableArray *hourArr;
    NSMutableArray *miniuteArr;
}
@end

@implementation XFDaterView

#pragma mark - init初始化
- (void)initData{
    dayArr1 = @[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    dayArr2 = @[@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [formatter setDateFormat:@"yyyy"];
    _year = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"MM"];
    _month = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"dd"];
    _day = [[formatter stringFromDate:date] intValue];
    yearArr = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i+_year];
        [yearArr addObject:str];
    }
    nowYear = _year;
    
    [formatter setDateFormat:@"HH"];
    _hour = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"mm"];
    _miniute = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"ss"];
    _second = [[formatter stringFromDate:date] intValue];
    hourArr = [NSMutableArray array];
    miniuteArr = [NSMutableArray array];
    for (int i = 0; i<24; i++) {
        NSString *str = [NSString stringWithFormat:@"%02d",i];
        [hourArr addObject:str];
    }
    for (int i = 0; i<60; i++) {
        NSString *str = [NSString stringWithFormat:@"%02d",i];
        [miniuteArr addObject:str];
    }
    
}
- (void)initViews{
    self.frame=[UIScreen mainScreen].bounds;
    self.backgroundColor=RGBA(0, 0, 0, 0.3);
    daterContentView = [[UIView alloc]initWithFrame:Frame(WH(40), WH(200), SCREEN_WIDTH-WH(80), WH(200))];
    daterContentView.backgroundColor=WhiteColor;
    [self addSubview:daterContentView];
    daterContentView.layer.masksToBounds=YES;
    daterContentView.layer.cornerRadius=8;
    
    daterLab=[[UILabel alloc]initWithFrame:Frame(0, 0, daterContentView.w, WH(30))];
    daterLab.text=@"选择日期";
    daterLab.backgroundColor=[UIColor grayColor];
    daterLab.font=Font(14);
    daterLab.textColor=BlackFontColor;
    daterLab.textAlignment=1;
    [daterContentView addSubview:daterLab];
    
    picker = [[UIPickerView alloc]initWithFrame:Frame(WH(20), daterLab.h, SCREEN_WIDTH-WH(120), WH(130))];
    picker.dataSource=self;
    picker.delegate=self;
    [daterContentView addSubview:picker];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = Frame(0, picker.h+picker.y, daterContentView.w/2.0, WH(40));
    [cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [daterContentView addSubview:cancelBtn];
    cancelBtn.backgroundColor=[UIColor grayColor];
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = Frame(daterContentView.w/2.0, cancelBtn.y, daterContentView.w/2.0, cancelBtn.h);
    [sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [daterContentView addSubview:sureBtn];
    sureBtn.backgroundColor=[UIColor grayColor];
    UIView *verLine=[[UIView alloc]initWithFrame:Frame(cancelBtn.w, cancelBtn.y, 1, cancelBtn.h)];
    verLine.backgroundColor=WhiteColor;
    [daterContentView addSubview:verLine];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initViews];
        [self initData];
        
        [picker selectRow:[self midNum:10] inComponent:0 animated:YES];
        [picker selectRow:_month-1+[self midNum:12] inComponent:1 animated:YES];
        [picker selectRow:_day-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:YES];
        self.dateString = [NSString stringWithFormat:@"%d-%02d-%02d",_year,_month,_day];
        self.timeString = [NSString stringWithFormat:@"%d:%02d:%02d",_hour,_miniute,_second];
        //NSLog(@"dateString=%@ timeString=%@",self.dateString,self.timeString);
        
    }
    return self;
}


#pragma mark - pickerView delagate,datasource
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    if (_dateViewType == XFDateViewTypeDate) {
        NSUInteger mid = 0;
        NSUInteger rowIndex = 0;
        if(component == 0){
            mid = [self midNum:(int)yearArr.count];
            rowIndex = row%yearArr.count;
            [picker selectRow:rowIndex+mid inComponent:0 animated:NO];
            _year = [yearArr[[picker selectedRowInComponent:0]%yearArr.count] intValue];
            if (_day <= [self daysInSelectMonth]) {
                [picker selectRow:_day-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:NO];
            }else{
                [picker selectRow:[self daysInSelectMonth]-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:NO];
            }
            
        }else if (component == 1){
            mid = [self midNum:12];
            rowIndex = row%12;
            [picker selectRow:rowIndex+mid inComponent:1 animated:NO];
            //3.31-4.30有bug
            if (_day <= [self daysInSelectMonth]) {
                [picker selectRow:_day-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:NO];
            }else{
                [picker selectRow:[self daysInSelectMonth]-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:NO];
            }
            _month = (int)[picker selectedRowInComponent:1]%12+1;
        }else if (component == 2){
            mid = [self midNum:[self daysInSelectMonth]];
            rowIndex = row%[self daysInSelectMonth];
            [picker selectRow:rowIndex+mid inComponent:2 animated:NO];
            
        }
        _day = (int)[picker selectedRowInComponent:2]%[self daysInSelectMonth]+1;
        self.dateString = [NSString stringWithFormat:@"%d-%02d-%02d",_year,_month,_day];
    }else if (_dateViewType == XFDateViewTypeTime){
        NSUInteger mid = 0;
        NSUInteger rowIndex = 0;
        if (component==0) {
            mid = [self midNum:24];
            rowIndex = row%24;
            [picker selectRow:rowIndex+mid inComponent:0 animated:NO];
            _hour = [hourArr[rowIndex] intValue];
        }else if (component==1){
            mid = [self midNum:60];
            rowIndex = row%60;
            [picker selectRow:rowIndex+mid inComponent:1 animated:NO];
            _miniute = [miniuteArr[rowIndex] intValue];
        }else if (component==2){
            mid = [self midNum:60];
            rowIndex = row%60;
            [picker selectRow:rowIndex+mid inComponent:2 animated:NO];
            _second = [miniuteArr[rowIndex] intValue];
        }
        self.timeString = [NSString stringWithFormat:@"%d:%02d:%02d",_hour,_miniute,_second];
    }
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int count = 0;
    if (_dateViewType == XFDateViewTypeDate) {
        if(component == 0){
            count = (int)yearArr.count;
        }else if(component == 1){
            count = 12;
        }else{
            //获得前二个滚轮的当前所选行的索引
            count = [self daysInSelectMonth];
        }
    }else if (_dateViewType == XFDateViewTypeTime){
        if(component == 0){
            count = 24;
        }else if(component == 1 || component==2){
            count = 60;
        }
    }
    return count*50;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *rowLab = [[UILabel alloc] init];
    rowLab.textAlignment = NSTextAlignmentCenter;
    rowLab.backgroundColor = [UIColor clearColor];
    rowLab.frame = CGRectMake(0, 0, daterContentView.w/3.0, 50);
    [rowLab setFont:[UIFont systemFontOfSize:16]];
    if (_dateViewType == XFDateViewTypeDate) {
        if(component == 0){
            rowLab.text = [NSString stringWithFormat:@"%@年",yearArr[row%yearArr.count]];
        }else if(component == 1){
            rowLab.text = [NSString stringWithFormat:@"%ld月",row%12+1];
        }else{
            rowLab.text = [NSString stringWithFormat:@"%ld日",row%[self daysInSelectMonth]+1];
        }
    }else if (_dateViewType == XFDateViewTypeTime){
        if(component == 0){
            rowLab.text = [NSString stringWithFormat:@"%@时",hourArr[row%24]];
        }else if(component == 1){
            rowLab.text = [NSString stringWithFormat:@"%@分",miniuteArr[row%60]];
        }else{
            rowLab.text = [NSString stringWithFormat:@"%@秒",miniuteArr[row%60]];
        }
    }
    //NSLog(@"row=%ld",(long)row);
    return rowLab;
}

#pragma mark - Public Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated{
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}
- (void)setSelectYear:(int)year month:(int)month day:(int)day animated:(BOOL)animated{
    _year = year;
    _month = month;
    _day = day;
    self.dateString = [NSString stringWithFormat:@"%d-%02d-%02d",_year,_month,_day];
    [picker selectRow:[self midNum:10]+year-nowYear inComponent:0 animated:YES];
    [picker selectRow:_month-1+[self midNum:12] inComponent:1 animated:YES];
    [picker selectRow:_day-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:YES];
    
}
- (void)setSelectHour:(int)hour miniute:(int)miniute second:(int)second animated:(BOOL)animated{
    _hour = hour%24;
    _miniute = miniute%60;
    _second = second%60;
    _timeString = [NSString stringWithFormat:@"%d:%02d:%02d",_hour,_miniute,_second];
    [picker selectRow:_hour+[self midNum:24] inComponent:0 animated:YES];
    [picker selectRow:_miniute+[self midNum:60] inComponent:1 animated:YES];
    [picker selectRow:_second+[self midNum:60] inComponent:2 animated:YES];
    NSLog(@"timeString=%@",_timeString);
}

- (void)setDateViewType:(XFDateViewType)dateViewType{
    _dateViewType = dateViewType;
    if (_dateViewType == XFDateViewTypeDate) {
        daterLab.text=@"选择日期";
    }else if (_dateViewType == XFDateViewTypeTime){
        daterLab.text=@"选择时间";
        [picker reloadAllComponents];
        [picker selectRow:_hour+[self midNum:24] inComponent:0 animated:YES];
        [picker selectRow:_miniute+[self midNum:60] inComponent:1 animated:YES];
        [picker selectRow:_second+[self midNum:60] inComponent:2 animated:YES];
        _timeString = [NSString stringWithFormat:@"%d:%02d:%02d",_hour,_miniute,_second];
        NSLog(@"timeString=%@",_timeString);
    }
    
}
#pragma mark - Private Methods
- (void)fadeIn{
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
    }];
    
}
- (void)fadeOut{
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if (finished){
            [self removeFromSuperview];
        }
    }];
}
- (int)daysInSelectMonth{
    int count = 0;
    int row = (int)[picker selectedRowInComponent:0]%yearArr.count;
    int nowyear = [yearArr[row] intValue];
    int nowmonth = (int)[picker selectedRowInComponent:1]%12;
    if ((nowyear % 4 == 0 && nowyear % 100 !=0 )||(nowyear % 400 == 0)) {
        count = [[dayArr2 objectAtIndex:nowmonth] intValue];
    }else{
        count = [[dayArr1 objectAtIndex:nowmonth] intValue];
    }
    return count;
}
- (int)midNum:(int)arrCount{
    int mid = (arrCount*50/2)-(arrCount*50/2)%arrCount;
    return mid;
}
#pragma mark - delegate
- (void)sureAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(daterViewDidClicked:)]) {
        [self.delegate daterViewDidClicked:self];
    }
    [self fadeOut];
}
- (void)cancelAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(daterViewDidCancel:)]) {
        [self.delegate daterViewDidCancel:self];
    }
    [self fadeOut];
}


@end
@implementation UIView (Category)

#pragma mark-- setter,getter方法(深度赋值，取值)--
- (void) setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame=CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
    self.frame=frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void) setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame=CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    self.frame=frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void) setW:(CGFloat)w{
    CGRect frame=self.frame;
    frame=CGRectMake(frame.origin.x, frame.origin.y, w, frame.size.height);
    self.frame=frame;
}
- (CGFloat)w{
    return self.frame.size.width;
}
- (void) setH:(CGFloat)h{
    CGRect frame=self.frame;
    frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, h);
    self.frame=frame;
}
- (CGFloat)h{
    return self.frame.size.height;
}

@end