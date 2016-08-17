//
//  PersonViewModel.h
//  Hello
//
//  Created by 金玉衡 on 16/8/17.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelClass.h"

@interface PersonViewModel : ViewModelClass

- (void)requestWeiBoUserModelWithSuccess:(void (^)(id Value))success  failure:(void (^) (NSError *errorCode))failure;

@end
