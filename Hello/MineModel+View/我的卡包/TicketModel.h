//
//  ticketModel.h
//  Hello
//
//  Created by 金玉衡 on 16/7/28.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TPCellType) {
    TPCellTypeCoupon,
    TPCellTypeDiscount,
    TPCellTypeConvert,
};


@protocol TicketModelProtocol <NSObject>

@required

@property (nonatomic, strong, readonly) NSString *goodName;
@property (nonatomic, strong, readonly) NSString *effectCondition;
@property (nonatomic, strong, readonly) NSString *deadLine;
@property (nonatomic, assign) TPCellType Type;
@property (nonatomic, strong, readonly) NSString *backgroundImageName;

@optional

@property (nonatomic, strong, readonly) NSAttributedString *perferential;

- (instancetype)initWithDict: (NSDictionary *)dict;

@end


@interface TicketModel : NSObject<TicketModelProtocol>

@end
