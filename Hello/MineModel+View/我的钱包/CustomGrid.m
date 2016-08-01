//
//  CustomGrid.m
//  Hello
//
//  Created by 金玉衡 on 16/7/27.
//  Copyright © 2016年 mit. All rights reserved.
//

#import "CustomGrid.h"

#define ICON_WIDTH  36
#define ICON_HEIGHT 36
#define TITLE_LABEL_HEIGHT 35

@interface CustomGrid ()
{
    
}

@property (nonatomic, weak) id<CustomGridDelegate> delegate;

@end

@implementation CustomGrid


- (id) initWithFrame:(CGRect)frame
               Title:(NSString *)title
                Icon:(NSString *)icon
         NormalImage:(NSString *)normalImage
      HighlightImage:(NSString *)highlightImage
              GridID:(NSInteger)gridID
            Delegate:(id<CustomGridDelegate>) delegate
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
        
        [self addTarget:self action:@selector(gridClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:icon];
        iconView.tag = gridID;
        [self addSubview:iconView];
        
        UILabel *titleView = [[UILabel alloc] init];
        titleView.text = title;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.font = [UIFont systemFontOfSize:14];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.textColor = UIColorHex(@"3C454C");
        [self addSubview:titleView];
        
        int padding = 20;
        
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(ICON_WIDTH);
            make.top.mas_equalTo(self.mas_top).with.offset(padding);
            make.height.mas_equalTo(ICON_HEIGHT);
            
        }];
        
        
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(TITLE_LABEL_HEIGHT);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(-padding);
        }];
        
        _gridID = gridID;
        
        _delegate = delegate;
    }
    return self;
}

- (void)gridClicked:(CustomGrid *)clickItem
{
    if(_delegate && [_delegate respondsToSelector:@selector(gridItemDidClicked:)])
    {
        [_delegate gridItemDidClicked:clickItem];
    }
}


@end
