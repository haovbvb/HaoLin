//
//  HSPLogoutBtnView.m
//  HaoLin
//
//  Created by PING on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPLogoutBtnView.h"

@interface HSPLogoutBtnView ()

@end

@implementation HSPLogoutBtnView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)awakeFromNib
{
    //自定义初始化
    [_logoutBtn setBackgroundColor:HSPBarBgColor];
    
}


@end
