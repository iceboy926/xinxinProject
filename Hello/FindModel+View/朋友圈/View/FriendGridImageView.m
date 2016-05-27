//
//  FriendGridImageView.m
//  Hello
//
//  Created by KingYH on 16/3/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendGridImageView.h"
#import "AsynImageView.h"

#define padding 2

@interface FriendGridImageView()


@property(nonatomic, strong) NSMutableArray *srcImageArray;

@property(nonatomic, strong) NSMutableArray *imageViewArray;


@end

@implementation FriendGridImageView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _imageViewArray = [NSMutableArray array];
        
        [self InitView];
    }
    
    return self;
}


-(void)InitView
{
    CGFloat x, y, width, height;
    
    width = (self.frame.size.width - padding*2)/3.0;
    height = width;
    
    for(int row = 0; row < 3; row++){
        for (int column = 0; column < 3; column++) {
            
            x = (width+padding)*column;
            y = (height+padding)*row;
            
            AsynImageView *imageView = [[AsynImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage:)];
            [imageView addGestureRecognizer:TapGesture];
            
            [_imageViewArray addObject:imageView];
            
        }
    }
    
}

@end
