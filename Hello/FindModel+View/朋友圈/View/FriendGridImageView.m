//
//  FriendGridImageView.m
//  Hello
//
//  Created by KingYH on 16/3/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendGridImageView.h"
#import "AsynImageView.h"
#import "ZoomImage.h"

#define padding 2

@interface FriendGridImageView()
{
    int  imageCount;
}




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
    imageCount = 0;
    
    for(int row = 0; row < 3; row++){
        for (int column = 0; column < 3; column++) {
            
            AsynImageView *imageView = [[AsynImageView alloc] initWithFrame:CGRectZero];
            
            [_imageViewArray addObject:imageView];
            
        }
    }

}


-(void)removeAllSubView
{
    [_imageViewArray removeAllObjects];
    
    for (UIView* subView in self.subviews) {
        [subView removeFromSuperview];
    }
}


-(void)setSrcImageArray:(NSMutableArray *)srcImageArray
{
    [self removeAllSubView];
    [self InitView];
    
    imageCount = (int)[srcImageArray count];
    for(int i = 0; i < imageCount; i++)
    {
        AsynImageView *imageView = _imageViewArray[i];
        NSString *imageUrl = srcImageArray[i];
        
        [imageView showImage:imageUrl];
        
    }
}

-(void)setGridImageFrame:(CGRect)frame
{
    CGFloat x, y, width, height;
    
    width = (frame.size.width - padding*2)/3.0;
    height = width;
    
    for(int row = 0; row < 3; row++){
        for (int column = 0; column < 3; column++) {
            
            x = (width+padding)*column;
            y = (height+padding)*row;
            
            int index = row*3+column;
            if(index < imageCount)
            {
                [_imageViewArray[index] setFrame:CGRectMake(x, y, width, height)];
                
                AsynImageView *imageview = _imageViewArray[index];
                
                imageview.userInteractionEnabled = YES;
                
                [self addSubview:imageview];
                
                UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage:)];
                
                [imageview addGestureRecognizer:TapGesture];
            }
            
        }
    }

}


-(void)onClickImage:(UIGestureRecognizer *)GestureRecognizer
{
    AsynImageView *asyImageView = (AsynImageView *)[GestureRecognizer view];
    
    NSString *strimageUrl = asyImageView.imageURL;
    
    NSRange range = [strimageUrl rangeOfString:@"bmiddle"];
    
    
    if(range.length > 0)
    {
        [ZoomImage ShowImageWithUrl:[strimageUrl stringByReplacingOccurrencesOfString:@"bmiddle" withString:@"large"]];
    }

}

@end
