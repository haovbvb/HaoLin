//
//  HSPOrderPayView.h
//  HaoLin
//
//  Created by PING on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPOrderPayView : UIView
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderSnLabel;
@property (weak, nonatomic) IBOutlet UILabel *CreatedTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *onlinePayBtn;
@property (weak, nonatomic) IBOutlet UIButton *CashPayBtn;

@property (weak, nonatomic) IBOutlet UIButton *otherPayBtn;



- (IBAction)payTypeBtnClick:(UIButton *)sender;

@property (nonatomic, copy) void(^payTypeBlock)(int senderTag);


@end
