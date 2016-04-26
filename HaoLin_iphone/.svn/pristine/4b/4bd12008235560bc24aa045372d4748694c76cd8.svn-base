//
//  ZYPLoginStateView.m
//  HaoLin
//
//  Created by mac on 14-9-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPLoginStateView.h"

@implementation ZYPLoginStateView

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
    if (IS_IPHONE_5) {
        self.frame = CGRectMake(0, 0, 320, 560);
    }else
    {
        self.frame = CGRectMake(0, 0, 320, 480);
    }
    self.titleLabel.backgroundColor = ZYPBGColor;
    self.tishiLabel.numberOfLines = 0;
    self.tishiLabel.lineBreakMode=NSLineBreakByCharWrapping;
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
