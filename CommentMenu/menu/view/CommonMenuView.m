//
//  BaseMenuView.m
//  MobileProject
//
//  Created by LiTengFang on 2017/3/21.
//  Copyright © 2017年 com.boli. All rights reserved.
//

#import "CommonMenuView.h"
#import "MenuTableViewDataSource.h"
#import "MenuTableViewCell.h"

#define KDefaultMaxValue 6  // 菜单项最大值

@interface CommonMenuView()<UITableViewDelegate>
@property (nonatomic,strong,readonly) UITableView * contentView;
@property (nonatomic,strong) MenuTableViewDataSource *dataSource;
@end

@implementation CommonMenuView {
    UITableView *_contentView;
}

- (void)setMaxValueForItemCount:(NSInteger)maxValueForItemCount{
    if (maxValueForItemCount <= KDefaultMaxValue) {
        _maxValueForItemCount = maxValueForItemCount;
    }else{
        _maxValueForItemCount = KDefaultMaxValue;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)updateFrameForMenu{
    
    self.maxValueForItemCount = self.dataSource.menuDataArray.count;
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);;
    self.contentView.XF_height = 40 * self.maxValueForItemCount;
    self.XF_height = 40 * self.maxValueForItemCount + kTriangleHeight * 2 - 0.5;
    self.layer.mask = [self getBorderLayer];
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MenuModel *model = self.dataSource.menuDataArray[indexPath.row];
    if (self.itemsClickBlock) {
        self.itemsClickBlock(model.itemName,indexPath.row);
    }
}

#pragma mark - getter method
- (MenuTableViewDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [MenuTableViewDataSource new];
    }
    return _dataSource;
}

- (UITableView *)contentView {
    if (_contentView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTriangleHeight, self.XF_width, self.XF_height)];
        tableView.delegate = self;
        tableView.dataSource = self.dataSource;
        tableView.bounces = NO;
        tableView.rowHeight = 40;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MenuTableViewCell class])];
        
        _contentView = tableView;
    }
    return _contentView;
    
}

+ (CommonMenuView *)createMenuWithFrame:(CGRect)frame
                              dataArray:(NSArray *)dataArray
                        itemsClickBlock:(void(^)(NSString *str, NSInteger tag))itemsClickBlock {
    
    CGFloat menuWidth = frame.size.width ? frame.size.width : 120;
    
    CommonMenuView *menuView = [[CommonMenuView alloc] initWithFrame:CGRectMake(0, 0, menuWidth, 40 * dataArray.count)];
    menuView.itemsClickBlock = itemsClickBlock;
    menuView.dataSource.menuDataArray = dataArray;
    menuView.maxValueForItemCount = 6;
    menuView.tag = kMenuTag;
    return menuView;
}

- (void)appendMenuItemsWith:(NSArray *)appendItemsArray{
    
    NSMutableArray *tempMutableArr = [NSMutableArray new];
    
    if (self.dataSource.menuDataArray) {
        [tempMutableArr addObjectsFromArray:self.dataSource.menuDataArray];
    }
    
    [tempMutableArr addObjectsFromArray:appendItemsArray];
    self.dataSource.menuDataArray = tempMutableArr;
    [self.contentView reloadData];
    [self updateFrameForMenu];
}

- (void)updateMenuItemsWith:(NSArray *)newItemsArray{
   
    
    self.dataSource.menuDataArray = newItemsArray;
    [self.contentView reloadData];
    [self updateFrameForMenu];
}

@end
