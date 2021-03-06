//
//  SidebarViewController.m
//  LLBlurSidebar
//
//  Created by Lugede on 14/11/20.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "SidebarViewController.h"

@interface SidebarViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView* menuTableView;

@end

@implementation SidebarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"SlideLeftBackGround"]];
    // 列表
    self.menuTableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.menuTableView.backgroundColor = [UIColor clearColor];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    [self.contentView addSubview:self.menuTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sidebarMenuCellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebarMenuCellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sidebarMenuCellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"菜单%d", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    ViewController *controller = nil;
//    id next = [self nextResponder];
//    while(![next isKindOfClass:[ViewController class]])//这里跳不出来。。。
//    {
//        next = [next nextResponder];
//    }
//    if ([next isKindOfClass:[ViewController class]])
//    {
//        controller = (ViewController *)next;
//    }
//    
//    switch (indexPath.row) {
//        case 0:
//            controller.bgImageView.image = [UIImage imageNamed:@"img0"];
//            break;
//        case 1:
//            controller.bgImageView.image = [UIImage imageNamed:@"img1"];
//            break;
//        case 2:
//            controller.bgImageView.image = [UIImage imageNamed:@"img2"];
//            break;
//        default:
//            break;
//    }
    
//    [self showHideSidebar];
    
}

@end
