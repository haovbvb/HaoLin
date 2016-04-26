//
//  ZYPCustomBottomView.m
//  HaoLin
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPCustomBottomView.h"

@implementation ZYPCustomBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)makeSure:(id)sender
{
    [self.detailVC makeSureFaHuo];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
