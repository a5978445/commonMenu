//
//  DatePickerDataSource.h
//  自定义时间选择器
//
//  Created by LiTengFang on 2017/3/22.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerDataSource : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong,nonatomic) NSDate *startDate;

@property(weak,nonatomic) UIPickerView *pickView;
@property(strong,nonatomic) NSDictionary *attributedDic;
@property(strong,nonatomic) UIColor *backGroundColor;

- (NSDate *)selectDate;


@end
