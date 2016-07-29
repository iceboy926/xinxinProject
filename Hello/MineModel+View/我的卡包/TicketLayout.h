//
//  TicketLayout.h
//  Hello
//
//  Created by 金玉衡 on 16/7/29.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TicketModel;

@interface TicketLayout : NSObject

- (instancetype)initWithModel:(TicketModel *)model;


@property (nonatomic, strong)TicketModel *Model;


@property (nonatomic, assign)CGFloat  marginTop;

@property (nonatomic, assign)CGRect   backgroundLayout;
@property (nonatomic, assign)CGRect   perferentialLayout;
@property (nonatomic, assign)CGRect   goodNameLayout;


@property (nonatomic, assign)CGFloat  marginBottom;


@end
