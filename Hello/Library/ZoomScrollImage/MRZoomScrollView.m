//
//  MRZoomScrollView.m
//  Hello
//
//  Created by 金玉衡 on 16/5/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "MRZoomScrollView.h"

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)

@interface MRZoomScrollView(Utility)<UIScrollViewDelegate>

-(CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation MRZoomScrollView

@synthesize imageView = _imageView;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.delegate = self;
        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        [self InitImageView];
    }
    
    return self;
}

-(void)InitImageView
{
    _imageView = [[UIImageView alloc] init];
    
    _imageView.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:_imageView];
    
    
}


-(CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    return CGRectZero;
}

@end
