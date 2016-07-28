//
//  MinePackageViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/7/28.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "MinePackageViewController.h"


@interface MinePackageViewController()
{
    TPCellType _ticketType;
}

@property (nonatomic, strong) NSMutableArray<id<ticketModelProtocol>> *couponTickets;
@property (nonatomic, strong) NSMutableArray<id<ticketModelProtocol>> *discountTickets;
@property (nonatomic, strong) NSMutableArray<id<ticketModelProtocol>> *convertTickets;

@end

@implementation MinePackageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideToolBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideToolBar:NO];
}

- (void)hideToolBar:(BOOL)blHide
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blHide];
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentModelSet count];
}


- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *KMCTicketCommonCellIdentifier = @"ticketCell";
    
    ticketCell * cell = [tableView dequeueReusableCellWithIdentifier: KMCTicketCommonCellIdentifier];
    if(cell == nil)
    {
        cell = [[ticketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KMCTicketCommonCellIdentifier];
    }
    
    if ([cell conformsToProtocol: @protocol(ticketCellProtocol)])
    {
        [(id<ticketCellProtocol>)cell configurateWithModel:[self modelWithIndexPath:indexPath]];
    }
    
    return cell;
}



/**
 *  datasource
 */

#pragma mark - Data Generator
- (id<ticketModelProtocol>)modelWithIndexPath: (NSIndexPath *)indexPath
{
    return self.currentModelSet[indexPath.row];
}

- (NSMutableArray< id<ticketModelProtocol> > *)currentModelSet
{
    switch (_ticketType) {
        case TPCellTypeCoupon:
            return _couponTickets;
            
        case TPCellTypeDiscount:
            return _discountTickets;
            
        case TPCellTypeConvert:
            return _convertTickets;
    }
}


@end
