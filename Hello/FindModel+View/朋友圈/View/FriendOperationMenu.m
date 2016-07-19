//
//  OperationMenu.m
//  Hello
//
//  Created by 金玉衡 on 16/7/4.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendOperationMenu.h"

@interface FriendOperationMenu ()
{
    UIButton *_likeButton;
    UIButton *_commentButton;
    CGFloat  _width;
}
@end

@implementation FriendOperationMenu

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setup];
    }
    
    return self;
}


-(void)setup
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = UIColorHex(@"454A4C");
    
    _blShow = NO;
    
    _likeButton = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"AlbumLike"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(likeButtonClicked)];
    
    [self addSubview:_likeButton];
    
    _commentButton = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"AlbumComment"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(commentButtonClicked)];
    
    [self addSubview:_commentButton];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:lineView];
    
    CGFloat margin = 5;
    
    
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(40);
        make.left.mas_equalTo(self.mas_left).with.offset(margin);
        
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(_likeButton.mas_right).with.offset(margin);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(lineView.mas_right).with.offset(margin);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(_likeButton.mas_width).multipliedBy(1.5);
        
    }];

}


- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}


-(void)likeButtonClicked
{
    if(self.likeButtonClickedOperation)
    {
        self.likeButtonClickedOperation();
    }
}

-(void)commentButtonClicked
{
    if(self.commentButtonClickedOpration)
    {
        self.commentButtonClickedOpration();
    }
}


-(void)showPopMenu
{
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    _blShow = YES;
}

-(void)hidePopMenu
{
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    }];
    
    _blShow = NO;
}


@end
