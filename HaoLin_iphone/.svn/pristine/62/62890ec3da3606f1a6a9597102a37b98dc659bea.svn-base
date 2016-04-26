//
//  JZDImageView.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZDImageView;
@class JZDScrollView;
@protocol JZDImageViewDelegate <NSObject>

-(void)imageSingelClick:(JZDImageView *)imgView;

@end

@interface JZDImageView : UIImageView
{
    SEL _selector;
    id myDelegate;
    BOOL isChanged;
    CGRect defaultRect;
    UIImageView *Im;
    UIWindow *window;
    UIImage *fakeImage;
    UIViewController *clickViewController;
    UIView *snapView;
}

@property (nonatomic,weak) __weak id<JZDImageViewDelegate> delegate;

-(void)makeBlockEecute:(void(^)(JZDScrollView *scroll))blockScroll withImageArray:(NSMutableArray *)array;

// !@brief 为YES时，点击图片有放大到全屏的动画效果，再次点击缩小到原始坐标动画效果
@property (nonatomic ,assign, setter = canClickIt:) BOOL canClick;
@property (nonatomic ,assign) float duration;//动画时间

// !@brief 设定点击时要加载的ViewController,加载方式和消失方式是presentViewController和dismissViewController
- (void)setClickToViewController:(UIViewController*)cViewController;

// !@brief 调用此方法移除子视图
+ (void)dismissClickView;
@end

//代理型，只提供简单功能
@interface UIImageView (Click)

// !@brief 为YES时，点击图片有放大到全屏的动画效果，再次点击缩小到原始坐标动画效果
@property (nonatomic ,assign, setter = canClickIt:) BOOL canClick;

@end
