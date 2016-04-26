//
//  JZDImgScrollView.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZDImgScrollViewDelegate <NSObject>

- (void) tapImageViewTappedWithObject:(id) sender;

@end

@interface JZDImgScrollView : UIScrollView

@property (weak) id<JZDImgScrollViewDelegate> i_delegate;

- (void) setContentWithFrame:(CGRect) rect;
- (void) setImage:(UIImage *) image;
- (void) setAnimationRect;
- (void) rechangeInitRdct;

@end
