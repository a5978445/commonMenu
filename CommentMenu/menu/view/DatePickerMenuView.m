//
//  DataPickerMenuView.m
//  MobileProject
//
//  Created by LiTengFang on 2017/3/22.
//  Copyright © 2017年 com.boli. All rights reserved.
//

#import "DatePickerMenuView.h"
#import "DatePickerDataSource.h"

@interface DatePickerMenuView()
@property (nonatomic,strong,readonly) UIView * contentView;
@property (nonatomic,strong) DatePickerDataSource *dataSource;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (copy,nonatomic) SelectedBlock block;
@end

@implementation DatePickerMenuView {
    UIView *_contentView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


+ (DatePickerMenuView *)createMenuWithFrame:(CGRect)frame block:(SelectedBlock)block{
    
    CGFloat menuWidth = frame.size.width ? frame.size.width : 120;
    
    DatePickerMenuView *menuView = [[DatePickerMenuView alloc] initWithFrame:CGRectMake(0, 0, 180, 200)];
    menuView.block = block;
    return menuView;
}

#pragma mark -getter method
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [UIView new];
        _contentView.frame = CGRectMake(0, 0, 180, 200);
        _contentView.backgroundColor = [UIColor clearColor];
        
        [_contentView addSubview:self.pickerView];
        
        
        UIButton *left = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 36)];
        [left setTitle:@"确定" forState:UIControlStateNormal];
        [left setBackgroundColor:[UIColor clearColor]];
        [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        left.titleLabel.font = [UIFont systemFontOfSize:15];
        [left addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(130, 10, 40, 36)];
        [right setTitle:@"取消" forState:UIControlStateNormal];
        [right setBackgroundColor:[UIColor clearColor]];
        [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        right.titleLabel.font = [UIFont systemFontOfSize:15];
        [right addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentView addSubview:left];
        [_contentView addSubview:right];
        
        
    }
    return _contentView;
}



- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        
        _pickerView = [UIPickerView new];
     
        _pickerView.frame = CGRectMake(0, 44, 180, 200 - 44);
 
        
        self.dataSource.pickView = _pickerView;
        self.dataSource.backGroundColor = [UIColor clearColor];
    }
    return _pickerView;
}

- (DatePickerDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [DatePickerDataSource new];
    }
    return _dataSource;
}

- (void)cancel {
    [self hidden];
}

- (void)sure {
   
    
    if (self.block) {
        self.block([self.dataSource selectDate]);
    }
}

@end
