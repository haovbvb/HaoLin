//
//  ZYPAlertView.m
//  HaoLin
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPAlertView.h"

@implementation ZYPAlertView

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
    [self.v removeFromSuperview];
    [self removeFromSuperview];
       [self.delegateVC updataSource:self.addNameLabel.text];
}

- (IBAction)cancel:(id)sender
{
    [self.v removeFromSuperview];
    [self removeFromSuperview];
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
