//
//  ZYPBusinrssOrderViewController.m
//  HaoLin
//
//  Created by mac on 14-8-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPBusinrssOrderViewController.h"

@interface ZYPBusinrssOrderViewController ()

@end
//
@implementation ZYPBusinrssOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    ZYPEntityOrderView *entityView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPEntityOrderView" owner:self options:nil] lastObject];
    entityView.businessOrderVC = self;
    [self.view addSubview:entityView];
    ZYPorderTopView *topView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPorderTopView" owner:self options:nil] lastObject];
    topView.orderV = entityView;
    topView.ZYPBusinrssOrderViewController = self;
    topView.frame = CGRectMake(0, 0, 320, 102);
    [entityView addSubview:topView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end