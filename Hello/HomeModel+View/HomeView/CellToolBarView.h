//
//  CellToolBarView.h
//  Hello
//
//  Created by 金玉衡 on 16/6/22.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AsynImageView, CellToolBarModel;
@interface CellToolBarView : UIView

@property (nonatomic, strong)UIView *repostView;
@property (nonatomic, strong)AsynImageView *repostImage;
@property (nonatomic, strong)UILabel *repostLabel;

@property (nonatomic, strong)UIView *commentView;
@property (nonatomic, strong)AsynImageView *commentImage;
@property (nonatomic, strong)UILabel *commentLabel;

@property (nonatomic, strong)UIView *likeView;
@property (nonatomic, strong)AsynImageView *likeImage;
@property (nonatomic, strong)UILabel *likeLabel;


-(void)setData:(CellToolBarModel *)toolBarModel;

@end
