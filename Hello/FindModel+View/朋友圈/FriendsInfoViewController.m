//
//  FriendsInfoViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/7/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendsInfoViewController.h"
#import <WebKit/WebKit.h>

@interface FriendsInfoViewController () <WKNavigationDelegate, WKUIDelegate>
{
    WKWebView  *webView;
    NSURL *httpUrl;
}

@end

@implementation FriendsInfoViewController

-(instancetype)initWithURL:(NSURL *)URL
{
    self = [super init];
    if(self)
    {
        webView = [[WKWebView alloc] init];
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        
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

-(void)HideNavigateBar:(BOOL)blHide
{
    NSArray *arrayView = [self.navigationController.view subviews];
    for (UIView *view in arrayView) {
        if([view isKindOfClass:[UINavigationBar class]])
        {
            [view setHidden:blHide];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self HideTabBar:YES];
    [self HideNavigateBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideTabBar:NO];
    [self HideNavigateBar:NO];
}


#pragma mark- WKNavigationDelegate
// 在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"%s", __FUNCTION__);
    decisionHandler(WKNavigationActionPolicyAllow);
}

//在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%s", __FUNCTION__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);
}

//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}


// 页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s", __FUNCTION__);
}

// 页面加载失败时调用
- (void)webView:(WKWebView *) webView didFailProvisionalNavigation: (WKNavigation *) navigation withError: (NSError *) error
{
    NSLog(@"%s", __FUNCTION__);
}


@end

