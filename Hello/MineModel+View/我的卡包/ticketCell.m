//
//  ticketCell.m
//  Hello
//
//  Created by 金玉衡 on 16/7/28.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "ticketCell.h"
#import "ticketModel.h"

@implementation ticketCell

- (void)configurateWithModel:(id<ticketModelProtocol>)Model
{
    UIView * goodInfoView = _goodNameLabel.superview;
    if ([Model Type] != TPCellTypeConvert)
    {
        [goodInfoView mas_updateConstraints: ^(MASConstraintMaker *make)
        {
            make.left.equalTo(_perferentialLabel.mas_right).offset(10);
        }];
    }
    else
    {
        [goodInfoView mas_updateConstraints: ^(MASConstraintMaker *make)
        {
            make.left.equalTo(_backgroundImageView.mas_left).offset(18);
        }];
    }
    
    [_userBtn setTitleColor:UIColorHex(@"FD6363") forState: UIControlStateNormal];
    _backgroundImageView.image = [UIImage imageNamed: [Model backgroundImageName]];
    _perferentialLabel.attributedText = [Model perferential];
    _effectConditionLabel.text = [Model effectCondition];
    _goodNameLabel.text = [Model goodName];
    _deadLineLabel.text = [Model deadLine];
    
    [_effectConditionLabel sizeToFit];
    [_goodNameLabel sizeToFit];
    [_deadLineLabel sizeToFit];
}

@end
