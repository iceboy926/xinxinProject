//
//  HomeCoreDataManager.m
//  Hello
//
//  Created by 金玉衡 on 16/8/23.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "HomeCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "HomeCellModel.h"

#define HomeTableName @"HomeCellModel"

@interface HomeCoreDataManager()

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext; //管理上下文
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel; //管理的数据模型
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator; //连接数据库

@end

@implementation HomeCoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UserInfo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UserInfo.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}






- (void)writeCoreDataToDB:(NSMutableArray *)dataArray
{
    NSManagedObjectContext *context = [self managedObjectContext];
    for (HomeCellModel *homeModel in dataArray) {
        
        HomeCellModel *homeModelInfo = [NSEntityDescription insertNewObjectForEntityForName:HomeTableName inManagedObjectContext:context];
        
        homeModelInfo.icon = homeModel.icon;
        homeModelInfo.name = homeModel.name;
        homeModelInfo.timesource = homeModel.timesource;
        homeModelInfo.detail = homeModel.detail;
        homeModelInfo.pictureArray = [NSMutableArray arrayWithArray:homeModel.pictureArray];
        
        homeModelInfo.retweetPictureArray = [NSMutableArray arrayWithArray:homeModel.retweetPictureArray];
        homeModelInfo.retweetDetail = homeModel.retweetDetail;
        
        homeModelInfo.repostCount = (homeModel.repostCount == 0) ? 0: homeModel.repostCount;
        homeModelInfo.commentCount = (homeModel.commentCount == 0) ? 0: homeModel.commentCount;
        homeModelInfo.atitudesCount = (homeModel.atitudesCount == 0) ? 0: homeModel.atitudesCount;
        homeModelInfo.blVip = homeModel.blVip;
        homeModelInfo.blretweet = homeModel.blretweet;
    
        NSError *error;
        if(![context save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
    }

    
}

- (NSMutableArray *)readCoreDataFromDB
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:HomeTableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *arrayData = [NSMutableArray array];
    
    for (HomeCellModel *model in fetchedObjects) {
        [arrayData addObject:model];
    }
    
    return arrayData;
}

- (void)deleteCoreDataFromDB
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:HomeTableName inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }

}



@end
