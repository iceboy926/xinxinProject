//
//  RadarView.h
//  Hello
//
//  Created by 金玉衡 on 16/8/5.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadarButton :UIButton

@end

@interface RadarView : UIView

- (instancetype) initWithFrame:(CGRect)frame LogoImage:(NSString *)logoImage;

-(void)findResultItem;

@end
