//
//  DatePickerDataSource.m
//  自定义时间选择器
//
//  Created by LiTengFang on 2017/3/22.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

#import "DatePickerDataSource.h"
#import <DateTools.h>
#define MAXYEAR 2050
#define MINYEAR 1970

@interface DatePickerDataSource()
@property(strong,nonatomic) NSMutableArray *yearArray;
@property(strong,nonatomic) NSMutableArray *monthArray;
@property(strong,nonatomic) NSMutableArray *dayArray;
@property(strong,nonatomic) NSArray<NSArray *> *datas;



@end

@implementation DatePickerDataSource {
    NSDate *_startDate;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _startDate = [NSDate date];
        _backGroundColor = [UIColor blackColor];
        _attributedDic = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:13]};
    }
    return self;
}

#pragma mark - getter method
- (NSMutableArray *)yearArray {
    if (_yearArray == nil) {
        _yearArray = [NSMutableArray new];
        for (int i = MINYEAR; i <= MAXYEAR; i++) {
            [_yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    if (_monthArray == nil) {
        _monthArray = [NSMutableArray new];
        for (int i = 1; i < 13; i++) {
            [_monthArray addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    if (_dayArray == nil) {
        _dayArray = [NSMutableArray new];
       NSUInteger num = [self daysfromYear:self.startDate.year andMonth:self.startDate.month];
        for (int i = 1; i <= num; i ++) {
            [_dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
        }
    }
    return _dayArray;
}

- (NSArray *)datas {
    if (_datas == nil) {
        _datas =  @[self.yearArray,self.monthArray,self.dayArray];
    }
    return _datas;
}



#pragma mark - setter method
- (void)setStartDate:(NSDate *)startDate {
    _startDate = startDate;
    
    NSUInteger const num = [self daysfromYear:self.startDate.year andMonth:self.startDate.month];
    [self setdayArray:num];
    
    [self setSelected];
   
}



- (void)setPickView:(UIPickerView *)pickView {
    _pickView = pickView;
    pickView.delegate = self;
    pickView.dataSource = self;
    pickView.backgroundColor = self.backGroundColor;
    [self setSelected];
}

- (void)setBackGroundColor:(UIColor *)backGroundColor {
    _backGroundColor = backGroundColor;
    self.pickView.backgroundColor = backGroundColor;
}

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.datas.count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.datas[component].count;
}

#pragma mark - UIPickerViewDelegate
//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [[NSAttributedString alloc]initWithString:self.datas[component][row] attributes:self.attributedDic];
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *myView;
    
    if (component == 0) {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = self.datas[component][row];
        
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.textColor = [UIColor whiteColor];
        
        myView.backgroundColor = [UIColor clearColor];
        
    } else {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 40, 30)] ;
        
        myView.text = self.datas[component][row];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:14];
        
        myView.textColor = [UIColor whiteColor];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    
    return myView;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    
    NSUInteger const num = [self daysfromYear:[pickerView selectedRowInComponent:0] + MINYEAR
                                     andMonth:[pickerView selectedRowInComponent:1] + 1];
    [self setdayArray:num];
    
    [pickerView reloadAllComponents];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (component) {
        case 0:
           return 80;
            break;
            
        default:
            return 40;
            break;
    }
}

- (NSDate *)selectDate {
    NSUInteger year = [self.pickView selectedRowInComponent:0] + MINYEAR;
    NSUInteger month = [self.pickView selectedRowInComponent:1] + 1;
    NSUInteger day = [self.pickView selectedRowInComponent:2] + 1;
    
    NSString *string = [NSString stringWithFormat:@"%d-%d-%d",year,month,day];
    
    return [NSDate dateWithString:string formatString:@"yyyy-MM-dd"];
}

#pragma mark -private method
//通过年月求每月天数
- (NSInteger)daysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_month = month;
    
   
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
  
            return 31;
        }
        case 4:case 6:case 9:case 11:{
        
            return 30;
        }
        case 2:{
            if ([self isRunNianWithYear:year]) {
        
                return 29;
            }else{
            
                return 28;
            }
        }
        default:
            return 0;
            break;
    }
    
}



- (BOOL)isRunNianWithYear:(NSInteger)year {
    
    BOOL mod4 = year % 4 == 0 ? YES : NO ;
    BOOL mod100 = year % 100 == 0 ? YES : NO;
    BOOL mod400 = year % 400 == 0 ? YES : NO;
    
    return (mod4 && !mod100)|| mod400;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    if (self.dayArray.count == num) {
        return;
    }
    
    [self.dayArray removeAllObjects];
    for (int i = 1; i <= num; i++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}


- (void)setSelected {
    
    
    NSString *year = [NSString stringWithFormat:@"%04d",self.startDate.year];
    NSString *month = [NSString stringWithFormat:@"%02d",self.startDate.month];
    NSString *day = [NSString stringWithFormat:@"%02d",self.startDate.day];
    
    
    
    [self.pickView selectRow:[self.yearArray indexOfObject:year] inComponent:0 animated:NO];
    [self.pickView selectRow:[self.monthArray indexOfObject:month] inComponent:1 animated:NO];
    [self.pickView selectRow:[self.dayArray indexOfObject:day] inComponent:2 animated:NO];
}
@end
