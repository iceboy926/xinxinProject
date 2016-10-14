//
//  OnLiveTabBar.m
//  Hello
//
//  Created by 金玉衡 on 16/10/11.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "OnLiveTabBar.h"

@interface OnLiveTabBar()

@property (nonatomic, strong) UIButton *microPhoneBtn;
@property (nonatomic, strong) UIButton *changeCameraBtn;
@property (nonatomic, strong) UIButton *recordingBtn;
@property (nonatomic, strong) UIButton *photoflashBtn;
@property (nonatomic, strong) UIButton *screenshotsBtn;

@end

@implementation OnLiveTabBar


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.7];
        
        [self addSubview:self.microPhoneBtn];
        [self addSubview:self.changeCameraBtn];
        [self addSubview:self.recordingBtn];
        [self addSubview:self.photoflashBtn];
        [self addSubview:self.screenshotsBtn];
        
        [self addConstraints];
    }
    
    return self;
}


- (void)addConstraints
{
    [self.microPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(20);
        make.height.width.equalTo(self.mas_height);
    }];
    
    [self.changeCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_microPhoneBtn.mas_right).with.offset(20);
        make.height.width.equalTo(self.mas_height);
        
    }];
    
    [self.recordingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.height.width.equalTo(self.mas_height);
        
    }];
    
    [self.photoflashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.right.equalTo(_screenshotsBtn.mas_left);
        make.height.width.equalTo(self.mas_height);
    }];
    
    
    [self.screenshotsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.height.width.equalTo(self.mas_height);
    }];
}


- (UIButton *)microPhoneBtn
{
    if(_microPhoneBtn == nil)
    {
        _microPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_microPhoneBtn setImage:[UIImage imageNamed:@"icon_microphone_on"] forState: UIControlStateNormal];
        
        [_microPhoneBtn addTarget:self action:@selector(microphoneAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _microPhoneBtn;
}

- (UIButton *)changeCameraBtn
{
    if(_changeCameraBtn == nil)
    {
        _changeCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeCameraBtn setImage:[UIImage imageNamed:@"icon_camera_change"] forState: UIControlStateNormal];
        
        [_changeCameraBtn  addTarget:self action:@selector(changeCameraAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _changeCameraBtn;
}

- (UIButton *)recordingBtn
{
    if(_recordingBtn == nil)
    {
        _recordingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordingBtn setImage:[UIImage imageNamed:@"icon_video_stop"] forState: UIControlStateNormal];
        [_recordingBtn addTarget:self action:@selector(recordingAction:) forControlEvents: UIControlEventTouchUpInside];
    }
    
    return _recordingBtn;
}

- (UIButton *)photoflashBtn
{
    if(_photoflashBtn == nil)
    {
        _photoflashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoflashBtn setImage:[UIImage imageNamed:@"icon_flash_off"] forState: UIControlStateNormal];
    
        [_photoflashBtn addTarget:self action:@selector(photoflashAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _photoflashBtn;
}

- (UIButton *)screenshotsBtn
{
    if (_screenshotsBtn == nil) {
        
        _screenshotsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_screenshotsBtn setImage:[UIImage imageNamed:@"icon_cramera_on"] forState: UIControlStateNormal];
        
        [_screenshotsBtn addTarget:self action:@selector(screenshotsAction:) forControlEvents: UIControlEventTouchUpInside];
        
    }
    
    return _screenshotsBtn;
}

- (void)microphoneAction:(UIButton *)sender
{
    if(self.microphoneBtnBlock)
    {
        self.microphoneBtnBlock(sender);
    }
}

- (void)changeCameraAction:(UIButton *)sender
{
    if(self.changeCamerBtnBlock)
    {
        self.changeCamerBtnBlock(sender);
    }
    
}

- (void)recordingAction:(UIButton *)sender
{
    if(self.recordingBtnBlock)
    {
        self.recordingBtnBlock(sender);
    }
}

- (void)photoflashAction:(UIButton *)sender
{
    if(self.photoflashBtnBlock)
    {
        self.photoflashBtnBlock(sender);
    }
}

- (void)screenshotsAction:(UIButton *)sender
{
    if(self.screenshotBtnBlock)
    {
        self.screenshotBtnBlock(sender);
    }
}


@end
