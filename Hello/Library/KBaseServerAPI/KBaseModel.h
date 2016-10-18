//
//  KBaseModel.h
//  Hello
//
//  Created by 金玉衡 on 16/10/18.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBaseServerAPI.h"

@interface KBaseModel : NSObject

@property (nonatomic, strong) KBaseServerAPI *serverapi;

@property (nonatomic, copy) NSString *address; //地址

@property (nonatomic, strong) NSDictionary *params;//参数

@property (nonatomic, copy) void (^KBaseModelBlock)(KBaseModel *);

-(instancetype)initWithAddress:(NSString *)address;

- (void)loadWithShortConnect;
- (void)loadWithLongConnect;

- (void)refresh;
- (void)cancel;

@end
