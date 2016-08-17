//
//  MineViewController.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "MineViewController.h"
#import "UIImage+CircleImage.h"
#import "MineSettingViewController.h"
#import "MineDetailInfoVC.h"
#import "UnlockPassWordVC.h"
#import "MineWalletViewController.h"
#import "MinePackageViewController.h"

@interface MineViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerController *imagePicker;
}

@end

@implementation MineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 0)
    {
        return 80;
    }
    else
    {
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
 
    switch (section) {
        case 0:
        {
            rows = 1;
        }
            break;
        case 1:
        {
            rows = 3;
        }
            
            break;
        case 2:
        {
            rows = 1;
        }
            break;
        case 3:
        {
            rows = 1;
        }
            break;
            
        default:
            rows = 0;
            break;
    }
    
    
    return rows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"mineCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch ([indexPath section]) {
        case 0:
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xhr"]];
            imageView.layer.cornerRadius = 5.0;
            imageView.layer.masksToBounds = YES;
            [cell.contentView addSubview:imageView];
            
            UILabel  *titleLabel = [[UILabel alloc] init];
            titleLabel.text = @"南宫勇少";
            titleLabel.font = [UIFont systemFontOfSize:17];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:titleLabel];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(50, 50));
                make.left.mas_equalTo(cell.contentView.mas_left).with.offset(15);
                
            }];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(imageView.mas_right).with.offset(10);
                make.right.mas_equalTo(cell.contentView.mas_right);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.height.mas_equalTo(imageView.mas_height);
            }];
        
        }
            break;
        case 1:
        {
            switch ([indexPath row]) {
                case 0:
                {
                    cell.textLabel.text = @"相册";
                    cell.imageView.image = [UIImage imageNamed:@"MoreMyAlbum"];
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"钱包";
                    cell.imageView.image = [UIImage imageNamed:@"MoreMyBankCard"];
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"卡包";
                    cell.imageView.image = [UIImage imageNamed:@"MyCardPackageIcon"];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"表情";
            cell.imageView.image = [UIImage imageNamed:@"MoreExpressionShops"];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"设置";
            cell.imageView.image = [UIImage imageNamed:@"MoreSetting"];
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:
        {
            MineDetailInfoVC *detailInfo = [[MineDetailInfoVC alloc] initWithStyle:UITableViewStyleGrouped];
            detailInfo.title = @"我的二维码";
            [self.navigationController pushViewController:detailInfo animated:YES];
        }
            break;
        case 1:
        {
            switch ([indexPath row]) {
                case 0:
                {
                    [self OpenPhotoAblum];
                }
                    break;
                case 1:
                {
                    UnlockPassWordVC *unlockVC = [[UnlockPassWordVC alloc] init];
                    unlockVC.title = @"手势密码";
                    [unlockVC setModalTransitionStyle:UIModalTransitionStylePartialCurl];
                    
                    [self.navigationController pushViewController:unlockVC animated:YES];
                }
                    break;
                case 2:
                {
                    MinePackageViewController *packageVC = [[MinePackageViewController alloc] initWithStyle:UITableViewStyleGrouped];
                    packageVC.title = @"我的卡包";
                    [self.navigationController pushViewController:packageVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            MineSettingViewController *settingVC = [[MineSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
            
            [self.navigationController pushViewController:settingVC animated:YES];
        }
            break;
        default:
            break;
    }

}

-(void)OpenPhotoAblum
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePicker animated:YES completion:nil];//:imagePicker animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if(imagePicker)
    {
        [imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
