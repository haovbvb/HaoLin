//
//  NSTimer+Ad.h
//  HaoLin
//
//  Created by MQL on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Ad)

/**
 *  让定时器失效
 */
- (void)invalidateTimer;

/**
 *  暂停定时器
 */
- (void)pauseTimer;

/**
 *  立即激活定时器
 */
- (void)resumeTimer;

/**
 *  固定时间后激活定时器
 *
 *  @param interval 固定时间
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
