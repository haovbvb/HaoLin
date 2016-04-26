//
//  ZYPServeOrderTopView.m
//  HaoLin
//
//  Created by mac on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPServeOrderTopView.h"

@implementation ZYPServeOrderTopView

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
    self.titleLabel.backgroundColor = ZYPBGColor;

}
- (IBAction)allServeOrder:(id)sender
{
    self.redLabel.frame = CGRectMake(0, 100, 105, 2);
    [self.orderView allServe:@"全部订单"];
}


- (IBAction)waitToServe:(id)sender
{
    self.redLabel.frame = CGRectMake(106, 100, 105, 2);
    [self.orderView waitToServe:@"等待服务"];
}


- (IBAction)alreadlyServe:(id)sender
{
    self.redLabel.frame = CGRectMake(214, 100, 105, 2);
    [self.orderView alreadyServe:@"已经服务"];
}


- (IBAction)back:(id)sender
{
    /**
     *  需要判断
     *
     *
     */
    if ([[ZYPObjectManger shareInstance].barTitle isEqualToString:@"1"])
    {
        [self.serveVC.navigationController popViewControllerAnimated:YES];
    }
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
