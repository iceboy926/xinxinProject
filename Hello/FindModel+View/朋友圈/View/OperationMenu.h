//
//  OperationMenu.h
//  Hello
//
//  Created by 金玉衡 on 16/7/4.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationMenu : UIView

@property (nonatomic, copy) void (^likeButtonClickedOperation)();
@property (nonatomic, copy) void (^commentButtonClickedOpration)();

-(void)showPopMenu;

-(void)hidePopMenu;

@end
