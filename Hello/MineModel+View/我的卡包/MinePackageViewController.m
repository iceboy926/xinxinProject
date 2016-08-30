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

@property (nonatomic, strong) NSMutableArray<id<TicketModelProtocol>> *couponTickets;
@property (nonatomic, strong) NSMutableArray<id<TicketModelProtocol>> *discountTickets;
@property (nonatomic, strong) NSMutableArray<id<TicketModelProtocol>> *convertTickets;

@end

@implementation MinePackageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.view.backgroundColor = kWBCellInnerViewColor;
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"coupon_overdue"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    
    _couponTickets = [NSMutableArray array];
    
    _currentModelSet = [NSMutableArray array];
    
    [self requestTickets];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *KMCTicketCommonCellIdentifier = @"ticketCell";
    
    TicketCell * cell = [tableView dequeueReusableCellWithIdentifier: KMCTicketCommonCellIdentifier];
    if(cell == nil)
    {
        cell = [[TicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KMCTicketCommonCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([cell conformsToProtocol: @protocol(TicketCellProtocol)])
    {
        [(id<TicketCellProtocol>)cell configurateWithModel:[self modelWithIndexPath:indexPath]];
    }
    
    return cell;
}



/**
 *  datasource
 */

#pragma mark - Data Generator
- (id<TicketModelProtocol>)modelWithIndexPath: (NSIndexPath *)indexPath
{
    return self.currentModelSet[indexPath.row];
}

- (NSMutableArray< id<TicketModelProtocol> > *)currentModelSet
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


- (void)requestTickets
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"MyPackage" ofType:@"geojson"];
    
    NSString *data = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *dataDic = [data objectFromJSONString];
    
    NSArray *array = [dataDic objectForKey:@"package"];
    
    for (NSDictionary *dic in array) {
        TicketModel *model = [[TicketModel alloc] initWithDict:dic];
        [_couponTickets addObject:model];
    }
    
    _ticketType = TPCellTypeCoupon;

    
    [_currentModelSet addObjectsFromArray:_couponTickets];

}


@end
