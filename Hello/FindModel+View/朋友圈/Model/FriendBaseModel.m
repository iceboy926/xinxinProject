//
//  FriendBaseModel.m
//  Hello
//
//  Created by KingYH on 16/3/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendBaseModel.h"

@implementation FriendBaseModel

-(id)init
{
    self = [super init];
    if(self)
    {
        
        _strContentText = @"";
        
        _imageArray = [NSMutableArray array];
        
    }
    
    return self;
}

@end
