//
//  OnLiveTabBarViewModel.h
//  Hello
//
//  Created by 金玉衡 on 16/10/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnLiveTabBarViewModel : NSObject

@property (nonatomic, copy) void(^liveTabBarEvent)(int code);

@end
