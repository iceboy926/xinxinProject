//
//  FriendBaseCell.m
//  Hello
//
//  Created by KingYH on 16/3/29.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendBaseCell.h"
#import "AsynImageView.h"
#import "MLLinkLabel.h"
#import "FriendGridImageView.h"
#import "FriendBaseModel.h"

#define margin 15
#define padding 10
#define avartsize 40


@interface FriendBaseCell()

@property (nonatomic, strong) FriendBaseModel *BaseModel;

@property (nonatomic, strong) AsynImageView *userAvartImage;

@property (nonatomic, strong) UIButton *userAvartbtn;

@property (nonatomic, strong) MLLinkLabel *userNickLabel;

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) MLLinkLabel *contentTextLabel;

@property (nonatomic, strong) FriendGridImageView *gridImageView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *likeCommentBtn;


@end


@implementation FriendBaseCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self InitBaseCell];
    }
    
    return self;
}


-(void)InitBaseCell
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat x = 0.0, y = 0.0, width = 0.0, height = 0.0;
    
    x = margin;
    y = margin;
    width = avartsize;
    height = avartsize;
    
    if(nil == _userAvartImage)
    {
        _userAvartImage = [[AsynImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _userAvartImage.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_userAvartImage];
        
        _userAvartbtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_userAvartbtn addTarget:self action:@selector(onClickUserAvart:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_userAvartbtn];
        
    }
    
    if(_userNickLabel == nil)
    {
        _userNickLabel = [[MLLinkLabel alloc] initWithFrame:CGRectZero];
        _userNickLabel.textColor = HighLightTextColor;
        _userNickLabel.font = UserNickFont;
        _userNickLabel.numberOfLines = 1;
        _userNickLabel.adjustsFontSizeToFitWidth = NO;
        
        
        [self.contentView addSubview:_userNickLabel];
        
    }
    
    
    
    
}










/**
 *   delegate
 *
 *  @param sender
 */

-(void)onClickUserAvart:(id)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(onClickUserAvart:)])
    {
        [_delegate onClickUserAvart:self.BaseModel.itemID];
    }
    
}

@end
