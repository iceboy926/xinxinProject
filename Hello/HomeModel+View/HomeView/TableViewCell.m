//
//  TableViewCell.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "TableViewCell.h"
#import "HomeCellFrame.h"
#import "HomeCellModel.h"
#import "AsynImageView.h"
#import "UIImage+ResizeImage.h"

#define  DETAILLABLE_TAG  1000
#define  RETWEETLABLE_TAG 2000


@implementation TableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
         //头像
        _iconView = [[AsynImageView alloc] init];
        _iconView.placeholderImage = [UIImage imageNamed:@"cute_boy_1.png"];
        _iconView.userInteractionEnabled = YES;
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.layer.cornerRadius = ICON_HEIGH/2;
        _iconView.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
        _iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconView];
        UITapGestureRecognizer *tapRecIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchUserIcon:)];
        [_iconView addGestureRecognizer:tapRecIcon];
        
        
        
        //name
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kWBCellNameFont;
        _nameLabel.textColor = kWBCellNameNormalColor;
        _nameLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:_nameLabel];
        
        UITapGestureRecognizer *tapGestR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchNameLabel:)];
        [_nameLabel addGestureRecognizer:tapGestR];
        
        
        
        //vip
        _vipView = [[UIImageView alloc] init];
        _vipView.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:_vipView];
        
        
        //timesource
        _timeSourceLabel = [[UILabel alloc] init];
        _timeSourceLabel.font = kWBCellSourceFont;
        _timeSourceLabel.textColor = kWBCellTimeNormalColor;
        [self.contentView addSubview:_timeSourceLabel];
        
        
        //detail
        _detailLabel = [[PPLabel alloc] init];
        _detailLabel.delegate = self;
        _detailLabel.font = kWBCellTextFont;
        _detailLabel.textColor = kWBCellTextNormalColor;
        _detailLabel.numberOfLines = 0;
        _detailLabel.tag = DETAILLABLE_TAG;
        [self.contentView addSubview:_detailLabel];
        
        
    
        //picture
        _pickView = [[UIView alloc] init];
        //_pickView.placeholderImage = [UIImage imageNamed:@"pickView"];
        _pickView.userInteractionEnabled = YES;
        [self.contentView addSubview:_pickView];
        
        
        _picArray = [[NSMutableArray alloc] init];
        
        
        
        //
        _retweetView = [[UIView alloc] init];
        _retweetView.userInteractionEnabled = YES;
        _retweetView.backgroundColor = kWBCellInnerViewColor;
        [self.contentView addSubview:_retweetView];
        
        
        _retweetLabel = [[PPLabel alloc] init];
        _retweetLabel.delegate = self;
        _retweetLabel.font = kWBCellTextFontRetweet;
        _retweetLabel.textColor = kWBCellTextSubTitleColor;
        _retweetLabel.numberOfLines = 0;
        _retweetLabel.tag = RETWEETLABLE_TAG;
        [_retweetView addSubview:_retweetLabel];
        
        
        _retweetPicView = [[UIView alloc] init];
        _retweetPicView.userInteractionEnabled = YES;
        [_retweetView addSubview:_retweetPicView];

        
        _retweetPicArray = [[NSMutableArray alloc] init];
        
        
        //_toolBarView = [[UIView alloc] init];
        //_toolBarView.userInteractionEnabled = YES;
        
        //[self.contentView addSubview:_toolBarView];
        
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(void)setFrame:(CGRect)frame
//{
//    frame.origin.x = 10;//这里间距为10，可以根据自己的情况调整
//    frame.size.height -= 2 * frame.origin.x;
//    [super setFrame:frame];
//}

-(void)setCellFrame:(HomeCellFrame *)CellFrame
{
    _CellFrame = CellFrame;
    
    [self setHomeCellData];
    
    [self setHomeCellFrame];
}

-(void)setHomeCellData
{
    HomeCellModel *CellModel = _CellFrame.HomeCell;
    
    [_iconView showImage:CellModel.icon];
    [_iconView setTag:ICON_IMAGE_TAG];
    
    _nameLabel.text = CellModel.Name;
    
    if(CellModel.blVip)
    {
        _vipView.hidden = NO;
        _nameLabel.textColor = kWBCellNameOrangeColor;
    }
    else
    {
        _vipView.hidden = YES;
        _nameLabel.textColor = kWBCellNameNormalColor;
    }
    
    _timeSourceLabel.text = CellModel.timesource;
    
    _detailLabel.text = CellModel.detail;
    
    
    
    
    
    NSError *error = NULL;
    
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    
    NSArray *matchsLinkArray = [detector matchesInString:_detailLabel.text options:0 range:NSMakeRange(0, _detailLabel.text.length)];
    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(@[a-zA-Z0-9._\u4E00-\u9FA5]+)|#([a-zA-Z0-9._\u4E00-\u9FA5]*)#" options:0 error:nil];
    
    NSArray *matchNameTopicArray = [regex matchesInString:_detailLabel.text options:0 range:NSMakeRange(0, _detailLabel.text.length)];
    
    detailLinkArrayList = [matchsLinkArray arrayByAddingObjectsFromArray:matchNameTopicArray];
    

    [self highlightLinksWithIndex:NSNotFound :_detailLabel];

    
    [_picArray removeAllObjects];
    
    for (UIView *view in _pickView.subviews) {
        [view removeFromSuperview];
    }
    
    if([CellModel.pictureArray count] > 0)
    {
        
        for(NSString *picrul in CellModel.pictureArray)
        {
            AsynImageView *asyImage = [[AsynImageView alloc] init];
            
            asyImage.placeholderImage = [UIImage imageNamed:@"pickView"];
            [asyImage showImage:picrul];
            [asyImage setTag:DETAIL_IMAGE_TAG];
            
            asyImage.userInteractionEnabled = YES;
            
            __weak AsynImageView *blockasyImage = asyImage;
            
            asyImage.completion = ^(UIImage *image){
            
                CGFloat  height = image.size.height;
                CGFloat  width = image.size.width;
                
                //NSLog(@"height is %lf width is %lf", height, width);
                
                CGFloat scale = (height/width) / (IMAGE_HEIGHT/IMAGE_WIDTH);
                
                //NSLog(@"scale is %lf", scale);
                
                if (scale < 0.99 || isnan(scale)) { // 宽图把左右两边裁掉
                    blockasyImage.contentMode = UIViewContentModeScaleAspectFill;
                    blockasyImage.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                } else { // 高图只保留顶部
                    blockasyImage.contentMode = UIViewContentModeScaleToFill;
                    blockasyImage.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
                }
                
                blockasyImage.image = image;
                blockasyImage.clipsToBounds = YES;
            };
            
           

            
            
            [_pickView addSubview:asyImage];
            
            UITapGestureRecognizer *tapRecIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchPicView:)];
            [asyImage addGestureRecognizer:tapRecIcon];
            
            [_picArray addObject:asyImage];
        }
        
        _pickView.hidden = NO;
    }
    else
    {
        _pickView.hidden = YES;
    }
    
    
    if(CellModel.blretweet)  //有转发
    {
        for(UIView *view in _retweetPicView.subviews)
        {
            [view removeFromSuperview];
        }
        
        [_retweetPicArray removeAllObjects];
        
        _retweetLabel.text = CellModel.retweetDetail;
        
        NSArray *matchLinkArray = [detector matchesInString:_retweetLabel.text options:0 range:NSMakeRange(0, _retweetLabel.text.length)];
        
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(@[a-zA-Z0-9._\u4E00-\u9FA5]+)|#([a-zA-Z0-9._\u4E00-\u9FA5]*)#" options:0 error:nil];
        
        NSArray *matchNameTopicArray = [regex matchesInString:_retweetLabel.text options:0 range:NSMakeRange(0, _retweetLabel.text.length)];
        
        retweetLinkArrayList = [matchLinkArray arrayByAddingObjectsFromArray:matchNameTopicArray];
        

        [self highlightLinksWithIndex:NSNotFound :_retweetLabel];
        
        
        if([CellModel.retweetPictureArray count] > 0)
        {
            
            
            for(NSString *picrul in CellModel.retweetPictureArray)
            {
                AsynImageView *asyImage = [[AsynImageView alloc] init];
                
                asyImage.placeholderImage = [UIImage imageNamed:@"pickView"];
            
                [asyImage setTag:RETWEET_IMAGE_TAG];
                
                [asyImage showImage:picrul];
                
                asyImage.userInteractionEnabled = YES;
                
                __weak AsynImageView *weekimage = asyImage;
                
                asyImage.completion = ^(UIImage *image){
                
                    CGFloat  height = image.size.height;
                    CGFloat  width = image.size.width;
                    
                    //NSLog(@"height is %lf width is %lf", height, width);
                    
                    CGFloat scale = (height/width) / (IMAGE_HEIGHT/IMAGE_WIDTH);
                    
                    //NSLog(@"scale is %lf", scale);
                    
                    if (scale < 0.99 || isnan(scale)) { // 宽图把左右两边裁掉
                        weekimage.contentMode = UIViewContentModeScaleAspectFill;
                        weekimage.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                    } else { // 高图只保留顶部
                        weekimage.contentMode = UIViewContentModeScaleToFill;
                        weekimage.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
                    }
                    
                    weekimage.image = image;
                    weekimage.clipsToBounds = YES;

                
                };
                
                
                [_retweetPicView addSubview:asyImage];
                
                UITapGestureRecognizer *tapRecIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchPicView:)];
                [asyImage addGestureRecognizer:tapRecIcon];
                
                [_retweetPicArray addObject:asyImage];
            }
            
            
            _retweetPicView.hidden = NO;
        }
        else
        {
            _retweetPicView.hidden = YES;
        }

        _retweetView.hidden = NO;
    }
    else
    {
        _retweetView.hidden = YES;
    }
    
    
    //_toolBarView.layer.borderWidth = 0.1;

    //_toolBarView.layer.borderColor = [UIColor grayColor].CGColor;
}

-(void)setHomeCellFrame
{
    
    _iconView.frame = _CellFrame.iconFrame;
    
    _nameLabel.frame = _CellFrame.nameFrame;
    
    _vipView.frame = _CellFrame.vipFrame;
    
    _timeSourceLabel.frame = _CellFrame.timesourceFrame;
    
    _detailLabel.frame = _CellFrame.detailFrame;
    
    if([_CellFrame.HomeCell.pictureArray count] > 0)
    {
        
        for(int i = 0; i < [_pickView.subviews count]; i++)
        {
            UIView *imageView = (UIView *)[_pickView.subviews objectAtIndex:i];
            imageView.frame =[[_CellFrame.pictFrameArray objectAtIndex:i] CGRectValue];
        }
        
        _pickView.frame = _CellFrame.pictureFrame;
    }
    
    if(_CellFrame.HomeCell.blretweet) //有转发
    {
        _retweetView.frame = _CellFrame.retweetViewFrame;
        
        _retweetLabel.frame = _CellFrame.retweetDetailFrame;
        
        if([_CellFrame.HomeCell.retweetPictureArray count] > 0)
        {
            for(int i = 0; i < [_retweetPicView.subviews count]; i++)
            {
                UIView *imageView = (UIView *)[_retweetPicView.subviews objectAtIndex:i];
                imageView.frame = [[_CellFrame.retweetPictureFrameArray objectAtIndex:i] CGRectValue];
            }
            
            _retweetPicView.frame = _CellFrame.retweetPictureFrame;
        }
    }
    
    
    //_toolBarView.frame = _CellFrame.toolBarViewFrame;
    
}

- (void)label:(PPLabel*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex
{
    [self highlightLinksWithIndex:charIndex :label];
}
- (void)label:(PPLabel*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex
{
    [self highlightLinksWithIndex:charIndex :label];
}
- (void)label:(PPLabel*)label didEndTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex
{
    [self highlightLinksWithIndex:NSNotFound :label];
    
    NSArray *arrylist = nil;
    
    if(label.tag == DETAILLABLE_TAG)
    {
        arrylist = detailLinkArrayList;
    }
    else if(label.tag == RETWEETLABLE_TAG)
    {
        arrylist = retweetLinkArrayList;
    }
    
    
    
    for (NSTextCheckingResult *match in arrylist) {
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            
            NSRange matchRange = [match range];
            
            if ([self isIndex:charIndex inRange:matchRange]) {
                
                [self.delegate DidPushWebView:match.URL Index:self.Index viewTitle:_nameLabel.text];
                break;
            }
        }
        else if([match resultType] == NSTextCheckingTypeRegularExpression)
        {
            NSRange matchRange = [match range];
            
            if ([self isIndex:charIndex inRange:matchRange]) {
                
                [self.delegate DidPushLinkUserNameView:[label.text substringWithRange:matchRange]];
                break;
            }

        }
    }
}
- (void)label:(PPLabel*)label didCancelTouch:(UITouch*)touch
{
    [self highlightLinksWithIndex:NSNotFound :label];
}

- (BOOL)isIndex:(CFIndex)index inRange:(NSRange)range {
    return index > range.location && index < range.location+range.length;
}

- (void)highlightLinksWithIndex:(CFIndex)index :(PPLabel*)label{
    
    NSMutableAttributedString* attributedString = [label.attributedText mutableCopy];
    NSArray *arraylist = nil;
    
    if(label.tag == DETAILLABLE_TAG)
    {
        arraylist = detailLinkArrayList;
    }
    else
    {
        arraylist = retweetLinkArrayList;
    }
    
    for (NSTextCheckingResult *match in arraylist)
    {
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            
            NSRange matchRange = [match range];
            
            if ([self isIndex:index inRange:matchRange]) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:kWBCellTextHighlightBackgroundColor range:matchRange];
            }
            else {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:matchRange];
            }
            
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:matchRange];
        }
        else if([match resultType] == NSTextCheckingTypeRegularExpression)
        {
            NSRange matchRange = [match range];
            
            if ([self isIndex:index inRange:matchRange]) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:kWBCellTextHighlightBackgroundColor range:matchRange];
            }
            else {
                [attributedString addAttribute:NSForegroundColorAttributeName value:kWBCellTextHighlightColor range:matchRange];
            }
        }
    }
    
    label.attributedText = attributedString;

    
}

- (void) TouchNameLabel:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)[tap view];
    
    if([_delegate respondsToSelector:@selector(DidTouchNamelabel:)])
    {
        [_delegate DidTouchNamelabel:label.text];
    }
}

- (void) TouchUserIcon:(UITapGestureRecognizer *)tap
{
    AsynImageView *iconView = (AsynImageView *)[tap view];
    if([_delegate respondsToSelector:@selector(DidTouchUserIcon: Index:)])
    {
        [_delegate DidTouchUserIcon:iconView Index:self.Index];
    }
}

- (void)TouchPicView:(UITapGestureRecognizer *)tap
{
    AsynImageView *picView = (AsynImageView *)[tap view];
    
    if([_delegate respondsToSelector:@selector(DidTouchPicAsyView:)])
    {
        [_delegate DidTouchPicAsyView:picView];
    }
}


@end
