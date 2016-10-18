//
//  MBProgressHUD+Easy.h
//  Hello
//
//  Created by 金玉衡 on 16/8/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Easy)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
