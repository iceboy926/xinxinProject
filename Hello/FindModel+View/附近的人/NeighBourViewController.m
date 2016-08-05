//
//  NeighBourViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/8/5.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "NeighBourViewController.h"
#import "RadarView.h"

@interface NeighBourViewController()
{
    RadarView *radarView;
}

@end

@implementation NeighBourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backGo)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.navigationItem.title = @"附件的同伴";
    
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    self.view.backgroundColor = bgColor;
    // Do any additional setup after loading the view from its nib.
    
    CGRect radarFrame = CGRectMake(0, (MAX_HEIGHT - MAX_WIDTH)/2.0, MAX_WIDTH, MAX_WIDTH);
    
    radarView = [[RadarView alloc] initWithFrame:radarFrame LogoImage:@"anddy926_avtar.jpg"];
    
    [self.view addSubview:radarView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:radarView selector:@selector(findResultItem) userInfo:nil repeats:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self HideTabBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)backGo
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
