//
//  ALBBOpenAccountUser.h
//  ALBBOpenAccount
//
//  Created by zifan.zx on 10/29/15.
//  Copyright © 2015 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALBBOpenAccountUser : NSObject
    @property (strong, nonatomic, readonly) NSNumber *accountId;
    @property (copy, nonatomic, readonly) NSString *displayName;
    @property (copy, nonatomic, readonly) NSString *mobile;
    @property (copy, nonatomic, readonly) NSString *loginId;
    @property (copy, nonatomic, readonly) NSString *avatarUrl;
    @property (copy, nonatomic, readonly) NSString *extInfos;//
@end
