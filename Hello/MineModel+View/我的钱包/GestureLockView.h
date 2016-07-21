//
//  MRGestureView.h
//  手势解锁封装
//
//  Created by SinObjectC on 16/6/3.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GestureLockViewDelegate <NSObject>

- (void)gestureViewUnlockSuccess:(UIView *)gestureView;

-(void)gestureViewUnlockFailed:(UIView *)gestureView;

@end

@protocol GestureSetLockViewDelegate <NSObject>

- (void)lockView:(UIView *)lockView BeganTouch:(NSSet *)touchs;

- (void)lockView:(UIView *)lockView didFinishPath:(NSString *)path;

@end

@interface GestureLockView : UIView

/** 手势数据模型 */
@property(nonatomic, strong) NSString *password;

@property(nonatomic, assign) BOOL  blsetPassWord;

/** 代理 */
@property(nonatomic, weak)id<GestureLockViewDelegate> delegate_Lock;

@property (nonatomic, weak) id<GestureSetLockViewDelegate> delegate_setLock;

@end
