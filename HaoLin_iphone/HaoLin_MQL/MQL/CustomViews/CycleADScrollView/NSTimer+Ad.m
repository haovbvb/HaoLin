//
//  NSTimer+Ad.m
//  HaoLin
//
//  Created by MQL on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "NSTimer+Ad.h"

@implementation NSTimer (Ad)

/**
 *  让定时器失效
 */
- (void)invalidateTimer
{
    if ([self isValid]) {
        [self invalidate];
    }
}

/**
 *  暂停定时器
 */
-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

/**
 *  立即激活定时器
 */
-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

/**
 *  固定时间后激活定时器
 *
 *  @param interval 固定时间
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}


@end
