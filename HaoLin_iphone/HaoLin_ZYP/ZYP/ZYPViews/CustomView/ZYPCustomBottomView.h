//
//  ZYPCustomBottomView.h
//  HaoLin
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZYPOrderDetailVC;
@interface ZYPCustomBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (nonatomic, strong)ZYPOrderDetailVC *detailVC;

@end
