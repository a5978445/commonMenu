//
//  contentTableViewDataSource.m
//  MobileProject
//
//  Created by LiTengFang on 2017/3/21.
//  Copyright © 2017年 com.boli. All rights reserved.
//

#import "MenuTableViewDataSource.h"
#import "MenuTableViewCell.h"

@implementation MenuTableViewDataSource

#pragma mark --- TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuDataArray.count;
}

- (MenuTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuModel *model = self.menuDataArray[indexPath.row];
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MenuTableViewCell class]) forIndexPath:indexPath];
    cell.menuModel = model;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
@end
