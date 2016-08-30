//
//  PersonViewModel.m
//  Hello
//
//  Created by 金玉衡 on 16/8/17.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "PersonViewModel.h"
#import "NearbyPersonModel.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface PersonViewModel() <CLLocationManagerDelegate>
{
    CLLocationCoordinate2D coordinate;
    CLLocationManager *locationMgr;
}

@end


@implementation PersonViewModel

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        locationMgr = [[CLLocationManager alloc] init];
        locationMgr.delegate = self;
        [locationMgr requestWhenInUseAuthorization];
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
        locationMgr.distanceFilter = kCLDistanceFilterNone;
        [locationMgr startUpdatingLocation];
        
        coordinate = locationMgr.location.coordinate;
    }
    
    return self;
}

- (void)requestWeiBoUserModelWithSuccess:(void (^)(id Value))success  failure:(void (^) (NSError *errorCode))failure
{
    
    [self sendRequestWithURL:SinaWeiBo_URL_NearBy_User Location:coordinate Success:success Failure:failure];
}

- (void)sendRequestWithURL:(NSString *)url Location:(CLLocationCoordinate2D)coordinate2D Success:(void (^) (id result))success Failure:(void (^) (NSError *errorCode))failure
{
    __weak typeof(self) weakself = self;
    
    
    
    AppDelegate *appDelegate = [AppDelegate globalDelegate];
    NSMutableDictionary *dicRequest = [NSMutableDictionary dictionary];
    
    [dicRequest setObject:appDelegate.wbtoken forKey:@"access_token"];
    [dicRequest setObject:[NSString stringWithFormat:@"%f",coordinate2D.latitude] forKey:@"lat"];
    [dicRequest setObject:[NSString stringWithFormat:@"%f",coordinate2D.longitude] forKey:@"long"];
    [dicRequest setObject:@"5" forKey:@"count"];
    
    [WBHttpRequest requestWithAccessToken:appDelegate.wbtoken url:url httpMethod:@"Get" params:dicRequest queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         if(error)
         {
             failure(error);
         }
         else
         {
             __strong typeof(self) strongself = weakself;
             
             NSData *jsonData = [result JSONData];
             
             NSDictionary *dicResult = [jsonData objectFromJSONData];
             
             [strongself processReturnValue:dicResult SuccessBlock:success];
         }
     }
     ];
    
}

- (void)processReturnValue:(NSDictionary *)Value SuccessBlock:(void (^)(id Value))success
{
    NSArray *UserArray = [Value objectForKey:@"users"];
    NSMutableArray *arraydata = [NSMutableArray array];
    
    for (NSDictionary *dicUser in UserArray) {
        
        NSString *strUserName = [NSString replaceUnicode:[dicUser objectForKey:@"screen_name"]];
        
        NSString *strIconUrl = [dicUser objectForKey:@"profile_image_url"];
        
        NearbyPersonModel *person = [NearbyPersonModel new];
        
        person.avartName = strUserName;
        person.avartURLStr = strIconUrl;
        
        CGFloat x = floorf(((double)arc4random()/ARC4RANDOM_MAX) * 360);
        CGFloat y = floorf(((double)arc4random()/ARC4RANDOM_MAX) * (MAX_WIDTH/2.0));
        
        person.position = CGPointMake(x, y);
        
        //NSLog(@"x = %f y = %f", x, y);
        
        [arraydata addObject:person];
    }
    
    success(arraydata);

}


@end
