//
//  MDLPicView.m
//  HaoLin
//
//  Created by apple on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MDLPicView.h"


@implementation MDLPicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    _pictext.delegate=self;
    _pictext.placeholder=@"  输入修改商品价格";
    _pictext.clearButtonMode=YES;
    
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
