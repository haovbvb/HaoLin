//
//  HSPOrderViewController.m
//  HaoLin
//
//  Created by PING on 14-9-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPOrderViewController.h"

@interface HSPOrderViewController ()


@end

@implementation HSPOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HSPOrderView *orderView = [[[NSBundle mainBundle] loadNibNamed:@"HSPOrderView" owner:nil options:nil] lastObject];
    [self.view addSubview:orderView];
}

@end
