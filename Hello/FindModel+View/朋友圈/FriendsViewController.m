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
#import "NSString+Extension.h"
#import "AsynImageView.h"
#import "FriendBaseCell.h"
#import "FriendBaseModel.h"
#import "FriendBaseFrame.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "FriendsInfoViewController.h"


#define TableHeaderHeight 290*([UIScreen mainScreen].bounds.size.width / 375.0)
#define coverheight 240*([UIScreen mainScreen].bounds.size.width / 375.0)

#define AvatarSize  70*([UIScreen mainScreen].bounds.size.width / 375.0)
#define AvatarRightMargin  15
#define AvatarPadding     2

#define NickFont   [UIFont systemFontOfSize:20]
#define SignFont   [UIFont systemFontOfSize:11]


@interface FriendsViewController() <FriendBaseCellDelegate>
{
    NSMutableArray *friendFrameArray;
    NSInteger  next_cursor;
    NSInteger  total_Count;
    BOOL       blFinished;
}

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
        friendFrameArray = [NSMutableArray array];
        
        next_cursor = 0;
        
        blFinished = NO;
        
        [self InitTableView];
        
        [self InitHeader];
        
        [self InitFooter];
        
        [self SendRequst];
    }
    
    return self;
}


-(void)SendRequst
{
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dicRequest = [NSMutableDictionary dictionary];
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"sinaweibo"];
    NSString *userID = [userDic objectForKey:@"userID"];
    [dicRequest setObject:userID  forKey:@"uid"];
    [dicRequest setObject:appDelegate.wbtoken forKey:@"access_token"];
    [dicRequest setObject:@"200" forKey:@"count"];
    [dicRequest setObject:@"0" forKey:@"trim_status"];
    [dicRequest setObject:[NSString stringWithFormat:@"%ld", (long)next_cursor] forKey:@"cursor"];
    
    
    [WBHttpRequest requestWithAccessToken:appDelegate.wbtoken url:SinaWeiBo_URL_FriendsList/*SinaWeiBo_URL_Statuses_friends*/ httpMethod:@"Get" params:dicRequest queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         [self RequestHanlderRefresh:httpRequest :result :error];
     }
     ];
    
}

- (void)RequestHanlderRefresh:(WBHttpRequest *)httpRequest :(id)result : (NSError *)error
{
    if(error)
    {
        NSLog(@"error is %@", error);
        return ;
    }
    
    NSData *jsonData = [result JSONData];
    
    NSDictionary *dicResult = [jsonData objectFromJSONData];
    
    NSArray *userArray = [dicResult objectForKey:@"users"];
    
    next_cursor = [[dicResult objectForKey:@"next_cursor"] integerValue];
    
    total_Count = [[dicResult objectForKey:@"total_number"] integerValue];
    
    if(next_cursor == 0)
    {
        blFinished = YES;
    }

    
    NSMutableArray *newfriendFrameArray = nil;
    
    newfriendFrameArray = [self composeBaseModel:userArray];
    
    //倒序遍历
    NSEnumerator *enumerator;
    enumerator = [newfriendFrameArray reverseObjectEnumerator];
    
    id object;
    while (object = [enumerator nextObject]) {
        [friendFrameArray insertObject:object atIndex:0];
    }
    
    [self.refreshControl endRefreshing];
    
    [_tableView reloadData];
}

/**
 *  userdic
 *  homepage = "http://m.weibo.cn/u/1714904297"
 * avatar_hd = "http://tva3.sinaimg.cn/crop.0.0.180.180.50/66375ce9jw1e8qgp5bmzyj2050050aa8.jpg"
 {
 "allow_all_act_msg" = 0;
 "allow_all_comment" = 1;
 "avatar_hd" = "http://tva3.sinaimg.cn/crop.190.90.614.614.1024/b7cd28b0jw8f1xt0iilt5j20sg0r0gmt.jpg";
 "avatar_large" = "http://tva3.sinaimg.cn/crop.190.90.614.614.180/b7cd28b0jw8f1xt0iilt5j20sg0r0gmt.jpg";
 "bi_followers_count" = 0;
 "block_app" = 0;
 "block_word" = 0;
 city = 1000;
 class = 1;
 "created_at" = "Fri Dec 14 19:31:17 +0800 2012";
 "credit_score" = 80;
 description = "\U4e2d\U56fd\U5965\U8fd0\U8db3\U7403\U961f\U7c89\U4e1d\U4ff1\U4e50\U90e8\U3002";
 domain = "";
 "favourites_count" = 0;
 "follow_me" = 0;
 "followers_count" = 1;
 following = 1;
 "friends_count" = 0;
 gender = m;
 "geo_enabled" = 1;
 id = 3083675824;
 idstr = 3083675824;
 lang = "zh-cn";
 location = "\U5317\U4eac";
 mbrank = 0;
 mbtype = 0;
 name = "\U4e2d\U56fd\U8db3\U7403\U961f\U7c89\U4e1d\U4ff1\U4e50\U90e8";
 "online_status" = 0;
 "pagefriends_count" = 0;
 "profile_image_url" = "http://tva3.sinaimg.cn/crop.190.90.614.614.50/b7cd28b0jw8f1xt0iilt5j20sg0r0gmt.jpg";
 "profile_url" = "u/3083675824";
 province = 11;
 ptype = 0;
 remark = "";
 "screen_name" = "\U4e2d\U56fd\U8db3\U7403\U961f\U7c89\U4e1d\U4ff1\U4e50\U90e8";
 star = 0;
 status =     {
 "attitudes_count" = 0;
 "biz_feature" = 0;
 "comments_count" = 0;
 "created_at" = "Tue May 03 17:17:56 +0800 2016";
 "darwin_tags" =         (
 );
 favorited = 0;
 geo = "<null>";
 "hot_weibo_tags" =         (
 );
 id = 3971098301162429;
 idstr = 3971098301162429;
 "in_reply_to_screen_name" = "";
 "in_reply_to_status_id" = "";
 "in_reply_to_user_id" = "";
 isLongText = 0;
 mid = 3971098301162429;
 mlevel = 0;
 "page_type" = 32;
 "pic_urls" =         (
 );
 "positive_recom_flag" = 0;
 "reposts_count" = 0;
 source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">\U5fae\U535a weibo.com</a>";
 "source_allowclick" = 0;
 "source_type" = 1;
 text = "#\U91cc\U7ea6\U5965\U8fd0#\U00a0\U5c31\U8981\U6765\U4e86\Uff0c\U5965\U8fd0\U4e2d\U56fd\U4e4b\U961f\U7684\U7c89\U4e1d\U4eec\U4f60\U840c\U5728\U54ea\U91cc\Uff1f\U4e2d\U56fd\U8db3\U7403\U961f\U7c89\U4e1d\U4ff1\U4e50\U90e8\U62db\U52df\U4e3b\U9875\U541b\U5566\Uff01\U4f60\U70ed\U7231\U4f53\U80b2\U5417\Uff1f\U60f3\U4e0e\U4e2d\U56fd\U961f\U5171\U540c\U89c1\U8bc1\U8363\U8000\U5417\Uff1f\U5965\U8fd0\U7c89\U4e1d\U4ff1\U4e50\U90e8\U8d26\U53f7\U7b49\U4f60\U6765\U8ba4\U9886\U54e6\U3002\U6709\U610f\U8005\U8bf7\U79c1\U4fe1@\U5fae\U535a\U4f53\U80b2\U00a0\U3002\U6c42\U8f6c\U53d1\Uff0c\U6c42\U8ba4\U9886\U3002";
 textLength = 199;
 "text_tag_tips" =         (
 );
 truncated = 0;
 userType = 0;
 visible =         {
 "list_id" = 0;
 type = 0;
 };
 };
 "statuses_count" = 1;
 urank = 0;
 url = "";
 "user_ability" = 0;
 verified = 1;
 "verified_contact_email" = "";
 "verified_contact_mobile" = "";
 "verified_contact_name" = "";
 "verified_level" = 3;
 "verified_reason" = "\U4e2d\U56fd\U8db3\U7403\U961f\U7c89\U4e1d\U4ff1\U4e50\U90e8";
 "verified_reason_modified" = "";
 "verified_reason_url" = "";
 "verified_source" = "";
 "verified_source_url" = "";
 "verified_state" = 0;
 "verified_trade" = "";
 "verified_type" = 7;
 "verified_type_ext" = 0;
 weihao = "";
 },
 */

-(NSMutableArray *)composeBaseModel:(NSArray *)dataArray
{
    NSMutableArray *arraylist = [[NSMutableArray alloc] initWithCapacity:[dataArray count]];
    
    for (NSDictionary *usersDic in dataArray) {
        
        FriendBaseModel *baseModel = [FriendBaseModel new];
        
        //baseModel.itemID = index++;
        
        //解析dic
        
        [baseModel setItemID:[usersDic objectForKey:@"idstr"]];
        [baseModel setStrAvartUrl:[usersDic objectForKey:@"avatar_hd"]];
        [baseModel setStrNick:[NSString replaceUnicode:[usersDic objectForKey:@"screen_name"]]];
        [baseModel setStrLocation:[NSString replaceUnicode:[usersDic objectForKey:@"location"]]];
        NSDictionary *statusDic = [usersDic objectForKey:@"status"];
        if(statusDic != nil)
        {
            [baseModel setStrContentText:[NSString replaceUnicode:[statusDic objectForKey:@"text"]]];
            NSArray *arrayPic = [statusDic objectForKey:@"pic_urls"];
            if([arrayPic count] > 0)
            {
                NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arrayPic count]];
                for (NSDictionary *picDic in arrayPic)
                {
                    NSMutableString *stringPic = [picDic objectForKey:@"thumbnail_pic"];
                    NSString *strpic = [stringPic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
                    [array addObject:strpic];
                }
                
                baseModel.imageArray = [array mutableCopy];
            }
            else
            {
                baseModel.imageArray = nil;
            }
        }
        else
        {
            [baseModel setStrContentText:[NSString replaceUnicode:[usersDic objectForKey:@"description"]]];
            baseModel.imageArray = nil;
        }
        
        NSMutableString *strTime = [[usersDic objectForKey:@"created_at"] GetTime];
        [baseModel setStrTime:strTime];
        
        
        FriendBaseFrame *baseFrame = [[FriendBaseFrame alloc] init];
        
        [baseFrame setBaseModel:baseModel];
        
        [arraylist addObject:baseFrame];
        
    }
    
    
    
    
    return [arraylist mutableCopy];
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backupItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backup)];
    
    self.navigationItem.leftBarButtonItem = backupItem;
    
    self.navigationItem.title = @"朋友圈";
    
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
        _userNikeLabel.textColor = kWBCellTextNormalColor;
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
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"努力加载中……"];
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
    NSLog(@"onClickUserAvatar");
}

-(void)onPullDown:(id)sender
{
    NSLog(@"onPullDown");
    
    
    if(blFinished == NO)
    {
        [self SendRequst];
    }
    else
    {
        [_refreshControl endRefreshing];
    }
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
    return [friendFrameArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([friendFrameArray count] > 0)
    {
        FriendBaseFrame *baseFrame = [friendFrameArray objectAtIndex:[indexPath row]];
        
        return baseFrame.totalHeight;
    }
    else
    {
        return 80;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellstring = @"FriendCell";
    
    FriendBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstring];
    if(cell == nil)
    {
        cell = [[FriendBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstring];
        
    }
    
    cell.userInteractionEnabled = YES;
    cell.separatorInset = UIEdgeInsetsZero;
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    [cell setBaseCellFrame:[friendFrameArray objectAtIndex:[indexPath row]]];
    
    cell.delegate = self;
    
    return cell;
}

/**
 *  friendbasecell delegate
 */

-(void)onClickUserItem:(NSString *)userIDStr
{
    NSLog(@"onclickUser url is %@", userIDStr);
    
    NSURL *url = [NSURL URLWithString:userIDStr];
    
    FriendsInfoViewController *friendInfoVC = [[FriendsInfoViewController alloc] initWithURL:url];
    [self.navigationController pushViewController:friendInfoVC animated:YES];
    
}

@end
