//
//  FriendsViewController.m
//  Hello
//
//  Created by KingYH on 16/3/28.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "FriendsViewController.h"
#import "MLLabel.h"
#import "MLLabel+Size.h"
#import "AsynImageView.h"
#import "FriendBaseCell.h"


#define TableHeaderHeight 290*([UIScreen mainScreen].bounds.size.width / 375.0)
#define coverheight 240*([UIScreen mainScreen].bounds.size.width / 375.0)

#define AvatarSize  70*([UIScreen mainScreen].bounds.size.width / 375.0)
#define AvatarRightMargin  15
#define AvatarPadding     2

#define NickFont   [UIFont systemFontOfSize:20]
#define SignFont   [UIFont systemFontOfSize:11]


@interface FriendsViewController()

@property (nonatomic, strong) AsynImageView *coverImage;

@property (nonatomic, strong) AsynImageView *userAvatarImage;

@property (nonatomic, strong) MLLabel *userNikeLabel;

@property (nonatomic, strong) MLLabel *userSignTextLabel;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign) BOOL isLoadingMore;


@end

@implementation FriendsViewController


-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backupItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backup)];
    
    self.navigationItem.leftBarButtonItem = backupItem;
    
    self.navigationItem.title = @"朋友圈";
    
    [self InitTableView];
    
    [self InitHeader];
    
    [self InitFooter];
}

-(void)InitTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
        _tableView.separatorInset = UIEdgeInsetsZero;
    
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
        _tableView.layoutMargins = UIEdgeInsetsZero;
    
    [self.view addSubview:_tableView];
    
}

-(void)InitHeader
{
    CGFloat x,y,width,height;
    
    x = 0;
    y = 0;
    width = self.view.frame.size.width;
    height = TableHeaderHeight;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    headView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = headView;
    
    
    //cover
    height = coverheight;
    _coverImage = [[AsynImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    _coverImage.backgroundColor = [UIColor darkGrayColor];
    
    self.coverWidth = width*2;
    self.coverHeight = height*2;
    [headView addSubview:_coverImage];
    
    
    //user btn
    x = self.view.frame.size.width - AvatarSize - AvatarRightMargin;
    y = headView.frame.size.height - AvatarSize - 20;
    width = AvatarSize;
    height = width;
    UIButton *avartbtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    avartbtn.backgroundColor = [UIColor whiteColor];
    avartbtn.layer.borderWidth = 0.5;
    avartbtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [avartbtn addTarget:self action:@selector(onClickUserAvatar:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:avartbtn];
    
   
    //user image
    x = AvatarPadding;
    y = x;
    width = CGRectGetWidth(avartbtn.frame) - AvatarPadding*2;
    height = width;
    _userAvatarImage = [[AsynImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [avartbtn addSubview:_userAvatarImage];
    self.userAvartSize = width*2;
    
    
    if(_userNikeLabel == nil)
    {
        _userNikeLabel = [[MLLabel alloc] initWithFrame:CGRectZero];
        _userNikeLabel.textColor = [UIColor whiteColor];
        _userNikeLabel.font = NickFont;
        _userNikeLabel.numberOfLines = 1;
        _userNikeLabel.adjustsFontSizeToFitWidth = NO;
        [headView addSubview:_userNikeLabel];
    }
    
    if(_userSignTextLabel == nil)
    {
        _userSignTextLabel = [[MLLabel alloc] initWithFrame:CGRectZero];
        _userSignTextLabel.font = SignFont;
        _userSignTextLabel.numberOfLines = 1;
        _userSignTextLabel.adjustsFontSizeToFitWidth = NO;
        [headView addSubview:_userSignTextLabel];
    }
    
    if(_refreshControl == nil)
    {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(onPullDown:) forControlEvents:UIControlEventValueChanged];
        
        [_tableView addSubview:_refreshControl];
    }
    
}

-(void)InitFooter
{
    CGFloat x,y,width,height;
    x = 0;
    y = 0;
    width = self.view.frame.size.width;
    height = 0.1;
    
    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    _footerView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = _footerView;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    indicator.center = CGPointMake(width/2.0, 30);
    indicator.hidden = YES;
    [indicator startAnimating];
    
    [_footerView addSubview:indicator];
    
}

/**
 *  设置封面
 *
 *  @param strUrlCover
 */
-(void)setCover:(NSString *)strUrlCover
{
    [_coverImage showImage:strUrlCover];
}


/**
 *  设置用户头像
 *
 *  @param strUrlAvart
 */
-(void)setUserAvart:(NSString *)strUrlAvart
{
    [_userAvatarImage showImage:strUrlAvart];
}



-(void)setUserNick:(NSString *)nick
{
    CGFloat x, y, width, height;
    
    CGSize size = [MLLabel getViewSizeByString:nick font:NickFont];
    
    width = size.width;
    height = size.height;
    
    x = CGRectGetMinX(_userAvatarImage.superview.frame) - width - 5;
    y = CGRectGetMidY(_userAvatarImage.superview.frame) - height - 2;
   
    _userNikeLabel.frame = CGRectMake(x, y, width, height);
    _userNikeLabel.text = nick;
    
}

-(void)setUserSign:(NSString *)sign
{
    CGFloat x, y, width, height;
    
    CGSize size = [MLLabel getViewSizeByString:sign font:SignFont];
    
    width = size.width;
    height = size.height;
    
    x = CGRectGetWidth(self.view.frame) - width - 15;
    y = CGRectGetMaxY(_userAvatarImage.superview.frame) + 5;
    
    _userSignTextLabel.frame = CGRectMake(x, y, width, height);
    _userSignTextLabel.text = sign;
    
    
}


-(void)onClickUserAvatar:(id)sender
{
    
}

-(void)onPullDown:(id)sender
{
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self HideToolBar:YES];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideToolBar:NO];
}


-(void)HideToolBar:(BOOL) blHide
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blHide];
            break;
        }
    }
    
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


-(void)backup
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - TabelViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellstring = @"FriendCell";
    
    FriendBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstring];
    if(cell == nil)
    {
        cell = [[FriendBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstring];
        
    }
    
    cell.separatorInset = UIEdgeInsetsZero;
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
