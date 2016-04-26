//
//  ZYPLoginView.m
//  HaoLin
//
//  Created by mac on 14-9-8.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPLoginView.h"

@implementation ZYPLoginView

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
//    self.headerImageView.layer.borderColor = [UIColor orangeColor].CGColor;
//    self.headerImageView.layer.borderWidth = 1;
    self.headerImageView.layer.cornerRadius = 28;
    self.headerImageView.layer.masksToBounds = YES;
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
