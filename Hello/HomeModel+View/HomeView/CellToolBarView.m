//
//  CellToolBarView.m
//  Hello
//
//  Created by 金玉衡 on 16/6/22.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "CellToolBarView.h"
#import "CellToolBarModel.h"
#import "Masonry.h"

@implementation CellToolBarView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        int padding = 5;
        
        _repostView = [[UIView alloc] init];
        _repostView.backgroundColor = [UIColor redColor];
        [self addSubview:_repostView];
        
        _commentView = [[UIView alloc] init];
        _commentView.backgroundColor = [UIColor blueColor];
        [self addSubview:_commentView];
        
        _likeView = [[UIView alloc] init];
        _likeView.backgroundColor = [UIColor grayColor];
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
        
        
    }
    
    return self;
}


-(void)setData:(CellToolBarModel *)toolBarModel
{
    
}

@end
