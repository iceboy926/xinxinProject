//
//  CellToolBarView.m
//  Hello
//
//  Created by 金玉衡 on 16/6/22.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "CellToolBarView.h"
#import "CellToolBarModel.h"

@implementation CellToolBarView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        const int padding = 5;
        const int imageHeight = 20;
        const int imageWidth = 25;
        
        _repostView = [[UIView alloc] init];
        _repostView.backgroundColor = [UIColor clearColor];
        [self addSubview:_repostView];
        
        _commentView = [[UIView alloc] init];
        _commentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_commentView];
        
        _likeView = [[UIView alloc] init];
        _likeView.backgroundColor = [UIColor clearColor];
        [self addSubview:_likeView];
        
        
        [_repostView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(self.mas_height);
            make.width.mas_equalTo(_commentView.mas_width);
            make.left.mas_equalTo(self.mas_left).with.offset(padding);
            make.right.mas_equalTo(_commentView.mas_left).with.offset(-padding);
        }];
        
        [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(self.mas_height);
            make.width.mas_equalTo(_likeView.mas_width);
            make.left.mas_equalTo(_repostView.mas_right).with.offset(padding);
            make.right.mas_equalTo(_likeView.mas_left).with.offset(-padding);
        }];
        
        
        [_likeView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(self.mas_height);
            make.width.mas_equalTo(_repostView.mas_width);
            make.left.mas_equalTo(_commentView.mas_right).with.offset(padding);
            make.right.mas_equalTo(self.mas_right).with.offset(-padding);
        }];
        
        
        _repostImage = [[UIImageView alloc] init];
        _repostImage.userInteractionEnabled = YES;
        [_repostView addSubview:_repostImage];
        
        _repostLabel = [[UILabel alloc] init];
        _repostLabel.textAlignment = NSTextAlignmentLeft;
        _repostLabel.textColor = [UIColor grayColor];
        _repostLabel.font = [UIFont systemFontOfSize:12];
        [_repostView addSubview:_repostLabel];
        
        
        [_repostImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(_repostView.mas_centerY);
            make.height.mas_equalTo(imageHeight);
            make.width.mas_equalTo(imageWidth);
            make.right.mas_equalTo(_repostView.mas_centerX);
            
        }];
        
        [_repostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(_repostView.mas_centerY);
            make.height.mas_equalTo(_repostView.mas_height);
            make.left.mas_equalTo(_repostImage.mas_right);
            make.right.mas_equalTo(_repostView.mas_right);
            
        }];
        
        
        _commentImage = [[UIImageView alloc] init];
        _commentImage.userInteractionEnabled = YES;
        [_commentView addSubview:_commentImage];
        
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.textColor = [UIColor grayColor];
        _commentLabel.font = [UIFont systemFontOfSize:12];
        [_commentView addSubview:_commentLabel];
        
        
        [_commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(_commentView.mas_centerY);
            make.height.mas_equalTo(@(imageHeight));
            make.width.mas_equalTo(@(imageWidth));
            make.right.mas_equalTo(_commentView.mas_centerX);
            
        }];
        
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.mas_equalTo(_commentView.mas_centerY);
            make.height.mas_equalTo(_commentView.mas_height);
            make.left.mas_equalTo(_commentImage.mas_right);
            make.right.mas_equalTo(_commentView.mas_right);
            
        }];
        

        
        
        _likeImage = [[UIImageView alloc] init];
        _likeImage.userInteractionEnabled = YES;
        [_likeView addSubview:_likeImage];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClikeLikeImage:)];
        [_likeView addGestureRecognizer:tapGesture];
        
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.textAlignment = NSTextAlignmentLeft;
        _likeLabel.textColor = [UIColor grayColor];
        _likeLabel.font = [UIFont systemFontOfSize:12];
        [_likeView addSubview:_likeLabel];
        
        
        
        [_likeImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.mas_equalTo(_likeView.mas_centerY);
            make.height.mas_equalTo(@(imageHeight));
            make.width.mas_equalTo(@(imageWidth));
            make.right.mas_equalTo(_likeView.mas_centerX);
            
        }];
        
        [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.mas_equalTo(_likeView.mas_centerY);
            make.height.mas_equalTo(_likeView.mas_height);
            make.left.mas_equalTo(_likeImage.mas_right);
            make.right.mas_equalTo(_likeView.mas_right);
            
        }];
        
    }
    
    return self;
}


-(void)setData:(CellToolBarModel *)toolBarModel
{
    [_repostImage setImage:[UIImage imageNamed:@"icon_retweet"]];
    [_commentImage setImage:[UIImage imageNamed:@"icon_comment"]];
    [_likeImage setImage:[UIImage imageNamed:@"icon_unlike"]];
    
    _repostLabel.text = toolBarModel.repostStr;
    _commentLabel.text = toolBarModel.commentStr;
    _likeLabel.text = toolBarModel.likeStr;
}

-(void)didClikeLikeImage:(UITapGestureRecognizer*) tap
{
    static BOOL bllike = NO;
    bllike = !bllike;
    [self setLiked:bllike];
}

- (void)setLiked:(BOOL)liked
{
    int likeCount = 0;
    if([_likeLabel.text isEqualToString:@"赞"])
    {
        if(liked == YES)
        {
            likeCount++;
        }
    }
    else
    {
        int currentlikeCount = [_likeLabel.text intValue];
        if(currentlikeCount == 0)
        {
            likeCount = 0;
        }
        else
        {
            likeCount = liked ? (currentlikeCount+1):(currentlikeCount-1);
        }
    }
    NSString *strLike = nil;
    
    if(likeCount == 0)
    {
        strLike = [NSString stringWithFormat:@"赞"];
    }
    else
    {
        strLike = [NSString stringWithFormat:@"%d", likeCount];
    }
    
    
    UIImage *image = liked ? [UIImage imageNamed:@"icon_like"] : [UIImage imageNamed:@"icon_unlike"];
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState| UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _likeImage.layer.transform = CATransform3DMakeScale(1.7, 1.7, 1.7);
        
    } completion:^(BOOL finished) {
        
        _likeImage.image = image;
        _likeLabel.text = strLike;
        _likeLabel.textColor = liked ? [UIColor redColor] : [UIColor grayColor];

        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
            
            _likeImage.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.9);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
                
                _likeImage.layer.transform = CATransform3DMakeScale(1, 1, 1);
                
            } completion:^(BOOL finished) {
                
            }];
        }];
        
    }];
    
}

@end
