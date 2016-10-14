//
//  OnLiveTabBar.h
//  Hello
//
//  Created by 金玉衡 on 16/10/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnLiveTabBar : UIView

@property (nonatomic, copy) void (^microphoneBtnBlock)(UIButton *sender);
@property (nonatomic, copy) void (^changeCamerBtnBlock)(UIButton *sender);
@property (nonatomic, copy) void (^recordingBtnBlock)(UIButton *sender);
@property (nonatomic, copy) void (^photoflashBtnBlock)(UIButton *sender);
@property (nonatomic, copy) void (^screenshotBtnBlock)(UIButton *sender);

@end
