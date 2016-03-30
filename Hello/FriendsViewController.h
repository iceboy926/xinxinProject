//
//  FriendsViewController.h
//  Hello
//
//  Created by KingYH on 16/3/28.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger coverWidth;
@property (nonatomic, assign) NSInteger coverHeight;
@property (nonatomic, assign) NSInteger userAvartSize;

@end
