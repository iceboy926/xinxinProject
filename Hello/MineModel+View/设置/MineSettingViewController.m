//
//  MineSettingViewController.m
//  Hello
//
//  Created by 金玉衡 on 16/7/20.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "MineSettingViewController.h"

@interface MineSettingViewController()
{
    UIActivityIndicatorView* activityIndicator_;
}

@end

@implementation MineSettingViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    
}

-(void)hideToolBar:(BOOL)blhide
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blhide];
            break;
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideToolBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideToolBar:NO];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch ([indexPath section]) {
        case 0:
        {
            cell.textLabel.text = @"账号&&安全";
        }
            break;
        case 1:
        {
            switch ([indexPath row]) {
                case 0:
                {
                    cell.textLabel.text = @"清空缓存";
                    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                    activityView.center = [cell.contentView center];
                    [cell.contentView addSubview:activityView];
                    
                    activityIndicator_ = activityView;
                    
                    [activityView startAnimating];
                    
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"缓存大小(%.2fM)", [self GetCacheSize]];
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"通用";
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            switch ([indexPath row]) {
                case 0:
                {
                    [self clearCache];
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                default:
                    break;
            }
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath])
    {
        return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return  0;
}

-(float)folderSizeAtpath:(NSString *)foldPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:foldPath])
    {
        return 0;
    }
    
    NSEnumerator *childFileEnumrator = [[fileManager subpathsAtPath:foldPath] objectEnumerator];
    
    NSString *strFileName;
    
    long long foldSize = 0;
    
    while ((strFileName = [childFileEnumrator nextObject]) != nil) {
        
        NSString *fileAbsolutePath = [foldPath stringByAppendingPathComponent:strFileName];
        BOOL blDirectory = NO;
        if([fileManager fileExistsAtPath:fileAbsolutePath isDirectory:&blDirectory])
        {
            if(blDirectory == YES)
            {
                foldSize += [self folderSizeAtpath:fileAbsolutePath];
            }
            else
            {
                foldSize += [self fileSizeAtPath:fileAbsolutePath];
            }
        }
    }
    
    return foldSize/(1024.0*1024.0);
}


-(float)GetCacheSize
{
    NSString *strCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    return [self folderSizeAtpath:strCachePath];
}


-(void)clearCache
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *strCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSArray *files = [fileManager subpathsAtPath:strCachePath];
        
        for (NSString *fileName in files) {
            
            NSString *fileFullName = [strCachePath stringByAppendingPathComponent:fileName];
            if([fileManager fileExistsAtPath:fileFullName])
            {
                [fileManager removeItemAtPath:fileFullName error:nil];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
        
            if([activityIndicator_ isAnimating])
            {
                [activityIndicator_ stopAnimating];
            }
            
            [self.tableView reloadData];
        });
    
    });
}


@end
