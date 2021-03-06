//
//  FriendBaseCell.m
//  Hello
//
//  Created by KingYH on 16/3/29.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendBaseCell.h"

#import "FriendGridImageView.h"
#import "FriendBaseModel.h"
#import "FriendBaseFrame.h"
#import "FriendOperationMenu.h"
#import "FriendCommentView.h"



@interface FriendBaseCell()<MLLinkLabelDelegate>

@property (nonatomic, strong) FriendBaseModel *BaseModel;

@property (nonatomic, strong) AsynImageView *userAvartImage;

@property (nonatomic, strong) UIButton *userAvartbtn;

@property (nonatomic, strong) MLLinkLabel *userNickLabel;

@property (nonatomic, strong) MLLinkLabel *contentTextLabel;

@property (nonatomic, strong) FriendGridImageView *gridImageView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *likeCommentBtn;

@property (nonatomic, strong) FriendOperationMenu *operationMenu;

@property (nonatomic, strong) FriendCommentView *commentView;

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
    
    __weak typeof(self) weakself = self;
       
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
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickUserNickLabel:)];
        [_userNickLabel addGestureRecognizer:tap];
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
        _contentTextLabel.delegate = self;
        
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
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_locationLabel];
    }
    
    if(nil == _timeLabel)
    {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = TimeLabelFont;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
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
        _operationMenu = [[FriendOperationMenu alloc] initWithFrame:CGRectZero];
        _operationMenu.hidden = YES;
        [self.contentView addSubview:_operationMenu];
        
        [_operationMenu setLikeButtonClickedOperation:^{
            
            if(weakself.delegate && [weakself.delegate respondsToSelector:@selector(onClickLikeButtonInCell:)])
            {
                [weakself.delegate onClickLikeButtonInCell:weakself];
            }
        
        }];
        
        [_operationMenu setCommentButtonClickedOpration:^{
            
            if(weakself.delegate && [weakself.delegate respondsToSelector:@selector(onClickCommentButtonInCell:)])
            {
                [weakself.delegate onClickCommentButtonInCell:weakself];
            }
        
        }];
    }
    
    
    if(nil == _commentView)
    {
        _commentView = [[FriendCommentView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_commentView];
        [_commentView setHidden:YES];
    }
    
}



/**
 *
 *
 *  @param sender
 */

-(void)onClickUserAvart:(id)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(onClickUserItem:)])
    {
        NSString *strUserURL = [NSString stringWithFormat:@"%@%@", SinaWeiBo_URL_UID, self.BaseModel.itemID];
        [_delegate onClickUserItem:strUserURL];
    }
}

-(void)onClickUserNickLabel:(UITapGestureRecognizer *)GestureRecognize
{
    if(_delegate &&[_delegate respondsToSelector:@selector(onClickUserItem:)])
    {
        UILabel *nickLabel = (UILabel *)GestureRecognize.view;
    
        NSString *url = [SinaWeiBo_URL_Name stringByAppendingString:[nickLabel.text URLEncodeString]];
        
        [_delegate onClickUserItem:url];
    }
}

- (void)didClickLink:(MLLink*)link linkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel
{
    NSLog(@"linkText is %@", linkText);
    
    if(link.linkType == MLLinkTypeURL) //url
    {
        if(_delegate && [_delegate respondsToSelector:@selector(onClickUserItem:)])
        {
            [_delegate onClickUserItem:linkText];
        }

    }
    else if (link.linkType == MLLinkTypeUserHandle) //@XXXX
    {
        NSString *strUserName = [linkText stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        NSString *url = [SinaWeiBo_URL_Name stringByAppendingString:[strUserName URLEncodeString]];
        
        if(_delegate && [_delegate respondsToSelector:@selector(onClickUserItem:)])
        {
            [_delegate onClickUserItem:url];
        }
    }
    else if (link.linkType == MLLinkTypeHashtag)  //#...#
    {
        NSString *strUserName = [linkText stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        NSString *url = [SinaWeiBo_URL_Topic stringByAppendingString:[strUserName URLEncodeString]];
        
        if(_delegate && [_delegate respondsToSelector:@selector(onClickUserItem:)])
        {
            [_delegate onClickUserItem:url];
        }

    }
}

/**
 *
 */

-(void)onClickLikeCommentBtn:(id)sender
{

    if(_operationMenu.blShow == NO)
    {
        [_operationMenu showPopMenu];
        [_operationMenu setHidden:NO];
    }
    else
    {
        [_operationMenu hidePopMenu];
        [_operationMenu setHidden:YES];
    }
    
}

-(void)setBaseCellFrame:(FriendBaseFrame *)BaseCellFrame
{
    _BaseModel = BaseCellFrame.baseModel;
   
    [self updateWithBaseModel:BaseCellFrame.baseModel];
    
    [self updateWithBaseFrame:BaseCellFrame];
}

-(void)updateWithBaseModel:(FriendBaseModel *)baseModel
{
    [_userAvartImage setImageURL:baseModel.strAvartUrl];
    [_userNickLabel setText:baseModel.strNick];
    
    [_contentTextLabel setText:baseModel.strContentText];
    
    if([baseModel.imageArray count] > 0)
    {
        [_gridImageView setHidden:NO];
        [_gridImageView setSrcImageArray:baseModel.imageArray];
        
    }
    else
    {
        [_gridImageView setHidden:YES];
    }
    
    [_locationLabel setText:baseModel.strLocation];
    
    [_timeLabel setText:baseModel.strTime];
    
    [_operationMenu setHidden:YES];
    
}

-(void)updateWithBaseFrame:(FriendBaseFrame *)FrameItem
{
    [_userAvartImage setFrame:FrameItem.avartFrame];
    [_userAvartbtn setFrame:FrameItem.avartFrame];
    
    [_userNickLabel setFrame:FrameItem.nickFrame];
    
    [_bodyView setFrame:FrameItem.bodyFrame];

    [_contentTextLabel setFrame:FrameItem.contentFrame];
    
    if([FrameItem.baseModel.imageArray count] > 0)
    {
        [_gridImageView setFrame:FrameItem.gridImageFrame];
        [_gridImageView setGridImageFrame:FrameItem.gridImageFrame];
    }
    
    [_locationLabel setFrame:FrameItem.locationFrame];
    
    [_timeLabel setFrame:FrameItem.timeFrame];
    
    [_likeCommentBtn setFrame:FrameItem.likeCommentFrame];
    
    [_operationMenu setFrame:FrameItem.operationMenuFrame];
    
    [_commentView setFrame:FrameItem.commentViewFrame];
    
}







@end
