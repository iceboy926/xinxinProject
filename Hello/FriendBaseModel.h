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

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSString *strUser;

@property (nonatomic, strong) NSString *strNick;

@property (nonatomic, strong) NSString *strAvartUrl;

@property (nonatomic, strong) NSString *strTitle;

@property (nonatomic, strong) NSString *strContentText;

@property (nonatomic, strong) NSMutableArray *thumbImageArray;

@property (nonatomic, strong) NSMutableArray *srcImageArray;

@property (nonatomic, assign) CGFloat  width;

@property (nonatomic, assign) CGFloat  height;

@property (nonatomic, strong) NSString *strLocation;

@property (nonatomic, assign) long long time;




@end
