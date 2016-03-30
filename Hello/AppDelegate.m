//
//  AppDelegate.m
//  Hello
//
//  Created by 111 on 15-6-16.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "AppDelegate.h"
#import "GloabDef.h"
#import "LoginViewController.h"
//#import "WeiboApi.h"
#import "MainTabBarViewController.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioSession.h>
#import <AVFoundation/AVAudioSession.h>

@interface AppDelegate() <WeiboSDKDelegate>

@end

@implementation AppDelegate

@synthesize wbtoken;
@synthesize wbCurrentUserID;

//告诉代理进程启动但还没进入状态保存
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DEBUG_LOG(@"willFinishLaunchingWithOptions");
    
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
    //return [WXApi handleOpenURL:url delegate:self] | [WeiboSDK handleOpenURL:url delegate: self];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
    //return [WXApi handleOpenURL:url delegate:self]| [WeiboSDK handleOpenURL:url delegate: self];
}




void propListener(void *                  inClientData,
                  AudioSessionPropertyID  inID,
                  UInt32                  inDataSize,
                  const void *            inData)
{
    UInt32 propertySize = sizeof(CFStringRef);
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    CFStringRef state = nil;
    
    CFDictionaryRef routeChangeDictionary = inData;
    
    CFNumberRef routeChangeReasonRef = CFDictionaryGetValue(routeChangeDictionary, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
    
    SInt32 routeChangeReason;
    CFNumberGetValue (routeChangeReasonRef, kCFNumberSInt32Type, &routeChangeReason);
    
    if(routeChangeReason == kAudioSessionRouteChangeReason_OldDeviceUnavailable) //unplug headphone
    {
        //do something you will do
        
    }
    else if(routeChangeReason == kAudioSessionRouteChangeReason_NewDeviceAvailable) //plugin headphone
    {
        
        //do something you will do
        
    }
    else
    {
        //do something you will do
    }
    
    

    //获取音频路线
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute
                            ,&propertySize,&state);//kAudioSessionProperty_AudioRoute：音频路线
    NSLog(@"%@",(NSString *)CFBridgingRelease(state));//Headphone 耳机  Speaker 喇叭.
}

-(void)Runbackground
{
    OSStatus status = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, propListener,CFBridgingRetain(self));
    
    /*
     AudioSessionAddPropertyListener(
     AudioSessionPropertyID              inID,
     AudioSessionPropertyListener        inProc,
     void                                *inClientData
     )
     注册一个监听：audioRouteChangeListenerCallback，当音频会话传递的方式（耳机/喇叭）发生改变的时候，会触发这个监听
     kAudioSessionProperty_AudioRouteChange ：就是检测音频路线是否改变
     */
    
    
    
}

#pragma mark 应用程序加载完毕
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"didFinishLaunchingWithOptions");
    
    writeFileLog("application", "didFinishLaunchingWithOptions");
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        NSLog(@"App start time is %f seconds", CFAbsoluteTimeGetCurrent() - startTime);
    
    });
    
    //LaunchOptions 为app的启动方式
    //如果为用户直接启动：launchOptions 为nil 或者无数据
    if(launchOptions == nil || launchOptions.count == 0)
    {
        
    }
    else
    {
        //如果由其他应用程序通过openurl 启动则url为对应的对象URL
        NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
        if(url)
        {
            
        }
        
        //对应源程序的bundleid
        NSString *bundleId = [launchOptions objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
        if(bundleId)
        {
            
        }
        
        //如果为本地通知启动，为本地启动应用程序的的本地通知对象
        UILocalNotification * localNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
        if(localNotify)
        {
            
        }
        
        
        //若由远程通知启动,为启动应用程序的的远程通知信息
        NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo)
        {
            NSDictionary *dict = [userInfo valueForKey:@"aps"];
            
            //do something you want
            
        }
    }
    
    

    
    
    [WeiboSDK enableDebugMode:YES];
    //1、注册AppKey
    [WeiboSDK registerApp:SinaWeiBo_AppKey];
    
    
    
    //2、初始化社交平台
    [self InitAllPlatform];
    
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(Runbackground) object:nil];
    [thread start];
    
    
  
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //if(![user boolForKey:@"FirstLaunch"])
    {
        
        [user setBool:YES forKey: @"FirstLaunch"];
        
        //开始引导页
        [self UIGuidPageMakeInLive];
        
        __weak AppDelegate *weakself = self;
        
        self.GuidView.gotoMainPage = ^(){
        
            //添加动画
            [UIView animateWithDuration:0.5 animations:^(){
                
                [weakself.GuidView DisappearScroll];
            }
            completion:^(BOOL blfinished)
            {
                [weakself UIMainPageShow];
            }];
        };
        
        //[self.window makeKeyAndVisible];
    }
//    else
//    {
//        NSLog(@"不是第一次加载");
//        [user setBool:NO forKey:@"FirstLaunch"];
//        [self UIMainPageShow];
//    }
    return YES;
}

#pragma mark    失去焦点
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
#pragma mark    进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    
    NSLog(@"applicationDidEnterBackground");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

#pragma mark    进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

#pragma mark    获得焦点
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//收到推送消息时触发的消息 PS: 必须是app打开的情况下,如果在关闭的情况下，需要在didFinishLaunchingWithOptions 处理推送消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{

}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
//引导页加载
-(void)UIGuidPageMakeInLive
{
    NSArray *arrayImage = [NSArray arrayWithObjects:@"img_index_01bg", @"img_index_02bg", @"img_index_03bg", nil];
    
    
    self.GuidView = [[GuidInViewController alloc] initWithBackGroundImage:arrayImage];
    
    [self.window addSubview:self.GuidView.view];
}

-(void)UIMainPageShow
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *username = [user objectForKey:XMPP_USER_ID];
    
    if(username != nil)
    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        
//        id mainstoryboard = [storyboard instantiateViewControllerWithIdentifier:@"MainPageView"];
//        
//        self.window.rootViewController = mainstoryboard;
        
        LoginViewController *loginView = [[LoginViewController alloc] init];
        self.window.rootViewController = loginView;
        [loginView LoginWithSinabo];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        id mainstoryboard = [storyboard instantiateViewControllerWithIdentifier:@"LogInView"];
        
        self.window.rootViewController = mainstoryboard;
        
    }
}


//shareSDK function

-(void)InitAllPlatform
{
    //sina weibo
    
    //appkey 2187371547
    //appsecret d3963e403edbc49048f5217eb81a2d26
    //[ShareSDK connectSinaWeiboWithAppKey:@"2187371547" appSecret:@"d3963e403edbc49048f5217eb81a2d26" redirectUri:@"http://www.myapp.com/login/callback"];
    
    //[WeiboSDK registerApp:@"2187371547"];
    
    
    //QQ weibo
    //[ShareSDK connectTencentWeiboWithAppKey:@"9b859fbef42e" appSecret:@"82daf2c539030bdd428e5b2896b2503d"
    //redirectUri:@"http://www.sharesdk.cn"];
    
    
    //SMS 短信通知
    //[ShareSDK connectSMS];
    
    
    //QQ
    //[ShareSDK connectQQWithQZoneAppKey:@"1104820204" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    
    //weixin
    //AppID：wxb15b4ab26fce2028
    //AppSecret：6557ddc82829bbe31682e71e4835d5af
//    [ShareSDK connectWeChatWithAppId:@"wxb15b4ab26fce2028" appSecret:@"6557ddc82829bbe31682e71e4835d5af" wechatCls:[WXApi class]];
//    
//    BOOL blret = [WXApi registerApp:@"wxb15b4ab26fce2028"];
//    
//    if(blret)
//    {
//        NSLog(@"weixin registerApp sucess");
//    }
//    
//    blret = [WXApi isWXAppSupportApi];
//    if(blret)
//    {
//        NSLog(@"weixin is supportapi");
//    }
    
    //QQ Zone
    //[ShareSDK connectQZoneWithAppKey:@"1104746727" appSecret:@"BMjtbX0vQeOupS4Z" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    
    //QQ 开放平台
    //APPID 1104746727
    //APP KEY: BMjtbX0vQeOupS4Z
    
    
    
}

/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    
    
    writeFileLog("dd", "dd");
    if([response isKindOfClass:WBAuthorizeResponse.class]) //
    {
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        
        NSMutableDictionary *dicuser = [[NSMutableDictionary alloc] initWithCapacity:20];
        
        //NSLog(@"access_token is %@", self.wbtoken);
        
        
        [dicuser setObject:[(WBAuthorizeResponse *)response accessToken] forKey:@"access_token"];
        [dicuser setObject:[(WBAuthorizeResponse *)response userID] forKey:@"userID"];
        
        [[NSUserDefaults standardUserDefaults] setObject:dicuser forKey:@"sinaweibo"];
        
        MainTabBarViewController *tabBar = [[MainTabBarViewController alloc] initWithNibName:@"MainTabBarViewController" bundle:nil];
        
        [self.window.rootViewController presentViewController:tabBar animated:YES completion:nil];
    }

    
}

@end