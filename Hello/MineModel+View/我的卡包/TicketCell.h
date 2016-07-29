//
//  ticketCell.h
//  Hello
//
//  Created by 金玉衡 on 16/7/28.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TicketModelProtocol;

@protocol TicketCellProtocol <NSObject>

-(void)configurateWithModel:(id<TicketModelProtocol>)Model;

@end

@interface TicketCell : UITableViewCell <TicketCellProtocol>

@property (nonatomic, strong)UIImageView *backgroundImageView;
@property (nonatomic, strong)UILabel    *goodNameLabel;
@property (nonatomic, strong)UILabel    *effectConditionLabel;
@property (nonatomic, strong)UILabel    *deadLineLabel;
@property (nonatomic, strong)UILabel    *perferentialLabel;
@property (nonatomic, strong)UIButton   *userBtn;
@property (nonatomic, strong)UIView     *marginTopView;


@end
