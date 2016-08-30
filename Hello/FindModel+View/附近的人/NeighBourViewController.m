//
//  NeighBourViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/8/5.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "NeighBourViewController.h"
//#import "RadarView.h"
#import "XHRadarView.h"
#import "PersonViewModel.h"
#import "NearbyPersonModel.h"

@interface NeighBourViewController() <XHRadarViewDataSource, XHRadarViewDelegate>
{
    //RadarView *waterWaveView;
    XHRadarView *sectorView;
    NSMutableArray *personArray;
    PersonViewModel *viewModel;
}

@end

@implementation NeighBourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backGo)];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title = @"附件的同伴";

    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"radar_background"]];
    self.view.backgroundColor = bgColor;

    viewModel = [[PersonViewModel alloc] init];
    
    [self InitSectorRadarView];
    
    [self RequestWeiboUser];

}

- (void)RequestWeiboUser
{

    [viewModel requestWeiBoUserModelWithSuccess:^(id Value) {
        
        personArray = Value;
        [sectorView show];
        
    } failure:^(NSError *error){
        
        
    }];
}


//- (void)InitWaterRadarView
//{
//    
//    CGRect radarFrame = CGRectMake(0, (MAX_HEIGHT - MAX_WIDTH)/2.0, MAX_WIDTH, MAX_WIDTH);
//    
//    waterWaveView = [[RadarView alloc] initWithFrame:radarFrame LogoImage:@"anddy926_avtar.jpg"];
//    
//    [self.view addSubview:waterWaveView];
//    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:waterWaveView selector:@selector(findResultItem) userInfo:nil repeats:YES];
//    
//}

- (void)InitSectorRadarView
{
    CGRect  radarFrame = CGRectMake(0, (MAX_HEIGHT - MAX_WIDTH)/2.0, MIN(MAX_WIDTH, MAX_HEIGHT), MIN(MAX_WIDTH, MAX_HEIGHT));
    
    sectorView = [[XHRadarView alloc] initWithFrame:radarFrame];
    
    sectorView.backgroundColor = [UIColor clearColor];
    
    sectorView.radius = MIN(MAX_HEIGHT, MAX_WIDTH)/2.0;
    
    sectorView.indicatorAngle = 180;
    
    sectorView.dataSource = self;
    
    sectorView.delegate = self;
    
    sectorView.logoImage = [UIImage imageNamed:@"anddy926_avtar"];
    
    
    [self.view addSubview:sectorView];
    
    [sectorView scan];
}



#pragma mark sectionView Delegate
- (NSInteger)numberOfSectionsInRadarView:(XHRadarView *)radarView
{
    return 4;
}
- (NSInteger)numberOfPointsInRadarView:(XHRadarView *)radarView
{
    return [personArray count];
}

- (UIView *)radarView:(XHRadarView *)radarView viewForIndex:(NSUInteger)index       //自定义目标点视图
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    view.backgroundColor = [UIColor clearColor];
    
    NearbyPersonModel *person = personArray[index];
    
    NSURL *imageUrl = [NSURL URLWithString:person.avartURLStr];
    NSString *nameStr = person.avartName;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 30, 30)];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    imageView.layer.cornerRadius = 15;
    imageView.layer.borderWidth = 1.0;
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    imageView.clipsToBounds = YES;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 80, 20)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = nameStr;
    textLabel.font = [UIFont systemFontOfSize:12.0];
    textLabel.textColor = [UIColor whiteColor];
    
    [view addSubview:imageView];
    [view addSubview:textLabel];
    
    
    return view;
    
}

- (CGPoint)radarView:(XHRadarView *)radarView positionForIndex:(NSUInteger)index    //目标点所在位置
{
    
    NearbyPersonModel *person = personArray[index];
    
    CGPoint  point = person.position;

    return point;
}


/**
 *
 *  radarViewDelegate
 *  @param radarView
 *  @param index
 */
- (void)radarView:(XHRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index //点击事件
{
    
}

- (void)refetchWeiBoUser
{
    [self RequestWeiboUser];
}


//- (void)setNavigatetransparent
//{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setTranslucent:YES];
//    
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    
//    
//    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                               
//                                               [UIColor blackColor],UITextAttributeTextColor,
//                                               
//                                               [UIColor whiteColor], UITextAttributeTextShadowColor,
//                                               
//                                               [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset, nil];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self HideTabBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)HideTabBar:(BOOL)blret
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blret];
            break;
        }
    }
    
}

-(void)backGo
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
