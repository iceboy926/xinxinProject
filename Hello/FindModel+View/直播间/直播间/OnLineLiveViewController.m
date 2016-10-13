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

@interface OnLineLiveViewController() <LivePublisherDelegate>

@property (nonatomic, strong) OnLiveNavigateBar *liveNavigateView;
@property (nonatomic, strong) OnLiveTabBar *liveTabView;
@property (nonatomic, strong) LivePublisher *livepublisher;

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
        __weak typeof(self) weakself = self;
        _liveNavigateView = [[OnLiveNavigateBar alloc] init];
        [_liveNavigateView setOnLiveNavigateBackBtn:^{
            
            [weakself.navigationController popViewControllerAnimated:YES];
        }];
        
        [_liveNavigateView setOnLiveNavigateSwitchFrame:^(id sender){
            
            if([sender isKindOfClass:[UIButton class]])
            {
                [MBProgressHUD showMessage:@"正在切换模式"];
                
                UIButton *switchBtn = (UIButton *)sender;
                if(switchBtn.tag == 0)
                {
                    switchBtn.tag = 1;
                    [switchBtn setTitle:@"高清" forState:UIControlStateNormal];
                    
                    
                }
                else
                {
                    switchBtn.tag = 0;
                    [switchBtn setTitle:@"标清" forState:UIControlStateNormal];
                    
                    
                }
                
                [MBProgressHUD hideHUD];
            }
            
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


- (void)initLivePublisher
{
    _livepublisher = [[LivePublisher alloc] init];
    
    _livepublisher.livePublisherDelegate = self;
    
    [_livepublisher setAudioParamBitrate:32*1000 aacProfile:AAC_PROFILE_HE];
    
    [_livepublisher setVideoParamWidth:1280 height:720 fps:15 bitrate:500*1000 avcProfile:AVC_PROFILE_HIGH];
    
    [_livepublisher setDenoiseEnable:YES];
    [_livepublisher setSmoothSkinLevel:0];
    [_livepublisher setHWEnable:YES];
    
    [_livepublisher startPreview:self.view
                           camId:CAMERA_BACK
                     frontMirror:YES];
}


/**
 *  livePublisherDelegate
 *
 *  @param event
 *  @param msg
 */

-(void) onEventCallback:(int)event msg:(NSString*)msg
{
    
}


@end
