//
//  HSPOrderCountView.h
//  HaoLin
//
//  Created by PING on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPOrderCountView : UIView
@property (weak, nonatomic) IBOutlet UILabel *servicePrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *serviceTitle;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalTitle;

@end
