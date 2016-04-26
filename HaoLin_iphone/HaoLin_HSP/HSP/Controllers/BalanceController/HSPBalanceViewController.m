//
//  HSPBalanceViewController.m
//  HaoLin
//
//  Created by PING on 14-8-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPBalanceViewController.h"

@interface HSPBalanceViewController ()<HSPHttpRequestDelegate>

@property (nonatomic, strong) HSPHttpRequest *request;

@end

@implementation HSPBalanceViewController

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
    
    self.title = @"我的余额";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor,NSForegroundColorAttributeName, nil]];
    self.view.backgroundColor = HSPBgColor;
    
    [self sendRequest];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"HSP_back_nom" highlightedImage:@"HSP_back_down" target:self action:@selector(back)];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)sendRequest
{
    HSPAccount *account = [HSPAccountTool account];
    NSString *url = [NSString stringWithFormat:balanceUrl,account.user_id,account.userTokenid];
    [self.request connectionRequestUrl:url withDelegate:self];
}

- (void)requestFinished:(id)responseObject
{
    if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
        _myMoney.text = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"] objectForKey:@"amount"]];
        _takeCount.text = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"] objectForKey:@"sy_number"]];
        _takeMax.text = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"] objectForKey:@"take_max"]];
        _ruleDescUrl = [[responseObject objectForKey:@"data"] objectForKey:@"rule_desc"];
    }
}

- (void)requestFailed:(NSError *)error
{
    YYLog(@"error=%@",error);
}

- (IBAction)cashBtnClick:(id)sender {
    [self sendRequestCheckAccount];
    
}

- (void)sendRequestCheckAccount
{
    __weak JZDCustomAlertView *alert = [JZDCustomAlertView sharedInstace];
    HSPAccount *account = [HSPAccountTool account];
    NSString *url = [NSString stringWithFormat:checkAccountUrl,account.user_id,account.userTokenid];
    [self.request connectionREquesturl:url withPostDatas:nil withDelegate:nil withBackBlock:^(id backDictionary) {
        if ([backDictionary isKindOfClass:[NSError class]]) {
            [alert popAlert:@"获取数据失败"];
            return;
        }
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
            
            HSPCashViewController *cashVc = [[HSPCashViewController alloc] initWithNibName:@"HSPCashViewController" bundle:nil];
            [self.navigationController pushViewController:cashVc animated:YES];
        }else{
            [alert popAlert:[backDictionary objectForKey:@"message"]];
            return;
        }
    }];
}


#pragma mark - 懒加载
- (HSPHttpRequest *)request
{
    if (!_request) {
        _request = [HSPHttpRequest Instace];
    }
    return _request;
}

- (IBAction)ruleBtnClick:(UIButton *)sender {
    HSPCashRuleViewController *rule = [[HSPCashRuleViewController alloc] initWithNibName:@"HSPCashRuleViewController" bundle:nil];
    rule.ruleDescUrl = _ruleDescUrl;
    [self.navigationController pushViewController:rule animated:YES];
}
@end
