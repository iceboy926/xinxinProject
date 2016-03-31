//
//  FriendGridImageView.h
//  Hello
//
//  Created by KingYH on 16/3/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendGridImageView : UIView

+(CGFloat)getHeight:(NSMutableArray *)images srcImage:(NSMutableArray *)srcImages oneImageWidth:(CGFloat)oneImageWidth oneImageHeight:(CGFloat)oneImageHeight;

-(void)updatewithImage:(NSMutableArray *)thumbImages srcImage:(NSMutableArray *)srcImages oneImageWidth:(CGFloat)oneImageWidth oneImageHeight:(CGFloat)oneImageHeight;


@end
