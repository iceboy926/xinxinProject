//
//  FriendBaseCell.h
//  Hello
//
//  Created by KingYH on 16/3/29.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>








@class FriendBaseFrame;

@protocol FriendBaseCellDelegate <NSObject>

-(void)onClickUserAvart:(NSInteger)userID;

@end

@interface FriendBaseCell : UITableViewCell

@property (nonatomic, strong)UIView *bodyView;

@property (nonatomic, weak) id<FriendBaseCellDelegate> delegate;

@property (nonatomic, strong) FriendBaseFrame *BaseCellFrame;


@end
