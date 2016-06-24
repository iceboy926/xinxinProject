//
//  FriendBaseFrame.h
//  Hello
//
//  Created by 金玉衡 on 16/6/24.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FriendBaseModel;

@interface FriendBaseFrame : NSObject

@property (nonatomic, assign) CGRect  avartFrame;

@property (nonatomic, assign) CGRect  nickFrame;

@property (nonatomic, assign) CGRect  bodyFrame;

@property (nonatomic, assign) CGRect  contentFrame;

@property (nonatomic, assign) CGRect  gridImageFrame;

@property (nonatomic, assign) CGRect  locationFrame;

@property (nonatomic, assign) CGRect  timeFrame;

@property (nonatomic, strong) FriendBaseModel *baseModel;

@property (nonatomic, assign) CGFloat  totalHeight;

@end
