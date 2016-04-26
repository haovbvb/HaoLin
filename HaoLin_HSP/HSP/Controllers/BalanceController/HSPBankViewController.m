//
//  HSPBankViewController.m
//  HaoLin
//
//  Created by PING on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPBankViewController.h"

@interface HSPBankViewController ()

@end

@implementation HSPBankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scrollView.contentSize = CGSizeMake(HSPScreenWidth, HSPScreenHeight);
    [_scrollView addSubview:_bankView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bankBtnClick:(UIButton *)sender {
    YYLog(@"%d",sender.tag);
    
    NSString *senderTag = [NSString stringWithFormat:@"%d",sender.tag + 1];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setBankName" object:nil userInfo:@{@"code":senderTag,@"bankName":sender.titleLabel.text}];
}

@end
