//
//  FriendGridImageView.h
//  Hello
//
//  Created by KingYH on 16/3/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendGridImageView : UIView

@property(nonatomic, strong) NSMutableArray *srcImageArray;

-(void)setGridImageFrame:(CGRect)frame;

@end
