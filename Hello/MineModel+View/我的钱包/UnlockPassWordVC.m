//
//  UnlockPassWordVC.m
//  Hello
//
//  Created by 金玉衡 on 16/7/21.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "UnlockPassWordVC.h"
#import "GestureLockView.h"
#import "MineWalletViewController.h"

#define  LOCKPATH  @"lockpath"


@interface UnlockPassWordVC() <GestureLockViewDelegate, GestureSetLockViewDelegate>
{
    GestureLockView *lockView_;
    UILabel *msgView_;
    NSString *lockPassWord;
    UIButton *resetBtn_;
}

@property(nonatomic, copy)NSString *firstLockPassWord;
@property(nonatomic, copy)NSString *secondLockPassWord;

@end

@implementation UnlockPassWordVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    self.view.backgroundColor = bgColor;
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    CGFloat offsetY = rectStatus.size.height + rectNav.size.height;
    


    UILabel *msgView = [[UILabel alloc] init];
    msgView.backgroundColor = [UIColor clearColor];
    msgView.textColor = [UIColor brownColor];
    msgView.textAlignment = NSTextAlignmentCenter;
    msgView.text = @"请输入手势密码";
    msgView.numberOfLines = 0;
    msgView_ = msgView;
    [self.view addSubview:msgView];
    
    
    lockView_ = [[GestureLockView alloc] init];
    [self.view addSubview:lockView_];
    
    
    UIButton *retButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [retButton setTitle:@"重新设置密码" forState:UIControlStateNormal];
    [retButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [retButton setHidden:YES];
    [retButton addTarget:self action:@selector(resetPassword:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn_ = retButton;
    [self.view addSubview:retButton];
    
    int padding = 20;
    
    [msgView_ mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(offsetY + padding);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(@44);
        
    }];
    
    [lockView_ mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width);
        make.top.mas_equalTo(msgView_.mas_bottom).with.offset(padding);
        make.bottom.mas_equalTo(resetBtn_.mas_top).with.offset(-padding);
    }];
    
    
    [resetBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-padding);
        
    }];
    
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    lockPassWord = [userDefault objectForKey:LOCKPATH];
    if(lockPassWord == nil)
    {
        [lockView_ setBlsetPassWord:YES];
        msgView.text = @"您未设置手势密码，请设置您的手势密码";
        lockView_.delegate_setLock = self;
        resetBtn_.hidden = NO;
    }
    else
    {
        [lockView_ setBlsetPassWord:NO];
        [lockView_ setPassword:lockPassWord];
        lockView_.delegate_Lock = self;
        resetBtn_.hidden = YES;
    }
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


-(void)resetPassword:(id)sender
{
    _firstLockPassWord = @"";
    msgView_.textColor = [UIColor brownColor];
    msgView_.text = @"请输入您的手势密码";
}


/**
 *  gestureViewDelegate
 *
 *  @param gestureView
 */


- (void)gestureViewUnlockSuccess:(UIView *)gestureView
{
    MineWalletViewController *walletVC = [[MineWalletViewController alloc] initWithStyle:UITableViewStyleGrouped];
    walletVC.title = @"我的钱包";
    
    [self.navigationController pushViewController:walletVC animated:YES];
 
}

-(void)gestureViewUnlockFailed:(UIView *)gestureView
{
    msgView_.text = @"手势密码错误,请重新输入";
    msgView_.textColor = [UIColor redColor];
}

/**
 *  gesturesetLockViewDelegate
 *
 *  @param lockView
 *  @param touchs
 */

- (void)lockView:(UIView *)lockView BeganTouch:(NSSet *)touchs
{
    msgView_.textColor = [UIColor brownColor];
    msgView_.text = @"请输入您的手势密码";
}

- (void)lockView:(UIView *)lockView didFinishPath:(NSString *)path
{
    if (path.length < 4) {
        msgView_.textColor = [UIColor redColor];
        msgView_.text = @"请连接至少4个点";
        return ;
    }
    
    if (self.firstLockPassWord.length)
    {
        if ([path isEqualToString:self.firstLockPassWord])
        {
            msgView_.textColor = [UIColor blueColor];
            msgView_.text = @"手势密码设置成功";
            [self SaveLockPath:path];
            [NSThread sleepForTimeInterval:1.2f];
            
            [self dismissViewControllerAnimated:YES completion:^{
                if(self.didSetPassWord)
                {
                    self.didSetPassWord();
                }
            }];
        }
        else
        {
            msgView_.textColor = [UIColor redColor];;
            msgView_.text = @"两次密码输入不一致";
        }
    }
    else
    {
        self.firstLockPassWord = [path copy];
    }
}

- (void)SaveLockPath:(NSString *)path{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:path forKey:LOCKPATH];
    [userDef synchronize];
}

@end
