//
//  ScaleImageViewGood.m
//  MoveScaleImageView
//
//  Created by gaohuifeng on 15-3-4.
//  Copyright (c) 2015年 Gao. All rights reserved.
//

#import "ScaleImageView.h"

@implementation ScaleImageView
-(id)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addGestureRecognizer];
    }
    return self;
}

- (void)addGestureRecognizer
{
    //移动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:pan];
    
    //缩放
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self addGestureRecognizer:pinch];
    
    //旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [self addGestureRecognizer:rotation];
}

 //移动
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:[self superview]];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:[self superview]];
    
    //    if (recognizer.state == UIGestureRecognizerStateEnded) {
    //
    //        CGPoint velocity = [recognizer velocityInView:[self superview]];
    //        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
    //        CGFloat slideMult = magnitude / 200;
    //        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
    //
    //        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
    //        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
    //                                         recognizer.view.center.y + (velocity.y * slideFactor));
    //         NSLog(@"point center ---=== %@",NSStringFromCGPoint(finalPoint));
    //        finalPoint.x = MIN(MAX(finalPoint.x, 0), [self superview].bounds.size.width);
    //        finalPoint.y = MIN(MAX(finalPoint.y, 0), [self superview].bounds.size.height);
    //
    //        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    //            recognizer.view.center = finalPoint;
    //        } completion:nil];
    //
    //        NSLog(@"point center %@",NSStringFromCGPoint(finalPoint));
    //
    //         [recognizer setTranslation:CGPointZero inView:recognizer.view];
    //    }
}

//缩放
- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        lastScale = [recognizer scale];
    }
    
    CGFloat newScale = 1 -  (lastScale - [recognizer scale]);

    if ([recognizer state] == UIGestureRecognizerStateBegan ||
        [recognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[recognizer view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 10.0;
        const CGFloat kMinScale = 0.8;
        
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        
        NSLog(@"gesture change -- %f",newScale);
        recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, newScale, newScale);
        
        lastScale = [recognizer scale];  // Store the previous scale factor for the next pinch gesture call
    }
}

//旋转
- (void) handleRotate:(UIRotationGestureRecognizer*) recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

@end
