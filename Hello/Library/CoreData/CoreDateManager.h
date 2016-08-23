//
//  CoreDateManager.h
//  SQLiteTest
//
//  Created by rhljiayou on 14-1-8.
//  Copyright (c) 2014年 rhljiayou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserFans.h"

#define TableName @"UserFans"

@interface CoreDateManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext; //管理上下文
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel; //管理的数据模型
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator; //连接数据库

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//插入数据
- (void)insertCoreData:(NSMutableArray*)dataArray;

//查询
- (NSMutableArray*)readCoreData;
//查询
- (NSMutableArray*)selectData:(int)pageSize andOffset:(int)currentPage;
//删除
- (void)deleteData;
//更新
- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

@end
