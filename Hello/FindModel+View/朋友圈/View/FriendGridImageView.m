//
//  FriendGridImageView.m
//  Hello
//
//  Created by KingYH on 16/3/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendGridImageView.h"
#import "AsynImageView.h"
//#import "ZoomImage.h"
#import "SDPhotoBrowser.h"

#define padding 2

@interface FriendGridImageView() <SDPhotoBrowserDelegate>
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
        
        if([subView isKindOfClass:[AsynImageView class]])
        {
            [subView removeFromSuperview];
        }
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
                AsynImageView *imageview = _imageViewArray[index];
                
                [imageview setFrame:CGRectMake(x, y, width, height)];
                
                imageview.userInteractionEnabled = YES;
                
                imageview.tag = index;
                
                [self addSubview:imageview];
                
                UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage:)];
                
                [imageview addGestureRecognizer:TapGesture];
            }
        }
    }

}

-(void)onClickImage:(UITapGestureRecognizer *)GestureRecognizer
{
    NSLog(@"onClickImage");
    
    AsynImageView *asyImageView = (AsynImageView *)[GestureRecognizer view];
    
    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
    
    photoBrowser.sourceImagesContainerView = self;
    photoBrowser.currentImageIndex = asyImageView.tag;
    photoBrowser.imageCount = imageCount;
    photoBrowser.delegate = self;
    [photoBrowser show];
    
}


/**
 *  delegate
 *
 *  @param browser
 *  @param index
 *
 *  @return
 */
//
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;
{
    AsynImageView *imageView = _imageViewArray[index];
    
    return [imageView image];
}


- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSURL *url = nil;
    
    AsynImageView *imageView = _imageViewArray[index];
    
    if(imageView)
    {
        NSString *strUrl = imageView.imageURL;
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        url = [NSURL URLWithString:strUrl];
    }
    
    return url;
}





@end
