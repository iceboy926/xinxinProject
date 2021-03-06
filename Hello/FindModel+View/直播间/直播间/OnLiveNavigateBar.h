//
//  OnLiveNavigateBar.h
//  Hello
//
//  Created by 金玉衡 on 16/10/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnLiveNavigateBar : UIView

@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, copy) void (^onLiveNavigateBackBtn)();

@property (nonatomic, copy) void (^onLiveNavigateSwitchFrame)(id sender);

@end
