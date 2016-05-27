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

#define margin 15
#define padding 10
#define avartsize 40

#define BodyMaxWidth (MAX_WIDTH - avartsize - 3*margin)

#define GridMaxWidth (BodyMaxWidth*0.85)

#define UserNickMaxWidth 150


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
        
        _userNickLabel.dataDetectorTypes = MLDataDetectorTypeAll;
        _userNickLabel.allowLineBreakInsideLinks = NO;
        _userNickLabel.linkTextAttributes = nil;
        _userNickLabel.activeLinkTextAttributes = nil;
        _userNickLabel.lineHeightMultiple = 1.0;
        
        [self.contentView addSubview:_userNickLabel];
    }
    
    if(nil == _titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = TitleLabelFont;
        
        [self.contentView addSubview:_titleLabel];
        
    }
    
    if(nil == _bodyView)
    {
        x = CGRectGetMaxX(_userAvartImage.frame) + margin;
        y = 40;
        width = BodyMaxWidth;
        height = 1;
        
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
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
        _gridImageView = [[FriendGridImageView alloc] initWithFrame:CGRectMake(0, 0, GridMaxWidth, GridMaxWidth)];
        
        [_bodyView addSubview:_gridImageView];
    }
    
    
    if(nil == _locationLabel)
    {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _locationLabel.textColor = LocationTextColor;
        _locationLabel.font = LocationLabelFont;
        _locationLabel.hidden = YES;
        
        [self.contentView addSubview:_locationLabel];
        
    }
    
    if(nil == _timeLabel)
    {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = TimeLabelFont;
        _timeLabel.hidden = YES;
        
        [self.contentView addSubview:_timeLabel];
    }
    
    if(nil == _likeCommentBtn)
    {
        _likeCommentBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _likeCommentBtn.hidden = YES;
        [_likeCommentBtn setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        [_likeCommentBtn setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
        [_likeCommentBtn addTarget:self action:@selector(onClickLikeCommentBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_likeCommentBtn];
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
 *  <#Description#>
 */

-(void)onClickLikeCommentBtn:(id)sender
{
    
    
}

-(void)updateWithBaseModel:(FriendBaseModel *)ModelItem
{
    self.BaseModel = ModelItem;
    
    [_userAvartImage showImage:ModelItem.strAvartUrl];
    
    NSAttributedString *nickName = [[NSAttributedString alloc] initWithString:ModelItem.strNick];
    
    CGSize textsize = [MLLinkLabel getViewSize:nickName maxWidth:UserNickMaxWidth font:UserNickFont lineHeight:1.0 lines:1];
    
    CGFloat x, y, width, height;
    
    x = CGRectGetMaxX(_userAvartImage.frame) + margin;
    y = CGRectGetMinY(_userAvartImage.frame) + 2;
    width = textsize.width;
    height = textsize.height;
    
    _userNickLabel.frame = CGRectMake(x, y, width, height);
    _userNickLabel.attributedText = nickName;
    
    x = CGRectGetMaxX(_userNickLabel.frame) + padding;
    width = MAX_WIDTH - x - margin;
    _titleLabel.frame = CGRectMake(x, y, width, height);
    _titleLabel.text = ModelItem.strTitle;
    
    
    
    
}

-(CGFloat)getCellHeight:(FriendBaseModel *)ModelItem
{
    CGFloat modelHeight = 0.0;
    
    
    
    return modelHeight;
}



@end
