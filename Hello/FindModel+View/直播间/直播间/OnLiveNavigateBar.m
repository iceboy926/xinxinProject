//
//  OnLiveNavigateBar.m
//  Hello
//
//  Created by 金玉衡 on 16/10/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "OnLiveNavigateBar.h"

@interface OnLiveNavigateBar()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *switchFrameBtn;

@end

@implementation OnLiveNavigateBar

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.switchFrameBtn];
        
        [self addConstraints];
        
    }
    
    return self;
}

- (void)addConstraints
{
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
    }];
    
    [self.switchFrameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
    }];
}

- (UIButton *)backBtn
{
    if(_backBtn == nil)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"live_back"] forState:UIControlStateNormal];
        [_backBtn setBackgroundColor:[UIColor clearColor]];
        [_backBtn addTarget:self action:@selector(backup) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

- (UILabel *)titleLabel
{
    if(_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _titleLabel.text = @"直播状态:未连接";
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _titleLabel;
}

- (UIButton *)switchFrameBtn
{
    if(_switchFrameBtn == nil)
    {
        _switchFrameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    
    return _switchFrameBtn;
}

- (void)backup
{
    
}

@end
