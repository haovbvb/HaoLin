//
//  JZDAlertViewShow.m
//  HaoLin
//
//  Created by 姜泽东 on 14-9-1.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDAlertViewShow.h"

@implementation JZDAlertViewShow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGSize size= [_showLable.text boundingRectWithSize:CGSizeMake(250, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    _showLable.frame=CGRectMake(0, 0, 250, size.height);
    self.frame=CGRectMake(0, 0, 250, size.height);
}

@end
