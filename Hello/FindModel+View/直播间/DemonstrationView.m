//
//  DemonstrationView.m
//  Hello
//
//  Created by 金玉衡 on 16/10/10.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "DemonstrationView.h"

@interface DemonstrationView()

@property (nonatomic, strong) UIImageView *demonImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation DemonstrationView


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self addSubview:self.demonImageView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.startBtn];
        
        [self setup];
    }
    
    return self;
}


- (void)setup
{
    [self.demonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        (void)make.edges;
    }];
    
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(self.center);
        make.width.mas_equalTo(self.demonImageView.mas_width);
        make.height.mas_equalTo(30);
    }];
    
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.demonImageView.mas_centerX);
        make.top.mas_equalTo(_tipLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
}

- (UIImageView *)demonImageView
{
    if(_demonImageView == nil)
    {
        _demonImageView = [[UIImageView alloc] init];
        _demonImageView.image = [UIImage imageNamed:@"icon_demo"];
    }
    
    return _demonImageView;
}


- (UILabel *)tipLabel
{
    if(_tipLabel == nil)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _tipLabel.text = @"请正确放置您的手机";
        _tipLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    
    return _tipLabel;
}

- (UIButton *)startBtn
{
    if(_startBtn == nil)
    {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setTitle:@"开始直播" forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _startBtn;
}

- (void)startBtn_Pressed:(id)sender
{
    if(self.DemonstrationBlock)
    {
        self.DemonstrationBlock();
    }
}


@end
