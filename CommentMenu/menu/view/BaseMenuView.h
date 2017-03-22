//
//  CommonMenuView.h
//  PopMenuTableView
//
//  Created by 孔繁武 on 2016/12/1.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
#import "UIView+AdjustFrame.h"

#define kMenuTag 201712
#define kTriangleHeight 10 // 三角形的高


typedef void(^BackViewTapBlock)();


@protocol ContentProtocol <NSObject>
@optional
@property(strong,nonatomic,readonly) UIView *contentView;

@required
- (CAShapeLayer *)getBorderLayer;

@end

@interface BaseMenuView : UIView<ContentProtocol>




/**
 *  展示菜单,定点展示
 *
 *  @param point 展示坐标
 */
- (void)showMenuAtPoint:(CGPoint)point;

/* 隐藏菜单 */
- (void)hidden;

/* 移除菜单 */
- (void)clearMenu;




@end
