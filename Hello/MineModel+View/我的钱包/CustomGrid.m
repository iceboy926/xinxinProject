//
//  CustomGrid.m
//  Hello
//
//  Created by 金玉衡 on 16/7/27.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "CustomGrid.h"

@interface CustomGrid ()
{
    
}

@end

@implementation CustomGrid


- (id) initWithFrame:(CGRect)frame
               Title:(NSString *)title
                Icon:(NSString *)icon
         NormalImage:(NSString *)normalImage
      HighlightImage:(NSString *)highlightImage
              GridID:(NSInteger)gridID
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:icon];
        iconView.tag = gridID;
        [self addSubview:iconView];
        
        UILabel *titleView = [[UILabel alloc] init];
        titleView.text = title;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.font = [UIFont systemFontOfSize:14];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.textColor = UIColorHex(@"3C454C");
        [self addSubview:titleView];
        
        
    }
    return self;
}




@end
