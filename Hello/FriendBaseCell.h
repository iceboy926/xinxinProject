//
//  FriendBaseCell.h
//  Hello
//
//  Created by KingYH on 16/3/29.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>



#define UserNickFont [UIFont systemFontOfSize:16]
#define TitleLabelFont [UIFont systemFontOfSize:13]
#define TextFont        [UIFont systemFontOfSize:14]
#define LocationLabelFont [UIFont systemFontOfSize:10]
#define TimeLabelFont [UIFont systemFontOfSize:12]




@class FriendBaseModel;

@protocol FriendBaseCellDelegate <NSObject>

-(void)onClickUserAvart:(NSInteger)userID;

@end

@interface FriendBaseCell : UITableViewCell

@property (nonatomic, strong)UIView *bodyView;

@property (nonatomic, weak) id<FriendBaseCellDelegate> delegate;



-(void)updateWithBaseModel:(FriendBaseModel *)ModelItem;

-(CGFloat)getCellHeight:(FriendBaseModel *)ModelItem;


@end
