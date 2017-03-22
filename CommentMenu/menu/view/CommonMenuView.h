//
//  BaseMenuView.h
//  MobileProject
//
//  Created by LiTengFang on 2017/3/21.
//  Copyright © 2017年 com.boli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMenuView.h"

typedef void(^ItemsClickBlock)(NSString *str, NSInteger tag);

@interface CommonMenuView : BaseMenuView

/* 菜单点击回掉，默认值：6; */
@property (nonatomic,copy) ItemsClickBlock itemsClickBlock;

/* 最多菜单项个数，默认值：6; */
@property (nonatomic,assign) NSInteger maxValueForItemCount;

/**
 *  menu
 *
 *  @param frame            菜单frame
 *  @param target           将在在何控制器弹出
 *  @param dataArray        菜单项内容
 *  @param itemsClickBlock  点击某个菜单项的blick
 *  @param backViewTapBlock 点击背景遮罩的block
 *
 *  @return 返回创建对象
 */
+ (CommonMenuView *)createMenuWithFrame:(CGRect)frame
                              dataArray:(NSArray<MenuModel *> *)dataArray
                        itemsClickBlock:(void(^)(NSString *str, NSInteger tag))itemsClickBlock;



/**
 *  追加菜单项
 *
 *  @param itemsArray 需要追加的菜单项内容数组
 */
- (void)appendMenuItemsWith:(NSArray *)appendItemsArray;

/**
 *  更新菜单项
 *
 *  @param itemsArray 需要更新的菜单项内容数组
 */
- (void)updateMenuItemsWith:(NSArray *)newItemsArray;

@end
