//
//  MQLTimerViewInHanDanWaitingView.h
//  HaoLin
//
//  Created by MQL on 14-9-4.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MQLTimerViewInHanDanWaitingViewDelegate <NSObject>

/**
 *  等待结束
 */
-(void)waitingOver;

/**
 *  停止等待
 *
 *  @param talk_id
 */
-(void)stopWaitingWithReceiveTalk_id:(NSString*)talk_id;


@end

@interface MQLTimerViewInHanDanWaitingView : UIView

@property (nonatomic, weak) id<MQLTimerViewInHanDanWaitingViewDelegate> delegate;
@property (nonatomic, strong) NSDictionary *dataOfHanDanOver;       //喊单成功后的data字典


@end
