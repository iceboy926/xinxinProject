//
//  CustomGrid.h
//  Hello
//
//  Created by 金玉衡 on 16/7/27.
//  Copyright © 2016年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomGridDelegate;

@interface CustomGrid : UIButton

@property (nonatomic, assign) NSInteger  gridID;

@property (nonatomic, strong) NSString  *gridTitle;

@property (nonatomic, strong) NSString  *gridImage;

@property (nonatomic, assign) CGPoint   gridCenterPoint;

@property (nonatomic, weak) id<CustomGridDelegate> delegate;


- (id) initWithFrame:(CGRect)frame
               Title:(NSString *)title
                Icon:(NSString *)icon
         NormalImage:(NSString *)normalImage
      HighlightImage:(NSString *)highlightImage
              GridID:(NSInteger)gridID;



@end

@protocol CustomGridDelegate <NSObject>

- (void)gridItemDidClicked:(CustomGrid *)item;

@end
