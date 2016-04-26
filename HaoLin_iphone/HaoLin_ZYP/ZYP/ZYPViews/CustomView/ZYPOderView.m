//
//  ZYPOderView.m
//  HaoLin
//
//  Created by mac on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPOderView.h"

@implementation ZYPOderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.nameLabel];
        self.caseLabel = [[UILabel alloc] initWithFrame:CGRectMake(113, 0, 200, 40)];
        self.caseLabel.textAlignment = NSTextAlignmentLeft;
        self.caseLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.caseLabel];
    }
    return self;
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
