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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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

        [_midView setDemonstrationBlock:^{
            NSLog(@"跳转到直播页面");
        }];
        
    }
    
    return _midView;
}


@end
