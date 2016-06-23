//
//  FriendBaseModel.h
//  Hello
//
//  Created by KingYH on 16/3/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendBaseModel : NSObject

@property (nonatomic, assign) long itemID;

@property (nonatomic, strong) NSString *strAvartUrl;

@property (nonatomic, strong) NSString *strNick;

@property (nonatomic, strong) NSString *strContentText;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) NSString *strLocation;

@property (nonatomic, assign) NSString *strTime;

@property (nonatomic, assign) CGFloat cellHeight;


@end
