//
//  FansTableViewCell.h
//  Hello
//
//  Created by 111 on 15-10-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynImageView.h"
#import "UserFans.h"

@interface FansTableViewCell : UITableViewCell

@property (strong, nonatomic) AsynImageView *IconView;
@property (strong, nonatomic) UILabel *FansNameLable;
@property (strong, nonatomic) UILabel *FansDescriptLabel;
@property (strong, nonatomic) UILabel *FansSourceLabel;
@property (strong, nonatomic) UIButton *FansfollowsBtn;
@property(nonatomic)UserFans *fansData;

-(void)setFansFrame;

@end
