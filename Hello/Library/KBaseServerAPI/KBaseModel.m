//
//  KBaseModel.m
//  Hello
//
//  Created by 金玉衡 on 16/10/18.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "KBaseModel.h"

@implementation KBaseModel


-(instancetype)initWithAddress:(NSString *)address
{
    self = [super init];
    if(self)
    {
        _address = address;
        _serverapi = [[KBaseServerAPI alloc] initWithServer:address];
        
    }
    
    return self;
}

- (BOOL)isLoading
{
    return self.serverapi.state == KT_PROC_STAT_CREATED || self.serverapi.state == KT_PROC_STAT_LOADING;
}

- (void)loadInnerWithShortConnection
{
    __weak KBaseModel *weakself = self;
    NSString *requestAddress = self.address;
    [self.serverapi accessAPI:requestAddress WithParams:self.params completionBlock:^(KBaseServerAPI *api){
        __strong KBaseModel *sself = weakself;
        [sself handleShortConnectionBlock:api];
    }];
}

- (void)handleShortConnectionBlock:(KBaseServerAPI *)api
{
    if(api.state == KT_PROC_STAT_SUCCEED && !api.error)
    {
        //success
        [self parseData:api.jsonData];
    }
    else if((api.state == KT_PROC_STAT_FAILED || api.error) && api.state != KT_PROC_STAT_CANCELLED)
    {
        //failed
        if(self.KBaseModelBlock)
        {
            self.KBaseModelBlock(self);
        }
    }
    else
    {
        //cancel
        if(self.KBaseModelBlock)
        {
            self.KBaseModelBlock(self);
        }
    }
}

- (void)loadWithShortConnect
{
    assert(self.address != nil && self.params != nil);
    if([self isLoading])
    {
        return ;
    }
    
    [self loadInnerWithShortConnection];
}

- (void)loadWithLongConnect
{
    assert(self.address != nil && self.params != nil);
    if([self isLoading])
    {
        return ;
    }
    
    [self loadInnerWithShortConnection];
}


- (void)refresh
{
    [self.serverapi refresh];
}

- (void)cancel
{
    [self.serverapi cancel];
}

- (void)parseData:(NSDictionary *)jsonData
{
    __block NSDictionary *blockData = [NSDictionary dictionaryWithDictionary:jsonData];
    __block KBaseModel *model = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        //异步解析数据
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            //同步通知到主线程
            if(self.KBaseModelBlock)
            {
                self.KBaseModelBlock(self);
            }
        });
    
    });
    
}


@end
