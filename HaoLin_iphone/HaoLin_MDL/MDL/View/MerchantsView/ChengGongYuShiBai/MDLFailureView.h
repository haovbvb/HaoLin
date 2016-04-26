//
//  MDLFailureView.h
//  HaoLin
//
//  Created by apple on 14-8-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDLFailureView : UIView

/**
 * JXqiangdanButton  :继续抢单按钮
 * Zhuimage :主背景图
 * ANimage  :按钮背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *Zhuimage;
@property (weak, nonatomic) IBOutlet UIImageView *ANimage;
@property (weak, nonatomic) IBOutlet UIButton *JXqiangdanButton;
@property (weak, nonatomic) IBOutlet UIView *navbarv;

@end
