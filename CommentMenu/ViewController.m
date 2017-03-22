//
//  ViewController.m
//  CommentMenu
//
//  Created by LiTengFang on 2017/3/22.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

#import "ViewController.h"
#import "CommonMenuView.h"
#import "DatePickerMenuView.h"


@interface ViewController ()
@property(strong,nonatomic) CommonMenuView *commonMenuView;
@property(strong,nonatomic) DatePickerMenuView *datePickerMenuView;
@property(strong,nonatomic) NSArray<MenuModel *> *dataArray;
@end

@implementation ViewController
- (IBAction)addMenu:(id)sender {
    [self.commonMenuView showMenuAtPoint:CGPointMake(20, 64)];
    
}
- (IBAction)addTimeMenu:(id)sender {
    [self.datePickerMenuView showMenuAtPoint:CGPointMake(375 - 20, 64)];
}

#pragma mark - getter method
- (CommonMenuView *)commonMenuView {
    if (_commonMenuView == nil) {
        _commonMenuView = [CommonMenuView createMenuWithFrame:CGRectZero dataArray:self.dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
            NSLog(@"%@",str);
        }];
    }
    return _commonMenuView;
}

- (DatePickerMenuView *)datePickerMenuView {
    if (_datePickerMenuView == nil) {
        _datePickerMenuView = [DatePickerMenuView createMenuWithFrame:CGRectZero block:^(NSDate *date) {
            NSLog(@"%@",date);
        }];
    }
    return _datePickerMenuView;
}

- (NSArray<MenuModel *> *)dataArray {
    if (_dataArray == nil) {
        
        
        MenuModel *model_0 = [MenuModel new];
        model_0.itemName = @"全部";
        
        MenuModel *model_1 = [MenuModel new];
        model_1.itemName = @"商家";
        
        MenuModel *model_2 = [MenuModel new];
        model_2.itemName = @"零售商";
        
        MenuModel *model_3 = [MenuModel new];
        model_3.itemName = @"制造商";
        
        MenuModel *model_4 = [MenuModel new];
        model_4.itemName = @"贸易商";
        
        _dataArray = @[model_0,model_1,model_2,model_3,model_4];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_commonMenuView clearMenu];
    [_datePickerMenuView clearMenu];
}
@end
