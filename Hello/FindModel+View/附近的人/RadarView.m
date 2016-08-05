//
//  RadarView.m
//  Hello
//
//  Created by 金玉衡 on 16/8/5.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "RadarView.h"

#define  PulsingCount   3


@interface RadarButton ()

@end

@implementation RadarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
    }
    return self;
}
-(void)didMoveToWindow
{
    [super didMoveToWindow];
    if (self.window != nil) {
        [UIView animateWithDuration:1 animations:^{
            self.alpha = 1;
        }];
    }
}
-(void)removeFromSuperview
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:1];
    self.alpha = 0;
    [UIView setAnimationDidStopSelector:@selector(callSuperRemoveSuperView)];
    [UIView commitAnimations];
    
}
-(void)callSuperRemoveSuperView
{
    [super removeFromSuperview];
}

@end


@interface RadarView()
{
    CGSize itemSize;
    UIImage *_logoImage;
    CALayer *_animationLayer;
    CGFloat radius;
    CGPoint centerPoint;
    NSMutableArray *itemArray;
}

@end

@implementation RadarView

- (instancetype) initWithFrame:(CGRect)frame LogoImage:(NSString *)logoImage
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        _logoImage = [UIImage imageNamed:logoImage];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resume) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        radius = frame.size.width/2.0/(PulsingCount+1);
        
        centerPoint = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
        
        NSLog(@"center point is (%f, %f)", centerPoint.x, centerPoint.y);
        
        itemArray = [NSMutableArray array];
        itemSize = CGSizeMake(40, 40);
    }
    
    return self;
}

- (void)resume
{
    if(_animationLayer)
    {
        [_animationLayer removeFromSuperlayer];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIColor clearColor] setFill];
    UIRectFill(rect);
    
    CALayer *animationLayer = [[CALayer alloc] init];
    _animationLayer = animationLayer;
    
    NSInteger pulseCount = PulsingCount;
    double  animDuration = 2;
    
    for (int i = 0; i < pulseCount; i++) {
        
        CALayer *pulsingLayer = [[CALayer alloc] init];
        
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.backgroundColor = [UIColor colorWithRed:92.0/255.0 green:181.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
        pulsingLayer.borderWidth = 1.0;
        pulsingLayer.borderColor = [UIColor colorWithRed:92.0/255.0 green:181.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor;
        pulsingLayer.cornerRadius = rect.size.width/2.0;
        
        CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
        animationGroup.fillMode = kCAFillModeBoth;
        animationGroup.duration = animDuration;
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animDuration/(double)pulseCount;
        animationGroup.repeatCount = HUGE_VAL;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.autoreverses = NO;
        scaleAnimation.fromValue = [NSNumber numberWithDouble:0.1];
        scaleAnimation.toValue = [NSNumber numberWithDouble:1.0];
        
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[[NSNumber numberWithDouble:1.0],[NSNumber numberWithDouble:0.5],[NSNumber numberWithDouble:0.3],[NSNumber numberWithDouble:0.0]];
        opacityAnimation.keyTimes = @[[NSNumber numberWithDouble:0.0],[NSNumber numberWithDouble:0.25], [NSNumber numberWithDouble:0.5],[NSNumber numberWithDouble:1.0]];
        animationGroup.animations = @[scaleAnimation,opacityAnimation];
        
        [pulsingLayer addAnimation:animationGroup forKey:@"pulsing"];
        [_animationLayer addSublayer:pulsingLayer];
        
    }
    
    _animationLayer.zPosition = -1;
    [self.layer addSublayer:_animationLayer];
    
    CALayer * logoLayer = [[CALayer alloc]init];
    logoLayer.backgroundColor = [UIColor whiteColor].CGColor;
    CGRect logoRect = CGRectMake(0, 0, 40, 40);
    logoRect.origin.x = (rect.size.width - logoRect.size.width)/2.0;
    logoRect.origin.y = (rect.size.height - logoRect.size.height)/2.0;
    logoLayer.frame = logoRect;
    logoLayer.cornerRadius = logoRect.size.width/2.0;
    logoLayer.borderWidth = 1.0;
    logoLayer.masksToBounds = YES;
    logoLayer.borderColor = [UIColor whiteColor].CGColor;
    logoLayer.contents = (id)_logoImage.CGImage;
    logoLayer.zPosition = -1;
    [self.layer addSublayer:logoLayer];
}

- (void)findResultItem
{
    NSInteger maxCount = 6;
    RadarButton *rButton = [[RadarButton alloc]initWithFrame:CGRectMake(0, 0, itemSize.width, itemSize.height)];
    [rButton setImage:[UIImage imageNamed:@"me"] forState:UIControlStateNormal];
    rButton.layer.cornerRadius = itemSize.width/2;
    rButton.layer.masksToBounds = YES;

    
    CGPoint point = [self getRandomBtnCenter];
    
    NSLog(@"pbutton center is (%f, %f)", point.x, point.y);
    
    rButton.center = CGPointMake(point.x, point.y);
    
    [self addSubview:rButton];
    [itemArray addObject:rButton];
    
    if (itemArray.count > maxCount) {
        UIView * view = itemArray[0];
        [view removeFromSuperview];
        [itemArray removeObject:view];
    }

}

struct CGSignalArea {
    CGFloat x1;
    CGFloat x2;
};
typedef struct CGSignalArea CGSignalArea;

#define ARC4RANDOM_MAX      0x100000000

- (CGPoint)getRandomBtnCenter
{
    CGPoint point;
    
    CGFloat pointX = 0.0;
    CGFloat pointY = 0.0;
    
    CGSignalArea signalArea[PulsingCount];
    
    for (int i = 0; i < PulsingCount; i++) {
        signalArea[i].x1 = centerPoint.x - (i+1)*radius;
        signalArea[i].x2 = centerPoint.x + (i+1)*radius;
    }
    
    //double val = floorf(((double)arc4random() / ARC4RANDOM_MAX) * 100.0f);
    
    
    //产生的随机区域
    int signal = arc4random()%PulsingCount;
    CGSignalArea randomArea = signalArea[signal];
    
    //首先随机产生 x
    
    
    
    //计算 y
    do
    {
        pointX = floorf(((double)arc4random()/ARC4RANDOM_MAX) * (randomArea.x2 - randomArea.x1)) + randomArea.x1;
        
        
        if((pointX > (centerPoint.x - itemSize.width/2)) && (pointX < (centerPoint.x + itemSize.width/2)))
        {
            continue;
        }
        
        NSLog(@"pointX = %f", pointX);
        
        CGFloat randomY1 = centerPoint.y - ((signal+1)*radius);
        CGFloat randomY2 = centerPoint.y + ((signal+1)*radius);
        
        pointY = floorf(((double)arc4random()/ARC4RANDOM_MAX) * (randomY2 - randomY1)) + randomY1;
        
        NSLog(@"pointY = %f", pointY);
        
        point.x = pointX;
        point.y = pointY;
        
    }while (![self isPointInArea:point WithSignal:signal]);
    
    
    
    return point;
}

- (BOOL)isPointInArea:(CGPoint)point WithSignal:(int)signal
{
    BOOL blIn = YES;
    
    double distance = sqrt(pow(point.x - centerPoint.x, 2) + pow(point.y - centerPoint.y, 2));
    
    if(distance <= (signal+1)*radius)
    {
        blIn = YES;
    }
    else
    {
        blIn = NO;
    }
    
    
    return blIn;
}



@end
