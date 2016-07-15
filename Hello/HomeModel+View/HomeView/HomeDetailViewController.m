//
//  HomeDetailViewController.m
//  Hello
//
//  Created by 111 on 15-9-6.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController () <UIWebViewDelegate>
{
    UIWebView  *webView;
    NSDictionary *DicUser;
}

@end

@implementation HomeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.navigationController.navigationBarHidden = YES;
    
    self.title = _titleName;

    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    webView.scalesPageToFit = YES;
    
    webView.frame = [[UIScreen mainScreen] bounds];
    
    webView.backgroundColor = [UIColor clearColor];
    
    webView.opaque = NO;
    
    [self.view addSubview:webView];
    
    webView.delegate = self;

    

    
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
    NSArray *views = [self.navigationController.view subviews];
    for(UIView* view in views)
    {
        if([view isKindOfClass:[UINavigationBar class]])
        {
            [view setHidden:blHide];
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [self HideTabBar:YES];
    [self HideNavigateBar:YES];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self HideTabBar:NO];
    [self HideNavigateBar:NO];
    [super viewWillDisappear:animated];
}


#pragma webViewDelegete
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[self clearbackgroundviewColor];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
