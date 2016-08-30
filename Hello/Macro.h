//
//  Macro.h
//  Hello
//
//  Created by 金玉衡 on 16/8/30.
//  Copyright © 2016年 mit. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#pragma mark WeiBo_Request
#define SinaWeiBo_AppKey                @"1522613711" //@"2187371547"
#define SinaWeiBo_AppSecret             @"d3963e403edbc49048f5217eb81a2d26"
#define SinaWeiBo_redirectUri           @"http://www.myapp.com/login/callback"
#define SinaWeiBo_URL_FriendsList       @"https://api.weibo.com/2/friendships/friends.json"
#define SinaWeiBo_URL_FollowsList       @"https://api.weibo.com/2/friendships/followers/active.json"
#define SinaWeiBo_URL_Statuses_public   @"https://api.weibo.com/2/statuses/public_timeline.json"
#define SinaWeiBo_URL_Statuses_friends  @"https://api.weibo.com/2/statuses/friends_timeline.json"
#define SinaWeiBo_URL_Statuses_home     @"https://api.weibo.com/2/statuses/home_timeline.json"
#define SinaWeiBo_URL_User_Show         @"https://api.weibo.com/2/users/show.json"
#define SinaWeiBo_URL_NearBy_UserList  @"https://api.weibo.com/2/place/nearby_users/list.json"
#define SinaWeiBo_URL_NearBy_User       @"https://api.weibo.com/2/place/nearby/users.json"
#define SinaWeiBo_URL                   @"http://weibo.com/"
#define SinaWeiBo_URL_Topic             @"http://m.weibo.cn/k/"
#define SinaWeiBo_URL_Name              @"http://m.weibo.cn/n/"
#define SinaWeiBo_URL_UID              @"http://m.weibo.cn/u/"
#define SinaWeiBo_HomePage_URL          @"http://m.weibo.cn/u/1714904297"
#define HomePage_AvatarImage_URL        @"http://tva3.sinaimg.cn/crop.0.0.180.180.50/66375ce9jw1e8qgp5bmzyj2050050aa8.jpg"
#define HomePage_BackgroundImage_URL    @"http://ww1.sinaimg.cn/crop.0.0.640.640.750/549d0121tw1egm1kjly3jj20hs0hsq4f.jpg"


#pragma mark Font
#define kWBCellNameFont         [UIFont systemFontOfSize:16]    // 名字字体大小
#define kWBCellSourceFont       [UIFont systemFontOfSize:12]    // 来源字体大小
#define kWBCellTextFont         [UIFont systemFontOfSize:17]  // 文本字体大小
#define kWBCellTextFontRetweet  [UIFont systemFontOfSize:16] // 转发字体大小
#define kWBCellCardTitleFont    [UIFont systemFontOfSize:16]    // 卡片标题文本字体大小
#define kWBCellCardDescFont     [UIFont systemFontOfSize:12]   // 卡片描述文本字体大小
#define kWBCellTitlebarFont     [UIFont systemFontOfSize:14]   // 标题栏字体大小
#define kWBCellToolbarFont      [UIFont systemFontOfSize:14]   // 工具栏字体大小
#define UserNickFont            [UIFont systemFontOfSize:16]
#define TitleLabelFont          [UIFont systemFontOfSize:13]
#define TextFont                [UIFont systemFontOfSize:14]
#define LocationLabelFont       [UIFont systemFontOfSize:10]
#define TimeLabelFont           [UIFont systemFontOfSize:12]



#pragma mark Color
#import "UIColor+FlatUI.h"
#define UIColorHex(_hex_)   [UIColor colorFromHexCode:_hex_]
#define kWBCellNameNormalColor UIColorHex(@"333333") // 名字颜色
#define kWBCellNameOrangeColor UIColorHex(@"f26220") // 橙名颜色 (VIP)
#define kWBCellTimeNormalColor UIColorHex(@"828282") // 时间颜色
#define kWBCellTimeOrangeColor UIColorHex(@"f28824") // 橙色时间 (最新刷出)
#define kWBCellTextNormalColor UIColorHex(@"333333") // 一般文本色
#define kWBCellTextSubTitleColor UIColorHex(@"5d5d5d") // 次要文本色
#define kWBCellTextHighlightColor UIColorHex(@"527ead") // Link 文本色
#define kWBCellTextHighlightBackgroundColor UIColorHex(@"bfdffe") // Link 点击背景色
#define kWBCellToolbarTitleColor UIColorHex(@"929292") // 工具栏文本色
#define kWBCellToolbarTitleHighlightColor UIColorHex(@"df422d") // 工具栏文本高亮色
#define kWBCellBackgroundColor UIColorHex(@"f2f2f2")    // Cell背景灰色
#define kWBCellHighlightColor UIColorHex(@"f0f0f0")     // Cell高亮时灰色
#define kWBCellInnerViewColor UIColorHex(@"f7f7f7")   // Cell内部卡片灰色
#define kWBCellInnerViewHighlightColor  UIColorHex(@"f0f0f0") // Cell内部卡片高亮时灰色
#define kWBCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色
#define HighLightTextColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]
#define LocationTextColor  [UIColor colorWithRed:35/255.0 green:83/255.0 blue:120/255.0 alpha:1.0]


#pragma mark ScreenSize
#define  MAX_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define  MAX_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


#pragma mark ImageInfo
#define  ICON_IMAGE_TAG         1000
#define  DETAIL_IMAGE_TAG       2000
#define  RETWEET_IMAGE_TAG      3000
#define  IMAGE_WIDTH            100
#define  IMAGE_HEIGHT           110


#pragma mark Global
#define ARC4RANDOM_MAX          0x100000000
#define ALBBaiChuan_AppKey      @"23412306"
#define ALBBaiChuan_AppSecret   @"60d094448b7362b7f714a916a4f85e4d"

#endif /* Macro_h */
