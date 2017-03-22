//
//  DataPickerMenuView.h
//  MobileProject
//
//  Created by LiTengFang on 2017/3/22.
//  Copyright © 2017年 com.boli. All rights reserved.
//

#import "BaseMenuView.h"

typedef void(^SelectedBlock)(NSDate *date);

@interface DatePickerMenuView : BaseMenuView


+ (DatePickerMenuView *)createMenuWithFrame:(CGRect)frame block:(SelectedBlock)block;

@end
