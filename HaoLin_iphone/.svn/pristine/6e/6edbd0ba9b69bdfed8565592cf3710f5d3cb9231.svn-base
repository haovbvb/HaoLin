//
//  HSPNavigationBar.m
//  HaoLin
//
//  Created by PING on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPNavigationBar.h"

@interface HSPNavigationBar ()

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation HSPNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setBarTintColor:(UIColor *)barTintColor{
    [super setBarTintColor:barTintColor];
    [self.layer addSublayer:self.colorLayer];
    self.colorLayer.backgroundColor=barTintColor.CGColor;
}

@end
