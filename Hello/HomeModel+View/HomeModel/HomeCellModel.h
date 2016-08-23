//
//  HomeCellModel.h
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCellModel : NSObject

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *timesource;

@property (nonatomic, strong) NSString *detail;

@property (nonatomic, strong) NSMutableArray *pictureArray;

@property (nonatomic) BOOL blVip;

@property (nonatomic, strong) NSString *retweetDetail;
@property (nonatomic, strong) NSMutableArray *retweetPictureArray;

@property (nonatomic) BOOL blretweet;

@property (nonatomic)NSInteger repostCount;
@property (nonatomic)NSInteger commentCount;
@property (nonatomic)NSInteger atitudesCount;

@end

@interface PictureArray : NSValueTransformer

@end

@interface RetweetPictureArray : NSValueTransformer

@end


