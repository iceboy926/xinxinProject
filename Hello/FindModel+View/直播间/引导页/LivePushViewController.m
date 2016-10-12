//
//  LivePushViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/10/10.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "LivePushViewController.h"
#import "DemonstrationView.h"
#import "AppDelegate.h"
#import "OnLineLiveViewController.h"

@interface LivePushViewController()

@property (nonatomic, strong) DemonstrationView *midView;

@end

@implementation LivePushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.midView];
    [self setup];
    [self supportedInterfaceOrientations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
        [AppDelegate globalDelegate].mask = UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait;
    [self HideTabBar:YES];
    [self HideNavigateBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideTabBar:NO];
    [self HideNavigateBar:NO];
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

- (void)setup
{
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
        
//        make.top.mas_equalTo(self.view.mas_top);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//        make.left.mas_equalTo(self.view.mas_left);
//        make.right.mas_equalTo(self.view.mas_right);
    }];
}

- (DemonstrationView *)midView
{
    if(_midView == nil)
    {
        _midView = [[DemonstrationView alloc] init];
        
        __weak typeof(self)weakself = self;

        [_midView setDemonstrationBlock:^{
            
            OnLineLiveViewController *onliveVC = [[OnLineLiveViewController alloc] init];
            [weakself.navigationController pushViewController:onliveVC animated:YES];
            
        }];
        
    }
    
    return _midView;
}


@end
