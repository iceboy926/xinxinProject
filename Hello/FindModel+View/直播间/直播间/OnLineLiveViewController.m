//
//  OnLineLiveViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/10/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "OnLineLiveViewController.h"
#import "OnLiveNavigateBar.h"
#import "OnLiveTabBar.h"

@interface OnLineLiveViewController()

@property (nonatomic, strong) OnLiveNavigateBar *liveNavigateView;
@property (nonatomic, strong) OnLiveTabBar *liveTabView;

@end

@implementation OnLineLiveViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.liveNavigateView];
    [self.view addSubview:self.liveTabView];
    
    [self addConstration];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self HideNavigateBar:YES];
    [self HideTabBar:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideNavigateBar:NO];
    [self HideTabBar:NO];
}

-(void)HideTabBar:(BOOL)blret
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blret];
            break;
        }
    }
}

- (void)HideNavigateBar:(BOOL)blHide
{
    self.navigationController.navigationBarHidden = blHide;
}



- (void)addConstration
{
    [self.liveNavigateView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(60);
    }];
    
    
    [self.liveTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(60);
        
    }];
}

- (OnLiveNavigateBar *)liveNavigateView
{
    if(_liveNavigateView == nil)
    {
        _liveNavigateView = [[OnLiveNavigateBar alloc] init];
        [_liveNavigateView setOnLiveNavigateBackBtn:^{
            
            
        }];
        
        [_liveNavigateView setOnLiveNavigateSwitchFrame:^{
            
            
        }];
    }
    
    return _liveNavigateView;
}

- (OnLiveTabBar *)liveTabView
{
    if(_liveTabView == nil)
    {
        _liveTabView = [[OnLiveTabBar alloc] init];
        
    }
    
    return _liveTabView;
}


@end
