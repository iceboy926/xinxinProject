//
//  HomeCellModel.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "HomeCellModel.h"

@implementation HomeCellModel

@end


@implementation PictureArray

+ (Class)transformedValueClass
{
    return [NSMutableArray class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

- (id)reverseTransformedValue:(id)value
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}

@end

@implementation RetweetPictureArray

+ (Class)transformedValueClass
{
    return [NSMutableArray class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

- (id)reverseTransformedValue:(id)value
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}

@end

