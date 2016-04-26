//
//  HSPOrderPayView.m
//  HaoLin
//
//  Created by PING on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPOrderPayView.h"

@implementation HSPOrderPayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)payTypeBtnClick:(UIButton *)sender{
    
    _onlinePayBtn.selected = NO;
    _CashPayBtn.selected = NO;
    _otherPayBtn.selected = NO;
    
    sender.selected = YES;
    _payTypeBlock((int)sender.tag);
}



@end
