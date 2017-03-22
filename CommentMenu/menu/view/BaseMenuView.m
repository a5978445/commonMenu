//
//  CommonMenuView.m
//  PopMenuTableView
//
//  Created by 孔繁武 on 2016/12/1.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import "BaseMenuView.h"
#import "UIView+AdjustFrame.h"
#import "MenuModel.h"
#import "MenuTableViewCell.h"
#import "MenuTableViewDataSource.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kCoverViewTag 201722
#define kMargin 8

#define kRadius 5 // 圆角半径


@interface BaseMenuView () 


@property (nonatomic,strong) UIView *backView;
@end

@implementation BaseMenuView {

    CGFloat arrowPointX; // 箭头位置
}




- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpUI];
        [self addToWindow];
    }
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor colorWithRed:61/255.0 green:61/255.0 blue:61/255.0 alpha:1];
    arrowPointX = self.XF_width * 0.5;
    
    self.XF_height = self.contentView.XF_height + kTriangleHeight * 2 - 0.5;
    self.alpha = 0;
    
    [self addSubview:self.contentView];
  
}

- (void)addToWindow {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

#pragma mark - getter method 

- (UIView *)backView {
    if (_backView == nil) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        backView.alpha = 0;
        backView.tag = kCoverViewTag;
        _backView = backView;
    }
    return _backView;
}








#pragma mark --- 关于菜单展示
- (void)displayAtPoint:(CGPoint)point{
    
    point = [self.superview convertPoint:point toView:self.window];
    self.layer.affineTransform = CGAffineTransformIdentity;
    [self adjustPosition:point]; // 调整展示的位置 - frame
    
    // 调整箭头位置
    if (point.x <= kMargin + kRadius + kTriangleHeight * 0.7) {
        arrowPointX = kMargin + kRadius;
    }else if (point.x >= kScreenWidth - kMargin - kRadius - kTriangleHeight * 0.7){
        arrowPointX = self.XF_width - kMargin - kRadius;
    }else{
        arrowPointX = point.x - self.x;
    }
    
    // 调整anchorPoint
    CGPoint aPoint = CGPointMake(0.5, 0.5);
    if (CGRectGetMaxY(self.frame) > kScreenHeight) {
        aPoint = CGPointMake(arrowPointX / self.XF_width, 1);
    }else{
        aPoint = CGPointMake(arrowPointX / self.XF_width, 0);
    }
    
    // 调整layer
    CAShapeLayer *layer = [self getBorderLayer];
    if (self.max_Y> kScreenHeight) {
        layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        layer.transform = CATransform3DRotate(layer.transform, M_PI, 0, 0, 1);
        self.y = point.y - self.XF_height;
    }
    
    // 调整frame
    CGRect rect = self.frame;
    self.layer.anchorPoint = aPoint;
    self.frame = rect;
    
    self.layer.mask = layer;
    self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.backView.alpha = 0.3;
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)adjustPosition:(CGPoint)point{
    self.x = point.x - self.XF_width * 0.5;
    self.y = point.y + kMargin;
    if (self.x < kMargin) {
        self.x = kMargin;
    }else if (self.x > kScreenWidth - kMargin - self.XF_width){
        self.x = kScreenWidth - kMargin - self.XF_width;
    }
    self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
}



- (void)hiddenMenu{
  //  self.contentTableView.contentOffset = CGPointMake(0, 0);
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.01, 0.01);
        self.alpha = 0;
        self.backView.alpha = 0;
    }];
}

- (void)tap:(UITapGestureRecognizer *)sender{
  
    [self hiddenMenu];
    
}
- (CAShapeLayer *)getBorderLayer{
    // 上下左右的圆角中心点
    CGPoint upperLeftCornerCenter = CGPointMake(kRadius, kTriangleHeight + kRadius);
    CGPoint upperRightCornerCenter = CGPointMake(self.XF_width - kRadius, kTriangleHeight + kRadius);
    CGPoint bottomLeftCornerCenter = CGPointMake(kRadius, self.XF_height - kTriangleHeight - kRadius);
    CGPoint bottomRightCornerCenter = CGPointMake(self.XF_width - kRadius, self.XF_height - kTriangleHeight - kRadius);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, kTriangleHeight + kRadius)];
    [bezierPath addArcWithCenter:upperLeftCornerCenter radius:kRadius startAngle:M_PI endAngle:M_PI * 3 * 0.5 clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(arrowPointX - kTriangleHeight * 0.7, kTriangleHeight)];
    [bezierPath addLineToPoint:CGPointMake(arrowPointX, 0)];
    [bezierPath addLineToPoint:CGPointMake(arrowPointX + kTriangleHeight * 0.7, kTriangleHeight)];
    [bezierPath addLineToPoint:CGPointMake(self.XF_width - kRadius, kTriangleHeight)];
    [bezierPath addArcWithCenter:upperRightCornerCenter radius:kRadius startAngle:M_PI * 3 * 0.5 endAngle:0 clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(self.XF_width, self.XF_height - kTriangleHeight - kRadius)];
    [bezierPath addArcWithCenter:bottomRightCornerCenter radius:kRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(kRadius, self.XF_height - kTriangleHeight)];
    [bezierPath addArcWithCenter:bottomLeftCornerCenter radius:kRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(0, kTriangleHeight + kRadius)];
    [bezierPath closePath];
    borderLayer.path = bezierPath.CGPath;
    return borderLayer;
}

#pragma mark --- 类方法封装


- (void)showMenuAtPoint:(CGPoint)point{
  
    [self displayAtPoint:point];
}

- (void)hidden{
  
    [self hiddenMenu];
}

- (void)clearMenu{
    [self hidden];
    [self.backView removeFromSuperview];
    [self removeFromSuperview];
    
}




@end
