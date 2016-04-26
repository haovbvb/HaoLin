//
//  ZYPAddView.m
//  Business
//
//  Created by mac on 14-8-21.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPAddView.h"

@implementation ZYPAddView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //  商品名
        self.goodslabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 30)];
        self.goodslabel.font = [UIFont systemFontOfSize:chacterHong +1];
        self.goodslabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.goodslabel];
        //  购买数量label
        
        self.goodsAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 50, 30)];
        self.goodsAmountLabel.font = [UIFont systemFontOfSize:chacterHong + 1];
        self.goodsAmountLabel.text = @"数量:";
        [self addSubview:self.goodsAmountLabel];
        
        //  购买数量
        self.goodsAmount = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 20, 30)];
        self.goodsAmount.font = [UIFont systemFontOfSize:chacterHong + 1];
        self.goodsAmount.textColor = [UIColor orangeColor];
        self.goodsAmount.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.goodsAmount];
        //  商品价格
        self.goodsPrice = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 70, 30)];
        self.goodsPrice.font = [UIFont systemFontOfSize:chacterHong];
        self.goodsPrice.textColor = [UIColor orangeColor];
        self.goodsPrice.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.goodsPrice];
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
