//
//  HomeCoreDataManager.h
//  Hello
//
//  Created by 金玉衡 on 16/8/23.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCoreDataManager : NSObject

- (void)writeCoreDataToDB:(NSMutableArray *)dataArray;

- (NSMutableArray *)readCoreDataFromDB;

- (void)deleteCoreDataFromDB;


@end
