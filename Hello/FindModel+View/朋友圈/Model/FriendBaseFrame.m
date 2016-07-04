//
//  FriendBaseFrame.m
//  Hello
//
//  Created by 金玉衡 on 16/6/24.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendBaseFrame.h"
#import "FriendBaseModel.h"
#import "MLLinkLabel.h"
#import "MLLabel+Size.h"

#define margin 15
#define padding 10
#define avartsize 40
#define locationheight 40

#define GridMaxWidth (BodyMaxWidth*0.85)
#define UserNickMaxWidth 150

#define IMAGE_PADDING 2
#define likeCommentwidth  50
#define likeCommentheight 40
#define operationMenuwidth 180


@implementation FriendBaseFrame

-(void)setBaseModel:(FriendBaseModel *)baseModel
{
    _baseModel = baseModel;
    
    _totalHeight = 0.0;
    
    CGFloat x = 0.0, y = 0.0, width = 0.0, height = 0.0;
    
    
    //icon
    x = margin;
    y = margin;
    width = avartsize;
    height = avartsize;

    _avartFrame = CGRectMake(x, y, width, height);
    
    _totalHeight =  _totalHeight + y + height;
    
    
    
    //title
    NSAttributedString *nickName = [[NSAttributedString alloc] initWithString:baseModel.strNick];

    CGSize textsize = [MLLinkLabel getViewSize:nickName maxWidth:UserNickMaxWidth font:UserNickFont lineHeight:1.0 lines:1];

    x = CGRectGetMaxX(_avartFrame) + padding;
    y = CGRectGetMinY(_avartFrame) + 2;
    width = textsize.width;
    height = textsize.height;
    
    _nickFrame = CGRectMake(x, y, width, height);
    
    
    
    //content & pic  body
    x = CGRectGetMaxX(_avartFrame) + padding;
    y = CGRectGetMaxY(_avartFrame) + padding;
    
    width = MAX_WIDTH - x - padding;
    height = 0;
    
    _bodyFrame = CGRectMake(x, y, width, height);
    
    _totalHeight =  _totalHeight + height;
    
    //content
    NSAttributedString *content = [[NSAttributedString alloc] initWithString:baseModel.strContentText];
    
    CGSize contentsize = [MLLinkLabel getViewSize:content maxWidth:_bodyFrame.size.width font:TextFont lineHeight:1.0 lines:0];
    
    x = 0.0;
    y = 0.0;
    width = contentsize.width;
    height = contentsize.height;
    
    _contentFrame = CGRectMake(x, y, width, height);
    
    _totalHeight =  _totalHeight + height;
    
    // pic
    NSInteger picCount = [baseModel.imageArray count];
    if(picCount > 0)
    {
        
        x = 0.0;
        y = CGRectGetMaxY(_contentFrame) + padding;
        width = CGRectGetWidth(_bodyFrame);
        height =  (picCount/3 + 1)*IMAGE_HEIGHT + (picCount/3 + 1)*IMAGE_PADDING;
        
        _gridImageFrame = CGRectMake(x, y, width, height);
        
        _totalHeight =  _totalHeight + height + padding;
    }
    
    
    //location  time
    
    x = _bodyFrame.origin.x;
    y = CGRectGetMaxY(_bodyFrame) + padding;
    width = _bodyFrame.size.width/2;
    height = locationheight;
    
    _locationFrame = CGRectMake(x, y, width, height);
    
    
    x = _bodyFrame.size.width/2;
    y = _locationFrame.origin.y;
    width = _bodyFrame.size.width/2;
    height = locationheight;
    
    _timeFrame = CGRectMake(x, y, width, height);
    
    
    _totalHeight = _totalHeight + locationheight + padding;
    
    

    //like comment tool
    x = MAX_WIDTH - likeCommentwidth - padding;
    y = CGRectGetMaxY(_locationFrame) + padding;
    width = likeCommentwidth;
    height = likeCommentheight;
    
    _likeCommentFrame = CGRectMake(x, y, width, height);
    
    
    //operateMenu
    x = CGRectGetMinX(_likeCommentFrame) - operationMenuwidth;
    y = CGRectGetMaxY(_locationFrame) + padding;
    width = operationMenuwidth;
    height = likeCommentheight;
    _operationMenuFrame = CGRectMake(x, y, width, height);
    
    _totalHeight = _totalHeight + likeCommentheight + padding;
    
    
    
}

@end
