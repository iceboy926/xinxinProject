//
//  LoginViewController.m
//  Hello
//
//  Created by 111 on 15-7-1.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "LoginViewController.h"
#import "LineView.h"
#import "MainTabBarViewController.h"


typedef enum {
    UIImageRoundedCornerTopLeft = 1,
    UIImageRoundedCornerTopRight = 1 << 1,
    UIImageRoundedCornerBottomRight = 1 << 2,
    UIImageRoundedCornerBottomLeft = 1 << 3,
    UIImageRoundedCornerAll = 1|1<<1|1<<2|1<<3
} UIImageRoundedCorner;

@interface LoginViewController () <WBHttpRequestDelegate,WeiboSDKDelegate>

@end

@implementation LoginViewController
{
    MBProgressHUD *HUD;
    UIButton *button_sina;
    UIButton *button_qq;
    UIButton *button_weixin;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	HUD.label.text = @"登录中...";
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.image = [UIImage imageNamed:@"login_bj"];
    
    [self.view insertSubview:bgView atIndex:0];
	
   
    [self.uiLogInBT setBackgroundImage:[[UIImage imageNamed:@"LoginGreenBigBtn_HI"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateDisabled];
    
    [self.uiLogInBT setBackgroundImage:[[UIImage imageNamed:@"LoginGreenBigBtn"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillHide:) name:UIKeyboardWillHideNotification object:nil];



    LineView *lineView1 = [[LineView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT - 50, 100, 0.5)];
    [self.view addSubview:lineView1];
    
    LineView *lineView2 = [[LineView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 30, SCREEN_HEIGHT - 50, 100, 0.5)];
    [self.view addSubview:lineView2];
    
    
    UILabel *label_text = [[UILabel alloc] initWithFrame:CGRectMake(130, SCREEN_HEIGHT - 55, lineView2.frame.origin.x - 130, 10)];
    
    label_text.text =@"其他登录方式";
    
    [label_text setFont:[UIFont systemFontOfSize:9.0]];
    
    [label_text setTextColor:[UIColor whiteColor]];
    
    [label_text setTextAlignment:NSTextAlignmentCenter];
    
    [label_text setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:label_text];
    
    
    
    
    
    
    button_sina = [UIButton buttonWithType:UIButtonTypeCustom];

    button_sina.frame = [self frameofsinaweiboButton];
    
    [button_sina setBackgroundImage:[UIImage imageNamed:@"sinaweibo"] forState: UIControlStateNormal];
    
    [button_sina addTarget:self action:@selector(LoginWithSinabo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button_sina];
    
    
    
    button_qq = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button_qq.frame = [self frameofqqButton];
    
    UIImage *image = [self roundedRectImage:[UIImage imageNamed:@"qq2"] withradius:10 cornerMask:UIImageRoundedCornerAll];
    
    [button_qq setBackgroundImage:image forState:UIControlStateNormal];
    
    [button_qq addTarget:self action:@selector(LoginWithqq) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button_qq];
    
    
    
    button_weixin = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button_weixin.frame = [self frameofweixinButton];
    
    [button_weixin setBackgroundImage:[UIImage imageNamed:@"weixin2"] forState: UIControlStateNormal];
    
    [button_weixin addTarget:self action:@selector(LoginWithweixin) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:button_weixin];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [button_sina sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    });
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

//使用第三方登录界面 sinaweibo 登录

-(void)LoginWithSinabo
{
    WBAuthorizeRequest *wbHttp = [WBAuthorizeRequest request];
    
    wbHttp.redirectURI = SinaWeiBo_redirectUri;
    wbHttp.scope = @"all";
    wbHttp.userInfo = @{@"SSO_From": @"LoginViewController",
                        @"Other_info": @"Login"};
    
    [WeiboSDK sendRequest:wbHttp];
    
}

-(void)LoginWithqq
{
    NSLog(@"loginwithqqzone");
    
    MainTabBarViewController *tabBar = [[MainTabBarViewController alloc] initWithNibName:@"MainTabBarViewController" bundle:nil];
    
    [self presentViewController:tabBar animated:YES completion:nil];
    
}


-(void)LoginWithweixin
{
    NSLog(@"LoginWithweixin");
    
    MainTabBarViewController *tabBar = [[MainTabBarViewController alloc] initWithNibName:@"MainTabBarViewController" bundle:nil];
    
    [self presentViewController:tabBar animated:YES completion:nil];
    
}

-(CGRect)frameofsinaweiboButton
{
    CGRect rect = CGRectZero;
    
    CGSize Size = button_sina.bounds.size;
    
    if(CGSizeEqualToSize(Size, CGSizeZero))
    {
        Size = CGSizeMake(25, 25);
    }
    
    rect = CGRectMake(SCREEN_WIDTH/4 - Size.width/2, SCREEN_HEIGHT - 35, Size.width, Size.height);
    
    return rect;
}

-(CGRect)frameofqqButton
{
    CGRect rect = CGRectZero;
    
    CGSize size = button_qq.bounds.size;
    
    if(CGSizeEqualToSize(size,CGSizeZero))
    {
        size = CGSizeMake(25, 25);
    }
    
    rect = CGRectMake(SCREEN_WIDTH/2 - size.width/2, SCREEN_HEIGHT - 35, size.width, size.height);
    
    return rect;
}

-(CGRect)frameofweixinButton
{
    CGRect rect = CGRectZero;
    
    CGSize size = button_weixin.bounds.size;
    
    if(CGSizeEqualToSize(size,CGSizeZero))
    {
        size = CGSizeMake(25, 25);
    }
    
    rect = CGRectMake(SCREEN_WIDTH*3/4 - size.width/2, SCREEN_HEIGHT - 35, size.width, size.height);
    
    return rect;
}

- (UIImage *)roundedRectImage:(UIImage *)srcimage withradius:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask
{
    UIImageView *bkImageViewTmp = [[UIImageView alloc] initWithImage:srcimage];
    
    int w = srcimage.size.width;
    int h = srcimage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    [self addRoundedRectToPath:context withrect:bkImageViewTmp.frame radius:radius mask:cornerMask];
    
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), srcimage.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage    *newImage = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    
    return newImage;
}

-(void)addRoundedRectToPath:(CGContextRef)context withrect:(CGRect)rect radius:(float)radius mask:(UIImageRoundedCorner)cornerMask
{
    //原点在左下方，y方向向上。移动到线条2的起点。
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    
    //画出线条2, 目前画线的起始点已经移动到线条2的结束地方了。
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    
    //如果左上角需要画圆角，画出一个弧线出来。
    if (cornerMask & UIImageRoundedCornerTopLeft) {
        
        //已左上的正方形的右下脚为圆心，半径为radius， 180度到90度画一个弧线，
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                        radius, M_PI, M_PI / 2, 1);
    }
    
    else {
        //如果不需要画左上角的弧度。从线2终点，画到线3的终点，
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
        
        //线3终点，画到线4的起点
        CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y + rect.size.height);
    }
    
    //画线4的起始，到线4的终点
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);
    
    //画右上角
    if (cornerMask & UIImageRoundedCornerTopRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                        rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - radius);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    
    //画右下角弧线
    if (cornerMask & UIImageRoundedCornerBottomRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                        radius, 0.0f, -M_PI / 2, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    
    //画左下角弧线
    if (cornerMask & UIImageRoundedCornerBottomLeft) {
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                        -M_PI / 2, M_PI, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + radius);
    }
    
    CGContextClosePath(context);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)SetField: (UITextField *)field forkey: (NSString *)key
{
    if(field.text != nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:field.text forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

-(BOOL)CheckInputVaild
{
    BOOL blVaild = YES;
    
    if(self.uiUserNameTF.text.length == 0)
    {
        [self.uiUserNameTF becomeFirstResponder]; // 弹出键盘
        blVaild = NO;
    }
    else if(self.uiPassWordTF.text.length == 0)
    {
        [self.uiPassWordTF becomeFirstResponder]; //弹出键盘
        blVaild = NO;
    }
    
    return blVaild;
}

- (IBAction)TextFile_DidEnd:(id)sender {
    [_uiPassWordTF becomeFirstResponder];
    
}
- (IBAction)Password_Done:(id)sender {
    [_uiPassWordTF resignFirstResponder];
}

- (IBAction)LogIn:(id)sender {
    
    if([self CheckInputVaild])
    {
        
        Reachability *reach = [Reachability reachabilityForInternetConnection];
        if([reach currentReachabilityStatus] == NotReachable)
        {
            HUD.labelText = @"网络未连接";
        }
        else
        {
            
        }
        
        
        
        // MBProgressHUD后台新建子线程执行登录服务器并用户认证
        [HUD showWhileExecuting:@selector(waitlogin) onTarget:self withObject:nil animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号或密码！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        
        [alert show];
    }
    
}


// 子线程中
-(void) waitlogin {
    // 显示进度条
    sleep(5);
    
    // 返回主线程执行
    //[self  performSelectorOnMainThread:@selector(goToMainView:) withObject:Data waitUntilDone:YES];
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.uiUserNameTF == textField || self.uiPassWordTF == textField)
    {
        [textField resignFirstResponder];
    }
    
    return FALSE;
}


- (IBAction)clickBackground:(id)sender
{
    //DEBUG_LOG(@"click background .....");
    
    [sender endEditing:YES];
}


- (void)KeyboardWillShow:(NSNotification *)note
{
    NSDictionary *userInfo = [note userInfo];
    
    NSValue *avalue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardrect = [avalue CGRectValue];
    
    CGFloat yfloat = keyboardrect.origin.y - self.view.frame.size.height;
    
    NSValue *animationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^(void)
     {
         self.view.transform = CGAffineTransformMakeTranslation(0, yfloat);
     }];
}

- (void)keyboardwillHide:(NSNotification *)note
{
    
    NSDictionary* userInfo = [note userInfo];
    
    NSValue *avalue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardrect = [avalue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^(void)
     {
         self.view.transform = CGAffineTransformMakeTranslation(0, (self.view.frame.size.height-keyboardrect.origin.y));
     }];
}




@end

