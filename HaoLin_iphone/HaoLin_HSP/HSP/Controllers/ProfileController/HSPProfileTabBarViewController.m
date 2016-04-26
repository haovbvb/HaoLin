//
//  HSPProfileTabBarViewController.m
//  HaoLin
//
//  Created by PING on 14-9-17.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPProfileTabBarViewController.h"

@interface HSPProfileTabBarViewController () <UIAlertViewDelegate>

@end

@implementation HSPProfileTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    HSPAccount *account = [HSPAccountTool account];
    
    if (account == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        return;
    }
    if ([account.user_mark isEqualToString:@"0"]) {
        HSPProfileViewController *loginViewController = [[HSPProfileViewController alloc] initWithNibName:@"HSPProfileViewController" bundle:nil];
        //            HSPNavigationController *loginNav = [[HSPNavigationController alloc] initWithRootViewController:loginViewController];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        HSPLoginViewController *loginViewController = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        HSPNavigationController *loginNav = [[HSPNavigationController alloc] initWithRootViewController:loginViewController];
        [self presentViewController:loginNav animated:YES completion:nil];
        
    }
}


@end
