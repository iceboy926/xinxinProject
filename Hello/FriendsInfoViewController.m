//
//  FriendsInfoViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/7/11.
//  Copyright © 2016年 mit. All rights reserved.
//


#import "FriendsInfoViewController.h"

@interface FriendsInfoViewController () <UIWebViewDelegate>
{
    UIWebView  *webView;
    NSURL *httpUrl;
}

@end

@implementation FriendsInfoViewController

-(instancetype)initWithURL:(NSURL *)URL
{
    self = [super init];
    if(self)
    {
        webView = [[UIWebView alloc] init];
        webView.delegate = self;
        
        httpUrl = URL;
    }
    
    return self;
}

-(void)InitUI
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    self.navigationItem.leftBarButtonItem = backItem;

    
    webView.frame = self.view.bounds;
    
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:httpUrl]];
    


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self InitUI];
    
}

-(void)back:(id)sender
{
    
    if([webView canGoBack])
    {
        [webView goBack];
    }
    else
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


-(void)clearbackgroundviewColor
{
    for (UIView *view in [webView subviews])
    {
        if([view isKindOfClass:[UIScrollView class]])
        {
            for (UIView *shadowview in [view subviews]) {
                if([shadowview isKindOfClass:[UIImageView class]])
                {
                    shadowview.hidden = YES;
                }
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)HideTabBar:(BOOL)blret
{
    
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:blret];
        }
    }
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


#pragma webViewDelegete
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if(error)
    {
        NSLog(@"didFailLoadWithError error is %@", error);
    }
    
}

@end

