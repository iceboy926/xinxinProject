//
//  ZoomImage.m
//  Hello
//
//  Created by 111 on 15-9-10.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "ZoomImage.h"
#import "SDWaitingView.h"
#import "AsynImageView.h"

@implementation ZoomImage

@synthesize imageView = _imageView;

static CGRect oldRect;

//显示大图
+(void)ShowImage:(UIImageView *)avatarImage
{
    UIImage *image = avatarImage.image;
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, MAX_HEIGHT)];
    
    oldRect = [avatarImage convertRect:avatarImage.frame toView:windows];
    
    background.backgroundColor = [UIColor blackColor];
    background.alpha = 0.5;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldRect];
    
    imageView.image = image;
    
    imageView.tag = 1;
    
    [background addSubview:imageView];
    
    [windows addSubview:background];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideImage:)];
    
    [background addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGFloat x = 0.0;
        CGFloat y = 0.0;
        CGFloat width = 0.0;
        CGFloat height = 0.0;
        
        
        
        if(image.size.width > MAX_WIDTH || image.size.height > MAX_HEIGHT)
        {
            
            CGFloat widthScal = image.size.width/MAX_WIDTH;
            CGFloat heightScal = image.size.height/MAX_HEIGHT;
            
            CGFloat Scal = MAX(widthScal, heightScal);
            
           
            width = image.size.width/Scal;
            height = image.size.height/Scal;
        

            x = MAX_WIDTH/2 - width/2;
            y = MAX_HEIGHT/2 -height/2;
        }
        else
        {
            x = MAX_WIDTH/2 - image.size.width/2;
            y = MAX_HEIGHT/2 - image.size.height/2;
            width = image.size.width;
            height = image.size.height;
        }
        
        imageView.frame = CGRectMake(x, y, width, height);
        
        background.alpha = 1;
    
    }];
}

+(void)ShowImageWithUrl:(NSString *)avatarImageUrl
{

    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, MAX_HEIGHT)];
    
    background.backgroundColor = [UIColor blackColor];
    background.alpha = 0.8;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideImage:)];
    
    [background addGestureRecognizer:tap];
    
    [windows addSubview:background];
    
    SDWaitingView *waiting = [[SDWaitingView alloc] init];
    waiting.bounds = CGRectMake(0, 0, 60, 60);
    waiting.mode = SDWaitingViewModeLoopDiagram;
    waiting.center = background.center;
    [background addSubview:waiting];
    
    __weak SDWaitingView *weakWaiting = waiting;

    
        //download pic
        
    AsynImageView *asyimageView = [[AsynImageView alloc] init];
    
    asyimageView.tag = DETAIL_IMAGE_TAG;
    
        
    [asyimageView showImage:avatarImageUrl progress:^(CGFloat percent){
            
            weakWaiting.progress = percent;
        
    } completion:^(UIImage *image){
        
        
        [weakWaiting removeFromSuperview];
            
            //review frame
        UIImageView *largeimage = [[UIImageView alloc] initWithImage:image];
            
        oldRect = [largeimage convertRect:largeimage.frame toView:windows];
            
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldRect];
            
        imageView.image = image;
        imageView.tag = 1;
        
            
        [background addSubview:imageView];
        
        
        [UIView promiseWithDuration:0.3 animations:^{
            CGFloat x = 0.0;
            CGFloat y = 0.0;
            CGFloat width = 0.0;
            CGFloat height = 0.0;
            
            
            
            if(image.size.width > MAX_WIDTH || image.size.height > MAX_HEIGHT)
            {
                
                CGFloat widthScal = image.size.width/MAX_WIDTH;
                CGFloat heightScal = image.size.height/MAX_HEIGHT;
                
                CGFloat Scal = MAX(widthScal, heightScal);
                
                
                width = image.size.width/Scal;
                height = image.size.height/Scal;
                
                
                x = MAX_WIDTH/2 - width/2;
                y = MAX_HEIGHT/2 -height/2;
            }
            else
            {
                x = MAX_WIDTH/2 - image.size.width/2;
                y = MAX_HEIGHT/2 - image.size.height/2;
                width = image.size.width;
                height = image.size.height;
            }
            
            imageView.frame = CGRectMake(x, y, width, height);
            
            background.alpha = 1;

        
        }];
        
//        [UIView animateWithDuration:0.3 animations:^{
//                
//            CGFloat x = 0.0;
//            CGFloat y = 0.0;
//            CGFloat width = 0.0;
//            CGFloat height = 0.0;
//                
//                
//                
//            if(image.size.width > MAX_WIDTH || image.size.height > MAX_HEIGHT)
//            {
//                    
//                CGFloat widthScal = image.size.width/MAX_WIDTH;
//                CGFloat heightScal = image.size.height/MAX_HEIGHT;
//                    
//                CGFloat Scal = MAX(widthScal, heightScal);
//                    
//                    
//                width = image.size.width/Scal;
//                height = image.size.height/Scal;
//                    
//                    
//                x = MAX_WIDTH/2 - width/2;
//                y = MAX_HEIGHT/2 -height/2;
//            }
//            else
//            {
//                x = MAX_WIDTH/2 - image.size.width/2;
//                y = MAX_HEIGHT/2 - image.size.height/2;
//                width = image.size.width;
//                height = image.size.height;
//            }
//                
//            imageView.frame = CGRectMake(x, y, width, height);
//                
//            background.alpha = 1;
//                
//        }];

        
    }];
        

    
    
    
}


+(void)HideImage:(UITapGestureRecognizer *)tap
{
    UIView *background = tap.view;
    
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame = oldRect;
        
        background.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [background removeFromSuperview];
    }];
}



@end
