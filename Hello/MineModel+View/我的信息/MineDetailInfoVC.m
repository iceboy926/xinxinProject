//
//  MineDetailInfoVC.m
//  Hello
//
//  Created by 金玉衡 on 16/7/21.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "MineDetailInfoVC.h"
#import "HGDQQRCodeView.h"


@interface MineDetailInfoVC () <UIActionSheetDelegate>
{
    UIImageView *_myQRView;
}

@end

@implementation MineDetailInfoVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView  *myQRView = [[UIImageView alloc] initWithFrame:CGRectMake(MAX_WIDTH/2.0 - MAX_WIDTH/4.0, MAX_HEIGHT/2.0 - MAX_WIDTH/2.0, MAX_WIDTH/2.0, MAX_WIDTH/2.0)];
    UIImage *image = [UIImage imageNamed:@"anddy926_avtar.jpg"];
    
    myQRView.userInteractionEnabled = YES;
    
    UIImage *qrimage = [HGDQQRCodeView creatQRCodeWithURLString:Git_URL ViewSize:myQRView.frame.size logoImage:image logoImageSize:CGSizeMake(40, 40) logoImageWithCornerRadius:10.0];

    [myQRView setImage:qrimage];
    
    _myQRView = myQRView;
    
    [self.view addSubview:_myQRView];
    
    self.view.backgroundColor = kWBCellBackgroundColor;
    
    UILongPressGestureRecognizer *longTapGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDo:)];
    
    longTapGesture.minimumPressDuration = 1.0;
    
    [_myQRView addGestureRecognizer:longTapGesture];
    
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


-(void)hideToolBar:(BOOL)blHide
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blHide];
            break;
        }
    }
}


- (void)longPressDo:(UILongPressGestureRecognizer *)tapGesture
{
    NSLog(@"long press do");
    if(tapGesture.state == UIGestureRecognizerStateBegan)
    {
        
    }
    else if(tapGesture.state == UIGestureRecognizerStateEnded)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"扫描", nil];
        actionSheet.tag = 1;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
}

/**
 *  actionsheetDelegate
 *
 *  @param actionSheet
 *  @param buttonIndex 
 */

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 1)
    {
        if(buttonIndex == 0)
        {
            UIImage *image = [HGDQQRCodeView screenShotFormView:_myQRView];
            if(image != nil)
            {
                NSArray *arrData = [HGDQQRCodeView readQRCodeFromImage:image];
                if(arrData)
                {
                    
                    CIQRCodeFeature *temp = (CIQRCodeFeature *)arrData[0];
                    
                    NSLog(@"qrCode text is %@", temp.messageString);
                    
                }
            }
        }
    }
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@""];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return MAX_HEIGHT;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *strCell = @"QRCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
//    }
//    
//   
//    
//    
//    
//    return cell;
//    
//}
//

@end
