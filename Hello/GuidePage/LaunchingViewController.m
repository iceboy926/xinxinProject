//
//  LaunchingViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/9/26.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "LaunchingViewController.h"
#import "AppDelegate.h"

@interface LaunchingViewController ()

/**
 *  背景图片
 */
@property (nonatomic,strong) UIImageView *launchingBackgroundImageView;
/**
 *  logo图片
 */
@property (nonatomic,strong) UIImageView *markImageView;
/**
 * 动画关键定时器
 */
@property (nonatomic,strong) NSTimer *launchingTimer;

@end

@implementation LaunchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.launchingBackgroundImageView];
    [self.view addSubview:self.markImageView];
    
    //添加约束，自动布局(Masonry)
    //为了避免使用block的时候出现循环引用，使用__weak
    __weak typeof(self)vc = self;
    [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //约束相对宽高固定
        CGFloat width = vc.view.bounds.size.width * 0.5;
        CGFloat height = width * 0.4;
        make.size.mas_equalTo(CGSizeMake(width, height));
        
        //约束相对坐标固定
        CGFloat viewHeight = vc.view.bounds.size.height /4;
        make.centerX.equalTo(vc.view.mas_centerX);
        make.centerY.mas_equalTo(vc.view.mas_centerY).offset(-viewHeight);
    }];
    
    //先加载本地保存的启动图
    [self loadLaunchingImageView];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //设置动画效果
    [UIView animateWithDuration:3.0 animations:^{
        
        CGRect rect = self.launchingBackgroundImageView.frame;
        rect.origin = CGPointMake(-30, -30);
        rect.size = CGSizeMake(rect.size.width + 60, rect.size.height + 60);
        _launchingBackgroundImageView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        //动画结束之后直接进入良品界面
        //[AllControllersTool createViewControllerWithIndex:0];
        
        [[AppDelegate globalDelegate] UIMainPageShow];
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadLaunchingImageView
{
    
}


/**
 *  背景图
 */
- (UIImageView *)launchingBackgroundImageView
{
    if (!_launchingBackgroundImageView) {
        _launchingBackgroundImageView = [[UIImageView alloc] init];
        [_launchingBackgroundImageView setFrame:self.view.frame];
        [_launchingBackgroundImageView setBackgroundColor:[UIColor cyanColor]];
        [_launchingBackgroundImageView setImage:[UIImage imageNamed:@"LaunchImage"]];
    }
    return _launchingBackgroundImageView;
}


/**
 *  logo
 */
- (UIImageView *)markImageView
{
    if (!_markImageView) {
        _markImageView = [[UIImageView alloc] init];
        [_markImageView setImage:[UIImage imageNamed:@"ic_splash_logo"]];
        [_markImageView setBackgroundColor:[UIColor clearColor]];
    }
    return _markImageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
