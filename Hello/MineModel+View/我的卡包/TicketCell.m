//
//  ticketCell.m
//  Hello
//
//  Created by 金玉衡 on 16/7/28.
//  Copyright © 2016年 mit. All rights reserved.
//


// 宽高
#define kTKCellTopMargin 15      // cell 顶部灰色留白
#define kTKCellInnerPadding 12  // cell 内边距
#define kTKCellCardHeight 70    // cell card 视图高度

#import "TicketCell.h"
#import "TicketModel.h"

@implementation TicketCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _marginTopView = [[UIView alloc] init];
        _marginTopView.backgroundColor = [self.superview.superview backgroundColor];
        [self.contentView addSubview:_marginTopView];
        
        _backgroundImageView = [[UIImageView alloc] init];
        //_backgroundImageView.clipsToBounds = YES;
        _backgroundImageView.layer.shadowColor = [[UIColor whiteColor] CGColor];
        _backgroundImageView.layer.shadowOffset = CGSizeMake(0, 0);
        _backgroundImageView.layer.shadowRadius = 10.0;
        _backgroundImageView.layer.shadowOpacity = 0.5;
        
        _backgroundImageView.layer.cornerRadius = 10.0;
        _backgroundImageView.layer.masksToBounds = YES;
        
        _backgroundImageView.layer.borderWidth = 2.0;
        _backgroundImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        
        _backgroundImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_backgroundImageView];
        
        _perferentialLabel = [[UILabel alloc] init];
        _perferentialLabel.textAlignment = NSTextAlignmentCenter;
        [_backgroundImageView addSubview:_perferentialLabel];
        
        _goodNameLabel = [[UILabel alloc] init];
        _goodNameLabel.font = [UIFont boldSystemFontOfSize:17];
        _goodNameLabel.textAlignment = NSTextAlignmentLeft;
        [_backgroundImageView addSubview:_goodNameLabel];
        
        _effectConditionLabel = [[UILabel alloc] init];
        _effectConditionLabel.font = [UIFont systemFontOfSize:12];
        _effectConditionLabel.textAlignment = NSTextAlignmentLeft;
        _effectConditionLabel.textColor = kWBCellTextSubTitleColor;
        [_backgroundImageView addSubview:_effectConditionLabel];
        
        _deadLineLabel = [[UILabel alloc] init];
        _deadLineLabel.font = [UIFont systemFontOfSize:12];
        _deadLineLabel.textAlignment = NSTextAlignmentLeft;
        _deadLineLabel.textColor = kWBCellTextSubTitleColor;
        [_backgroundImageView addSubview:_deadLineLabel];
        
        _userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_userBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_userBtn setTitle:@"使用" forState:UIControlStateNormal];
        [_userBtn addTarget:self action:@selector(didClickedUseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundImageView addSubview:_userBtn];
        
        
        [_marginTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.height.mas_equalTo(kTKCellTopMargin);
        }];
        
        
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(self.contentView.mas_left).with.offset(kTKCellInnerPadding);
            make.right.mas_equalTo(self.contentView.mas_right).with.offset(-kTKCellInnerPadding);
            make.top.mas_equalTo(_marginTopView.mas_bottom);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
        
        [_perferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(_backgroundImageView.mas_left);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(_backgroundImageView.mas_height);
            make.centerY.mas_equalTo(_backgroundImageView.mas_centerY);
        }];
        
        [_goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(_perferentialLabel.mas_right);
            make.right.mas_equalTo(_userBtn.mas_left);
            make.top.mas_equalTo(_backgroundImageView.mas_top).with.offset(8);
            make.height.mas_equalTo(35);
            
        }];
        
        [_effectConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(_perferentialLabel.mas_right);
            make.right.mas_equalTo(_userBtn.mas_left);
            make.top.mas_equalTo(_goodNameLabel.mas_bottom);
            make.height.mas_equalTo(_goodNameLabel.mas_height);
        }];
        
        [_deadLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(_perferentialLabel.mas_right);
            make.right.mas_equalTo(_userBtn.mas_left);
            make.top.mas_equalTo(_effectConditionLabel.mas_bottom);
            make.height.mas_equalTo(_goodNameLabel.mas_height);
        }];
        
        [_userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.mas_equalTo(_backgroundImageView.mas_right);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(_goodNameLabel.mas_height);
            make.top.mas_equalTo(_goodNameLabel.mas_top);
        }];
        
        
    }
    
    return self;
}

- (void)configurateWithModel:(id<TicketModelProtocol>)Model
{
    [_userBtn setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    
    _backgroundImageView.image = [[UIImage imageNamed: [Model backgroundImageName]] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    _perferentialLabel.attributedText = [Model perferential];
    _effectConditionLabel.text = [Model effectCondition];
    _goodNameLabel.text = [Model goodName];
    _deadLineLabel.text = [Model deadLine];
    
    [_effectConditionLabel sizeToFit];
    [_goodNameLabel sizeToFit];
    [_deadLineLabel sizeToFit];
}

- (void)didClickedUseBtn:(id)sender
{
    NSLog(@"   %s", __FUNCTION__);
}

@end
