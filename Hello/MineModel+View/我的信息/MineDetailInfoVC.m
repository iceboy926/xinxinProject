//
//  MineDetailInfoVC.m
//  Hello
//
//  Created by 金玉衡 on 16/7/21.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "MineDetailInfoVC.h"


@interface MineDetailInfoVC()
{
    
}

@end

@implementation MineDetailInfoVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideToolBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideToolBar:NO];
}


-(void)hideToolBar:(BOOL)blHide
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blHide];
            break;
        }
    }
}

@end
