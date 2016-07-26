//
//  UnlockPassWordVC.h
//  Hello
//
//  Created by 金玉衡 on 16/7/21.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnlockPassWordVC : UIViewController

@property (nonatomic, copy) void(^didUnlockPassWord)();

@property (nonatomic, copy) void(^didSetPassWord)();

@end
