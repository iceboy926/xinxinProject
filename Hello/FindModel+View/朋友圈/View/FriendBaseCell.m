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
#import "MLLabel+Size.h"
#import "FriendGridImageView.h"
#import "FriendBaseModel.h"
#import "FriendBaseFrame.h"
#import "OperationMenu.h"



@interface FriendBaseCell()

@property (nonatomic, strong) FriendBaseModel *BaseModel;

@property (nonatomic, strong) AsynImageView *userAvartImage;

@property (nonatomic, strong) UIButton *userAvartbtn;

@property (nonatomic, strong) MLLinkLabel *userNickLabel;

@property (nonatomic, strong) MLLinkLabel *contentTextLabel;

@property (nonatomic, strong) FriendGridImageView *gridImageView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *likeCommentBtn;

@property (nonatomic, strong) OperationMenu *operationMenu;

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
    
       
    if(nil == _userAvartImage)
    {
        _userAvartImage = [[AsynImageView alloc] initWithFrame:CGRectZero];
        _userAvartImage.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_userAvartImage];
        
        _userAvartbtn = [[UIButton alloc] initWithFrame:CGRectZero];
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
        
        _userNickLabel.dataDetectorTypes = MLDataDetectorTypeAll;
        _userNickLabel.allowLineBreakInsideLinks = NO;
        _userNickLabel.linkTextAttributes = nil;
        _userNickLabel.activeLinkTextAttributes = nil;
        _userNickLabel.lineHeightMultiple = 1.0;
        
        [self.contentView addSubview:_userNickLabel];
    }
    
    
    if(nil == _bodyView)
    {
        _bodyView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:_bodyView];
    }
    
    if(nil == _contentTextLabel)
    {
        _contentTextLabel = [[MLLinkLabel alloc] initWithFrame:CGRectZero];
        _contentTextLabel.font = TextFont;
        _contentTextLabel.numberOfLines = 0; //multi line
        _contentTextLabel.adjustsFontSizeToFitWidth = NO;
        _contentTextLabel.textInsets = UIEdgeInsetsZero;
        
        _contentTextLabel.dataDetectorTypes = MLDataDetectorTypeAll;
        _contentTextLabel.allowLineBreakInsideLinks = NO;
        _contentTextLabel.linkTextAttributes = nil;
        _contentTextLabel.activeLinkTextAttributes = nil;
        _contentTextLabel.lineHeightMultiple = 1.2f;
        _contentTextLabel.linkTextAttributes = @{NSForegroundColorAttributeName: HighLightTextColor};
        
        [_bodyView addSubview:_contentTextLabel];
    }
    
    if(nil == _gridImageView)
    {
        _gridImageView = [[FriendGridImageView alloc] initWithFrame:CGRectZero];
        
        [_bodyView addSubview:_gridImageView];
    }
    
    
    if(nil == _locationLabel)
    {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _locationLabel.textColor = LocationTextColor;
        _locationLabel.font = LocationLabelFont;
        //_locationLabel.hidden = YES;
        
        [self.contentView addSubview:_locationLabel];
        
    }
    
    if(nil == _timeLabel)
    {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = TimeLabelFont;
        //_timeLabel.hidden = YES;
        
        [self.contentView addSubview:_timeLabel];
    }
    
    if(nil == _likeCommentBtn)
    {
        _likeCommentBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_likeCommentBtn setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_likeCommentBtn setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        [_likeCommentBtn addTarget:self action:@selector(onClickLikeCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_likeCommentBtn];
    }
    
    if(nil == _operationMenu)
    {
        _operationMenu = [[OperationMenu alloc] initWithFrame:CGRectZero];
        _operationMenu.show = NO;
        [self.contentView addSubview:_operationMenu];
    }

    
}



/**
 *
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


/**
 *
 */

-(void)onClickLikeCommentBtn:(id)sender
{
    
    
}

-(void)setBaseCellFrame:(FriendBaseFrame *)BaseCellFrame
{
    _BaseModel = BaseCellFrame.baseModel;
   
    [self updateWithBaseModel:_BaseModel];
    
    [self updateWithBaseFrame:BaseCellFrame];
}

-(void)updateWithBaseFrame:(FriendBaseFrame *)FrameItem
{
    [_userAvartImage setFrame:FrameItem.avartFrame];
    [_userAvartbtn setFrame:FrameItem.avartFrame];
    
    [_userNickLabel setFrame:FrameItem.nickFrame];
    
    [_bodyView setFrame:FrameItem.bodyFrame];

    //[_contentTextLabel setFrame:FrameItem.contentFrame];
    
    
    
    
}


-(void)updateWithBaseModel:(FriendBaseModel *)baseModel
{
    [_userAvartImage setImageURL:baseModel.strAvartUrl];
    [_userNickLabel setText:baseModel.strNick];
    
    //[_contentTextLabel setText:baseModel.strContentText];
    
}




@end
