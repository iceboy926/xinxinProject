//
//  ticketModel.m
//  Hello
//
//  Created by 金玉衡 on 16/7/28.
//  Copyright © 2016年 mit. All rights reserved.
//
#import <objc/runtime.h>
#import "ticketModel.h"

NSString const *KMCPerferentialKey = @"perferentialKey";

@interface ticketModel()
{
    NSDictionary * _dict;
}

@end

@implementation ticketModel


- (NSString *)backgroundImageName
{
    return ([_dict[@"overdue"] boolValue] ? @"coupon_overdue" : @"coupon_common");
}

- (NSAttributedString *)perferential
{
    NSAttributedString * result = objc_getAssociatedObject(self, &KMCPerferentialKey);
    if (result)
    {
        return result;
    }
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString: @"￥" attributes: @{ NSFontAttributeName: [UIFont systemFontOfSize: 16] }];
    [attributedString appendAttributedString: [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @"%g", [_dict[@"ticketMoney"] doubleValue]] attributes: @{ NSFontAttributeName: [UIFont boldSystemFontOfSize: 32] }]];
    [attributedString addAttributes: @{NSForegroundColorAttributeName: [UIColor blackColor] } range: NSMakeRange(0, attributedString.length)];
    result = attributedString.copy;
    
    objc_setAssociatedObject(self, &KMCPerferentialKey, result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return result;
}

- (NSString *)goodName
{
    return [_dict[@"goodName"] stringValue];
}

- (NSString *)effectCondition
{
    return [NSString stringWithFormat: @"· 满%d元可用", [_dict[@"minLimitMoney"] intValue]];;
}

- (NSString *)deadline
{
    return [NSString stringWithFormat: @"· 兑换截止日期：%@", _dict[@"deadline"]];
}

- (TPCellType)Type
{
    return TPCellTypeCoupon;
}

- (instancetype)initWithDict: (NSDictionary *)dict
{
    if (self = [super init]) {
        _dict = dict;
    }
    return self;
}

@end
