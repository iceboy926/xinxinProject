//
//  HomePageViewController.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "HomePageViewController.h"
#import "TableViewCell.h"
#import "HomeCellModel.h"
#import "HomeCellFrame.h"
#import "Reachability.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "FCXRefreshHeaderView.h"
#import "FCXRefreshFooterView.h"
#import "UIScrollView+FCXRefresh.h"
#import "NSString+Extension.h"
#import "HomeDetailViewController.h"
#import "ZoomImage.h"
#import "JSHpple.h"
#import "AsynImageView.h"
#import "CellToolBarView.h"
#import "CellToolBarModel.h"
#import "HomeCoreDataManager.h"

#define HomeRequst_Key   @"home_request"

@interface HomePageViewController () <UITableViewDelegate, UITableViewDataSource, WBHttpRequestDelegate, TableViewDelegate>
{
    FCXRefreshHeaderView *headerView;
    FCXRefreshFooterView *footerView;
    NSInteger totalRow;
    HomeCoreDataManager *homeCoreManange;
}

@end

@implementation HomePageViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    
    self.CellList = [[NSMutableArray alloc] init];
    
    self.StatuseList = [[NSMutableArray alloc] init];
    
    self.ToolBarList = [[NSMutableArray alloc] init];
    
    self.navigationItem.title = @"南宫勇少";
    
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    if ([self respondsToSelector:@selector( setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    homeCoreManange = [[HomeCoreDataManager alloc] init];
    
    if([self NeedRequst])
    {
        [self DeleteDB];
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        _dicRequestPara = [NSMutableDictionary dictionary];
        if(appDelegate.wbtoken != nil)
        {
            [_dicRequestPara setObject:appDelegate.wbtoken forKey:@"access_token"];
            
            [self addRefreshView];
        }
    }
    else
    {
        [self ComposeCellFrame];
        [self.tableView reloadData];
    }
    
    self.view.backgroundColor = kWBCellBackgroundColor;
    
}

-(void)addRefreshView
{
    
    __block HomePageViewController *blockself = self;
    
    headerView = [self.tableView addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView)
                  {
                      [blockself refreshAction];
                  }];
    
    footerView = [self.tableView addFooterWithRefreshHandler:^(FCXRefreshBaseView *refreshView)
    {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [blockself.dicRequestPara setObject:appDelegate.wbtoken forKey:@"access_token"];
        //[weakSelf.dicRequestPara setObject:@"100" forKey:@"count"];
        if([blockself.StatuseList count] >1)
        {
            NSNumber *longid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Next"];//[[weakSelf.StatuseList lastObject] objectForKey:@"idstr"];
            if([longid longValue] == 0)
            {
                [blockself->footerView showNoMoreData];
                [blockself->footerView endRefresh];
                
                return ;
            }
            [blockself.dicRequestPara setObject:[longid stringValue] forKey:@"max_id"];
        }
        
        [blockself SendRequst];
                      
    }];
    
    footerView.autoLoadMore = YES;
}

- (void)refreshAction {
    //__weak UITableView *weakTableView = self.tableView;
    //__weak FCXRefreshHeaderView *weakHeaderView = headerView;
    __weak __typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [weakSelf.dicRequestPara setObject:appDelegate.wbtoken forKey:@"access_token"];
        [weakSelf.dicRequestPara setObject:@"100" forKey:@"count"];
        if([weakSelf.StatuseList count] >1)
        {
            NSString *strid = [[weakSelf.StatuseList firstObject] objectForKey:@"idstr"];
            
            if([strid longLongValue] == 0)
            {
                [headerView endRefresh];
                return ;
            }
            [weakSelf.dicRequestPara setObject:strid forKey:@"since_id"];
        }
        
        [weakSelf SendRequst];

    });
}


- (BOOL)NeedRequst
{
    BOOL blRequest = YES;
    
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    
    NSString *updateTimeStr = [defaultUser objectForKey:HomeRequst_Key];
    
    if(updateTimeStr)
    {
        NSTimeInterval  updateTime = updateTimeStr.doubleValue;
        NSTimeInterval  nowTime = [NSDate timeIntervalSinceReferenceDate];
        if((nowTime - updateTime) > 1*60*60)//大于2个小时
        {
            blRequest = YES;
        }
        else
        {
            blRequest = NO;
        }
    }
    else
    {
        blRequest = YES;
    }
    
    
    return blRequest;
}

- (void)WriteToDB:(NSMutableArray *)arrayData
{
    [homeCoreManange writeCoreDataToDB:arrayData];
    
    NSString *currentTimeStr = [NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]];
    
    [[NSUserDefaults standardUserDefaults] setObject:currentTimeStr forKey:HomeRequst_Key];
}

- (NSMutableArray *)ReadFromDB
{
    return [homeCoreManange readCoreDataFromDB];
}

- (void)DeleteDB
{
    [homeCoreManange deleteCoreDataFromDB];
}

- (void)ComposeCellFrame
{
    NSMutableArray *cellModelArray = [self ReadFromDB];
    for (HomeCellModel *cellUser in cellModelArray) {
        HomeCellFrame *cellFrame = [[HomeCellFrame alloc] init];
        [cellFrame setHomeCell:cellUser];
        
        [self.CellList addObject:cellFrame];
    
        
        
        CellToolBarModel *cellToolBar = [[CellToolBarModel alloc] init];
        
        
        if(cellUser.repostCount == 0)
        {
            [cellToolBar setRepostStr:[NSString stringWithFormat:@"转发"]];
        }
        else
        {
            [cellToolBar setRepostStr:[NSString stringWithFormat:@"%d", cellUser.repostCount]];
        }
        
        if(cellUser.commentCount == 0)
        {
            [cellToolBar setCommentStr:[NSString stringWithFormat:@"评论"]];
        }
        else
        {
            [cellToolBar setCommentStr:[NSString stringWithFormat:@"%d", cellUser.commentCount]];
        }
        
        if(cellUser.atitudesCount == 0)
        {
            [cellToolBar setLikeStr:[NSString stringWithFormat:@"赞"]];
        }
        else
        {
            [cellToolBar setLikeStr:[NSString stringWithFormat:@"%d", cellUser.atitudesCount]];
        }
        
        [self.ToolBarList addObject:cellToolBar];
    }
 }


-(void)SendRequst
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    
    [WBHttpRequest requestWithAccessToken:appDelegate.wbtoken url:SinaWeiBo_URL_Statuses_home httpMethod:@"Get" params:_dicRequestPara queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         [self RequestHanlderRefresh:httpRequest :result :error];
     }
     ];

}

- (void)RequestHanlderRefresh:(WBHttpRequest *)httpRequest :(id)result : (NSError *)error
{
    if(error)
    {
        NSLog(@" requestWithAccessToken error code is %@",error);
        return ;
    }
    
    
    NSData *jsonData = [result JSONData];
    
    
    NSDictionary *dicResult = [jsonData objectFromJSONData];
    
    NSArray *tempArray = [dicResult objectForKey:@"statuses"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[dicResult objectForKey:@"next_cursor"] forKey:@"Next"];
    
    NSMutableArray *arrayData = [NSMutableArray array];
    
    
    for (NSDictionary *Statuses in tempArray)
    {
        HomeCellModel *cellUser = [[HomeCellModel alloc] init];
        NSDictionary *UserDic = [Statuses objectForKey:@"user"];
        [cellUser setName:[NSString replaceUnicode:[UserDic objectForKey:@"screen_name"]]];
        [cellUser setIcon:[UserDic objectForKey:@"avatar_hd"]];
            
        NSString *stringTime = [Statuses objectForKey:@"created_at"];
        NSMutableString *strsource = [self GetTime:stringTime];
        
        NSMutableString *arrysource = [self GetSource:[Statuses objectForKey:@"source"]];
        [strsource appendFormat:@"     %@",arrysource];
        [cellUser setTimesource:strsource];
            
        cellUser.blVip = [[UserDic valueForKey:@"verified"] boolValue];
        
        NSString *strDetail = [Statuses objectForKey:@"text"];
                
        [cellUser setDetail:[NSString replaceUnicode:strDetail]];
                
        NSArray *arrayPic = [Statuses objectForKey:@"pic_urls"];
        if([arrayPic count] > 0)
        {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arrayPic count]];
            for (NSDictionary *picDic in arrayPic)
            {
                NSMutableString *stringPic = [picDic objectForKey:@"thumbnail_pic"];
                //NSString *strout = [stringPic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
                [array addObject:stringPic];
            }
                    
            cellUser.pictureArray = [array mutableCopy];
        }
        
        NSDictionary *retweetDic = [Statuses objectForKey:@"retweeted_status"];
        if(retweetDic != nil) //有转发
        {
            NSString *strRetweetDetail = [retweetDic objectForKey:@"text"];
            [cellUser setRetweetDetail:[NSString replaceUnicode:strRetweetDetail]];
            
            NSArray *arryRetweetPic = [retweetDic objectForKey:@"pic_urls"];
            if([arryRetweetPic count] > 0)
            {
                NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arryRetweetPic count]];
                for (NSDictionary *picDic in arryRetweetPic) {
                    
                    NSMutableString *stringPic = [picDic objectForKey:@"thumbnail_pic"];
                    //NSString *strout = [stringPic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
                    [array addObject:stringPic];
                }
                
                cellUser.retweetPictureArray = [array mutableCopy];
            }
            
            cellUser.blretweet = YES;
        }
        else
        {
            cellUser.blretweet = NO;
        }
        
        int repostCount = [[Statuses valueForKey:@"reposts_count"] intValue];
        int commentCount = [[Statuses valueForKey:@"comments_count"] intValue];
        int likeCount = [[Statuses valueForKey:@"attitudes_count"] intValue];
        
        cellUser.repostCount = repostCount;
        cellUser.commentCount = commentCount;
        cellUser.atitudesCount = likeCount;
        
        
        HomeCellFrame *cellFrame = [[HomeCellFrame alloc] init];
        [cellFrame setHomeCell:cellUser];
        
        [self.CellList addObject:cellFrame];
        
        [self.StatuseList addObject:Statuses];
        
        
        CellToolBarModel *cellToolBar = [[CellToolBarModel alloc] init];
        
      
        
        if(repostCount == 0)
        {
            [cellToolBar setRepostStr:[NSString stringWithFormat:@"转发"]];
        }
        else
        {
            [cellToolBar setRepostStr:[NSString stringWithFormat:@"%d", repostCount]];
        }
        
        if(commentCount == 0)
        {
            [cellToolBar setCommentStr:[NSString stringWithFormat:@"评论"]];
        }
        else
        {
            [cellToolBar setCommentStr:[NSString stringWithFormat:@"%d", commentCount]];
        }
        
        if(likeCount == 0)
        {
            [cellToolBar setLikeStr:[NSString stringWithFormat:@"赞"]];
        }
        else
        {
            [cellToolBar setLikeStr:[NSString stringWithFormat:@"%d", likeCount]];
        }

        [self.ToolBarList addObject:cellToolBar];
        
        [arrayData addObject:cellUser];

    }
    
    //[self WriteToDB:arrayData];
    
    
    [self.tableView reloadData];
    [footerView endRefresh];
    [headerView endRefresh];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, 10)];
    view.backgroundColor = kWBCellInnerViewColor;
    
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section   // custom view for footer. will be adjusted to default or specified footer height
{
    CellToolBarView *toolBar=[[CellToolBarView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, 25)];
    toolBar.backgroundColor = [UIColor whiteColor];
    
    if([self.ToolBarList count] > 0)
    {
        CellToolBarModel *toolBarModel = [self.ToolBarList objectAtIndex:section];
    
        [toolBar setData:toolBarModel];
    }
    
    return toolBar;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.CellList count] >0)
    {
        HomeCellFrame *cellFrame = [self.CellList objectAtIndex:[indexPath section]];
    
        CGFloat height = cellFrame.cellHeight;
    
        return height;
    }
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.CellList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIndentif = @"HomeCell";
    
    TableViewCell *homecellView = [tableView dequeueReusableCellWithIdentifier:tableCellIndentif];
    
    if(homecellView == nil)
    {
        homecellView = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIndentif];
    }
    
    /**
     *  边框线从顶端开始
     *
     *  @param setSeparatorInset:
     *
     *  @return
     */
    if([homecellView respondsToSelector:@selector(setSeparatorInset:)])
    {
        homecellView.separatorInset = UIEdgeInsetsZero;
    }
    
    if([homecellView respondsToSelector:@selector(setLayoutMargins:)])
    {
        homecellView.layoutMargins = UIEdgeInsetsZero;
    }
    
    
    NSInteger i = [indexPath section];
    
    homecellView.Index = i;
    
    homecellView.delegate = self;
    //homecellView.selectionStyle = UITableViewCellSelectionStyleNone;
    //homecellView.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
  
    HomeCellFrame *CellFrame = [self.CellList objectAtIndex:i];
    
    
    [homecellView setCellFrame:CellFrame];
    
    
    return homecellView;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


-(NSMutableString*)GetTime:(NSString *)strCreate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *datastr = [NSString dateFromString:strCreate];
    
    NSString *str = [dateFormatter stringFromDate:datastr];
    
    
    NSMutableString *strDate = [[NSMutableString alloc] initWithString:str];
    
    
    return strDate;
}

-(NSMutableString *)GetSource:(NSString *)strSource
{
    
    NSArray *array = [strSource componentsSeparatedByString:@">"];
    
    if([array count] < 2)
    {
        return nil;
    }
    NSString *str = [array objectAtIndex:1];
    
    
    NSMutableString *arrout = [NSMutableString stringWithString:[str substringToIndex:(str.length - 3)]];
    
    return arrout;
}


#pragma mark - table View cell delegate

-(void)DidPushWebView:(NSURL *)Url Index:(NSInteger)UserIndex viewTitle:(NSString *)title
{
    
    HomeDetailViewController *HomeDetail = [[HomeDetailViewController alloc] initWithNibName:@"HomeDetailViewController" bundle:nil];
    
    [HomeDetail setHttpUrl:Url];
    
    [HomeDetail setTitleName:title];
    
    [self.navigationController pushViewController:HomeDetail animated:YES];
}

-(void)DidPushLinkUserNameView:(NSString *)UserName
{
    HomeDetailViewController *HomeDetail = [[HomeDetailViewController alloc] initWithNibName:@"HomeDetailViewController" bundle:nil];
    
    if([UserName hasPrefix:@"@"])
    {
        HomeDetail.titleName = [UserName stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        NSString *url = [SinaWeiBo_URL_Name stringByAppendingString:[HomeDetail.titleName URLEncodeString]];
        
        HomeDetail.httpUrl = [NSURL URLWithString:url];
        
        [self.navigationController pushViewController:HomeDetail animated:YES];
    }
    else if([UserName hasPrefix:@"#"] && [UserName hasSuffix:@"#"])
    {
        HomeDetail.titleName = [UserName stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        NSString *url = [SinaWeiBo_URL_Topic stringByAppendingString:[HomeDetail.titleName URLEncodeString]];
        
        HomeDetail.httpUrl = [NSURL URLWithString:url];
        
        [self.navigationController pushViewController:HomeDetail animated:YES];
    }

}
    

-(void)DidTouchNamelabel:(NSString *)Screenname
{
    NSLog(@"did tounamelabel");
    
    HomeDetailViewController *HomeDetail = [[HomeDetailViewController alloc] initWithNibName:@"HomeDetailViewController" bundle:nil];
    
    HomeDetail.titleName = [Screenname copy];
    
    NSString *url = [SinaWeiBo_URL_Name stringByAppendingString:[HomeDetail.titleName URLEncodeString]];
    
    HomeDetail.httpUrl = [NSURL URLWithString:url];
    
    [self.navigationController pushViewController:HomeDetail animated:YES];
}

-(void)DidTouchUserIcon:(UIImageView *)UserIcon Index:(NSInteger)UseIndex
{
    [ZoomImage ShowZoomWithImageView:UserIcon];
}

-(void)DidTouchPicAsyView:(AsynImageView *)asyImageView
{
    NSString *strimageUrl = asyImageView.imageURL;
    
    NSRange range = [strimageUrl rangeOfString:@"thumbnail"];
    
    
    if(range.length > 0)
    {
        [ZoomImage ShowZoomWithImageURL:[strimageUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"]];
    }
    
}


@end
