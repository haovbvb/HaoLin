//
//  HSPSeviceRuleViewController.m
//  HaoLin
//
//  Created by PING on 14-10-14.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPSeviceRuleViewController.h"

@interface HSPSeviceRuleViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HSPSeviceRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好邻帮服务协议";
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"SeviceRule.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
