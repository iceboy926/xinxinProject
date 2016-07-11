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
}

@end

@implementation FriendsInfoViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)InitUI
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    webView.scalesPageToFit = YES;
    
    webView.frame = [[UIScreen mainScreen] bounds];
    
    webView.backgroundColor = [UIColor clearColor];
    
    webView.opaque = NO;
    
    [self.view addSubview:webView];
    
    webView.delegate = self;
    


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self InitUI];
    
    NSURLRequest *quest = [NSURLRequest requestWithURL:self.httpUrl];
    
    [webView loadRequest:quest];
    
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

-(void)ShowTabBar:(BOOL)blret
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
    [self ShowTabBar:YES];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self ShowTabBar:NO];
    [super viewWillDisappear:animated];
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

