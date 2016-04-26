//
//  ZYPServeOrderBottomView.m
//  HaoLin
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPServeOrderBottomView.h"

@implementation ZYPServeOrderBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib
{
    self.cancelBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.cancelBtn.layer.borderWidth = 1;
}
- (IBAction)cancel:(id)sender
{
    [self.serveVC cancelDingDan];
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
