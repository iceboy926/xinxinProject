//
//  MineWalletViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/7/26.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "MineWalletViewController.h"

@interface MineWalletViewController () <UITableViewDelegate, UITableViewDataSource>
{
    
}

@property (nonatomic, strong) UIButton *leftIconBtn;
@property (nonatomic, strong) UIButton *rightIconBtn;

@end

@implementation MineWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    //self.edgesForExtendedLayout = UIRectEdgeBottom;
    // Do any additional setup after loading the view.

//    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];

//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)InitUIWithView:(UIView *)SuperView
{
    NSString *leftIconStr = @"ap_home_top_icon_pay_new";
    NSString *leftIconHightStr = [NSString stringWithFormat:@"%@_highlight", leftIconStr];

    _leftIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftIconBtn setImage:[UIImage imageNamed:leftIconStr] forState:UIControlStateNormal];
    [_leftIconBtn setImage:[UIImage imageNamed:leftIconHightStr] forState:UIControlStateHighlighted];
    [SuperView addSubview:_leftIconBtn];

    NSString *rightIconStr = @"ap_home_top_icon_scan_new";
    NSString *rightIconHightStr = [NSString stringWithFormat:@"%@_highlight", rightIconStr];

    _rightIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightIconBtn setImage:[UIImage imageNamed:rightIconStr] forState:UIControlStateNormal];
    [_rightIconBtn setImage:[UIImage imageNamed:rightIconHightStr] forState:UIControlStateHighlighted];
    [SuperView addSubview:_rightIconBtn];


    CGFloat padding = 2;
    CGFloat iconheight = 140;

    [_leftIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(SuperView.mas_top);
        make.left.mas_equalTo(SuperView.mas_left);
        make.width.mas_equalTo(_rightIconBtn);
        make.height.mas_equalTo(iconheight);
    }];

    [_rightIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(_leftIconBtn.mas_top);
        make.left.mas_equalTo(_leftIconBtn.mas_right);
        make.right.mas_equalTo(SuperView.mas_right);
        make.height.mas_equalTo(_leftIconBtn.mas_height);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideToolBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideToolBar:NO];
}

- (void)hideToolBar:(BOOL)blHide
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blHide];
        }
    }
}

/**
 *
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 140;
    }
    else
    {
        return 20;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *strTitle = nil;
    if(section == 1)
    {
        strTitle = @"有料服务";
    }
    else if(section == 2)
    {
        strTitle = @"第三方服务";
    }
    return strTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, 0)];
        view.backgroundColor = [UIColor clearColor];
        [self InitUIWithView:view];
        return view;
    }
    else
    {
        return nil;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"walletCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
    
    
    return cell;
}




@end
