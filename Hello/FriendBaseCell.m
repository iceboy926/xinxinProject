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

@interface FriendBaseCell()

@property (nonatomic, strong) AsynImageView *userAvartImage;

@property (nonatomic, strong) UIButton *userAvartbtn;

@property (nonatomic, strong) MLLinkLabel *userNickLabel;

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) MLLinkLabel *contentTextLabel;

@property (nonatomic, strong) FriendGridImageView *gridImageView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic ,strong) UIButton *likeCommentBtn;ß


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
    
}

@end
