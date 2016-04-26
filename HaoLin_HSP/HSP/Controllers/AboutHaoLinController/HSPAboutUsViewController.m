//
//  HSPAboutUsViewController.m
//  HaoLin
//
//  Created by PING on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPAboutUsViewController.h"

@interface HSPAboutUsViewController ()

@end

@implementation HSPAboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view.backgroundColor = HSPBgColor;
    }
    return self;
}
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.title = @"关于我们";
}


@end
