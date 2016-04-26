//
//  HSPCashRuleViewController.m
//  HaoLin
//
//  Created by PING on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPCashRuleViewController.h"

@interface HSPCashRuleViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HSPCashRuleViewController

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
    self.title = @"提现规则";
    
    NSURL *url = [NSURL URLWithString:_ruleDescUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}


@end
