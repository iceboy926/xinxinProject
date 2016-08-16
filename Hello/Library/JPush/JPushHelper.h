//
//  JPushHelper.h
//  KYHAPDUTool
//
//  Created by 金玉衡 on 16/7/25.
//  Copyright © 2016年 金玉衡. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *appKey = @"3e26b228dc0b706a54806bfe";
static NSString *channel = @"APP Store";
static BOOL isProduction = FALSE;

@interface JPushHelper : NSObject

// 在应用启动的时候调用
+ (void)setupWithOptions:(NSDictionary *)launchOptions;

// 在appdelegate注册设备处调用
+ (void)registerDeviceToken:(NSData *)deviceToken;

// ios7以后，才有completion，否则传nil
+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion;

// 显示本地通知在最前面
+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification;

+ (NSString *)getRegisterID;

@end
