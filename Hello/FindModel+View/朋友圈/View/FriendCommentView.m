//
//  FriendCommentView.m
//  Hello
//
//  Created by 金玉衡 on 16/7/13.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendCommentView.h"


@interface FriendCommentView()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) MLLinkLabel *likeLabel;

@property (nonatomic, strong) UIView *lineBottomView;

@end

@implementation FriendCommentView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initUI];
    }
    
    return self;
}

-(void)initUI
{
    _bgImageView = [[UIImageView alloc] init];
    UIImage *image = [[UIImage imageNamed:@"LikeCmtBg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 60, 10, 10) resizingMode:UIImageResizingModeStretch];
    _bgImageView.image = image;
    
    [self addSubview:_bgImageView];
    
    _likeLabel = [[MLLinkLabel alloc] init];
    _likeLabel.font = kWBCellToolbarFont;
    _likeLabel.linkTextAttributes = @{NSForegroundColorAttributeName: kWBCellTextHighlightColor};
    [self addSubview:_likeLabel];
    
    _lineBottomView = [[UIView alloc] init];
    _lineBottomView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [self addSubview:_lineBottomView];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.mas_left).with.offset(5);
        make.top.mas_equalTo(self.mas_top).with.offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self.mas_width);
    }];
    
    [_lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.mas_left).with.offset(5);
        make.top.mas_equalTo(_likeLabel.mas_bottom).with.offset(1);
        make.right.mas_equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(1);
    }];
    
}


@end
