//
//  JPushHelper.m
//  KYHAPDUTool
//
//  Created by 金玉衡 on 16/7/25.
//  Copyright © 2016年 金玉衡. All rights reserved.
//

#import "JPushHelper.h"
#import "JPUSHService.h"

@implementation JPushHelper

// 在应用启动的时候调用
+ (void)setupWithOptions:(NSDictionary *)launchOptions
{
    [JPUSHService setDebugMode];
    
    

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }

    
    // Required
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction];

    
    return;
}

// 在appdelegate注册设备处调用
+ (void)registerDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion
{
    [JPUSHService handleRemoteNotification:userInfo];
    if(completion)
    {
        completion(UIBackgroundFetchResultNewData);
    }
}

// 显示本地通知在最前面
+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification
{
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

@end
