//
//  ticketCell.h
//  Hello
//
//  Created by 金玉衡 on 16/7/28.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ticketModelProtocol;

@protocol ticketCellProtocol <NSObject>

-(void)configurateWithModel:(id<ticketModelProtocol>)Model;

@end

@interface ticketCell : UITableViewCell <ticketCellProtocol>

@property (nonatomic, strong)UIImageView *backgroundImageView;
@property (nonatomic, strong)UILabel    *goodNameLabel;
@property (nonatomic, strong)UILabel    *effectConditionLabel;
@property (nonatomic, strong)UILabel    *deadLineLabel;
@property (nonatomic, strong)UILabel    *perferentialLabel;
@property (nonatomic, strong)UIButton   *userBtn;


@end
