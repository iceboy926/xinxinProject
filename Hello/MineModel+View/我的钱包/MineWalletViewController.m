//
//  MineWalletViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/7/26.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "MineWalletViewController.h"
#import "CustomGrid.h"

@interface MineWalletViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CustomGridDelegate>
{
    int _lastPosition;
    CGFloat _tableViewOffset;
    int sectionIICount;
}

@property (nonatomic, strong) UIButton *leftIconBtn;
@property (nonatomic, strong) UIButton *rightIconBtn;
@property (nonatomic, strong) NSMutableArray *titleList, *iconList;

@end

@implementation MineWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"我" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    [self initDataSource];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CGRect navRect = self.navigationController.navigationBar.frame;
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    
    _tableViewOffset = .0 - navRect.size.height - statusRect.size.height;
    
    sectionIICount = 12;
    
}

- (void)back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)InitUIWithView:(UIView *)SuperView
{
    NSString *leftIconStr = @"ap_home_top_icon_pay_new";
    NSString *leftIconHightStr = [NSString stringWithFormat:@"%@_highlight", leftIconStr];

    _leftIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftIconBtn setImage:[UIImage imageNamed:leftIconStr] forState:UIControlStateNormal];
    [_leftIconBtn setImage:[UIImage imageNamed:leftIconHightStr] forState:UIControlStateHighlighted];
    [SuperView addSubview:_leftIconBtn];

    NSString *rightIconStr = @"ap_home_top_icon_scan_new";
    NSString *rightIconHightStr = [NSString stringWithFormat:@"%@_highlight", rightIconStr];

    _rightIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightIconBtn setImage:[UIImage imageNamed:rightIconStr] forState:UIControlStateNormal];
    [_rightIconBtn setImage:[UIImage imageNamed:rightIconHightStr] forState:UIControlStateHighlighted];
    [SuperView addSubview:_rightIconBtn];


    [_leftIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(SuperView.mas_top);
        make.left.mas_equalTo(SuperView.mas_left);
        make.width.mas_equalTo(_rightIconBtn);
        make.height.mas_equalTo(SuperView.mas_height);
    }];

    [_rightIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(_leftIconBtn.mas_top);
        make.left.mas_equalTo(_leftIconBtn.mas_right);
        make.right.mas_equalTo(SuperView.mas_right);
        make.height.mas_equalTo(_leftIconBtn.mas_height);
    }];

}


- (void)initDataSource
{
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"AlipayHomeIcons" ofType:@"plist"];
    
    NSArray *dataListArray = [NSArray arrayWithContentsOfFile:strPath];
    
    self.titleList = [[NSMutableArray alloc] init];
    self.iconList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dataDic in dataListArray) {
        
        NSString *strkey = [[dataDic allKeys] objectAtIndex:0];
        
        [self.titleList addObject:strkey];
        [self.iconList addObject:[dataDic objectForKey:strkey]];
    }
    
    //[self.tableView reloadData];
}

- (void)InitCellUIWithView:(UIView *)SuperView
{
    int row = 4;
    int column = 3;
    CGFloat gridWidth =  (MAX_WIDTH)/row;
    CGFloat gridHeight = 82;
    
    for (int i = 0;  i < sectionIICount; i++) {
        CGFloat x = 0.0, y = 0.0, width = 0.0, height = 0.0;
        
        x = gridWidth*(i%row);
        y = gridHeight*(i/row);
        width = gridWidth;
        height = gridHeight;
        
        CGRect gridRect = CGRectMake(x, y, width, height);
        NSString *strTitle = [self.titleList objectAtIndex:i];
        NSString *strIcon = [self.iconList objectAtIndex:i];
        NSString *strNormalImage = @"app_item_bg.png";
        NSString *strHightlightImage = @"app_item_pressed_bg.png";
        
        CustomGrid *grid = [[CustomGrid alloc] initWithFrame:gridRect Title:strTitle Icon:strIcon NormalImage:strNormalImage HighlightImage:strHightlightImage GridID:i Delegate:self];
        
        [SuperView addSubview:grid];
    }
}

- (void)InitSectionIIIWithView:(UIView *)SuperView
{
    int row = 4;
    CGFloat gridWidth =  (MAX_WIDTH)/row;
    CGFloat gridHeight = 83;
  
    
    for (int i = sectionIICount;  i < [self.titleList count]; i++) {
        CGFloat x = 0.0, y = 0.0, width = 0.0, height = 0.0;
        int offsetCount = i - sectionIICount;
        x = gridWidth*(offsetCount%row);
        y = gridHeight*(offsetCount/row);
        width = gridWidth;
        height = gridHeight;
        
        CGRect gridRect = CGRectMake(x, y, width, height);
        NSString *strTitle = [self.titleList objectAtIndex:i];
        NSString *strIcon = [self.iconList objectAtIndex:i];
        NSString *strNormalImage = @"app_item_bg.png";
        NSString *strHightlightImage = @"app_item_pressed_bg.png";
        
        CustomGrid *grid = [[CustomGrid alloc] initWithFrame:gridRect Title:strTitle Icon:strIcon NormalImage:strNormalImage HighlightImage:strHightlightImage GridID:i Delegate:self];
        
        [SuperView addSubview:grid];
    }
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

/**
 *
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0.5;
    }
    else
    {
        return 20;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *strTitle = nil;
    if(section == 1)
    {
        strTitle = @"有料服务";
    }
    else if(section == 2)
    {
        strTitle = @"第三方服务";
    }
    return strTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, 0)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    else
    {
        return nil;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    else if(section == 1)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 0)
    {
        return 104.;
    }
    else if([indexPath section] == 1)
    {
        return 3*83.;
    }
    else
    {
        return 2*83.;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"walletCell";
     UITableViewCell   *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch ([indexPath section]) {
        case 0:
        {
            [self InitUIWithView:cell.contentView];
        }
            break;
        case 1:
        {
            [self InitCellUIWithView:cell.contentView];
        }
            
            break;
        case 2:
        {
            [self InitSectionIIIWithView:cell.contentView];
        }
            break;
        default:
            break;
    }
    
    
    return cell;
}



/**
 *  customGridDelegate
 *
 *  @param item <#item description#>
 */

- (void)gridItemDidClicked:(CustomGrid *)item
{
    NSLog(@"gridItem clicked is %d", item.gridID);
}

/**
 *  scrollview delegate
 */

//scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidScroll");
    CGPoint point=scrollView.contentOffset;
    NSLog(@"%f,%f",point.x,point.y);
    
    int currentPostion = scrollView.contentOffset.y;

    if(currentPostion < _tableViewOffset)
    {
        self.tableView.contentOffset = CGPointMake(0, _tableViewOffset);
    }
}

// 当scrollView缩放时，调用该方法。在缩放过程中，回多次调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidScroll");
    float value=scrollView.zoomScale;
    NSLog(@"%f",value);
    
    
}

// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewWillBeginDragging");
    
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    NSLog(@"scrollViewWillEndDragging");
    
}

// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    NSLog(@"scrollViewDidEndDragging");
    if (decelerate) {
        NSLog(@"decelerate");
    }else{
        NSLog(@"no decelerate");
        
    }
    
    CGPoint point=scrollView.contentOffset;
    NSLog(@"%f,%f",point.x,point.y);
    
}

// 滑动减速时调用该方法。
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewWillBeginDecelerating");
    // 该方法在scrollViewDidEndDragging方法之后。
    
    
}


// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidEndScrollingAnimation");
    // 有效的动画方法为：
    //    - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated 方法
    //    - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated 方法
    
    
}


// 当将要开始缩放时，执行该方法。一次有效缩放，就只执行一次。
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
    NSLog(@"scrollViewWillBeginZooming");
    
}

// 当缩放结束后，并且缩放大小回到minimumZoomScale与maximumZoomScale之间后（我们也许会超出缩放范围），调用该方法。
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    
    NSLog(@"scrollViewDidEndZooming");
    
}

// 指示当用户点击状态栏后，滚动视图是否能够滚动到顶部。需要设置滚动视图的属性：_scrollView.scrollsToTop=YES;
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    
    return YES;
    
    
}

// 当滚动视图滚动到最顶端后，执行该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidScrollToTop");
}



@end
