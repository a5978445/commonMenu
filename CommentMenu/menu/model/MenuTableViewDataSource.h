//
//  contentTableViewDataSource.h
//  MobileProject
//
//  Created by LiTengFang on 2017/3/21.
//  Copyright © 2017年 com.boli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MenuModel.h"
@interface MenuTableViewDataSource : NSObject<UITableViewDataSource>
@property (nonatomic,strong) NSArray<MenuModel *> * menuDataArray;
@end
