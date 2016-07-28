//
//  MinePackageViewController.h
//  Hello
//
//  Created by 金玉衡 on 16/7/28.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ticketModel.h"
#import "ticketCell.h"

@interface MinePackageViewController : UITableViewController

@property (nonatomic, strong)NSMutableArray<id<ticketModelProtocol>>  *currentModelSet;

@end
