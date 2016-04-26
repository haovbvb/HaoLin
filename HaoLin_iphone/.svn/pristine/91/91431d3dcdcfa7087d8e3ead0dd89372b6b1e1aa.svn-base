//
//  HSPSegmentedControl.h
//  HaoLin
//
//  Created by PING on 14-9-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HSPSegmentedControlDelegate <NSObject>

@required
//代理函数 获取当前下标
- (void)HSPSegmentedControlSelectAtIndex:(NSInteger)index;

@end

@interface HSPSegmentedControl : UIView

@property (assign, nonatomic) id<HSPSegmentedControlDelegate>delegate;
//初始化函数
- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate;
//提供方法改变 index
- (void)changeSegmentedControlWithIndex:(NSInteger)index;

@end
