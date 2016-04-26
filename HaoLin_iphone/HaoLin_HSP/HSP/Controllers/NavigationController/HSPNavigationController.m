//
//  HSPNavigationController.m
//  HaoLin
//
//  Created by PING on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPNavigationController.h"

@interface HSPNavigationController ()

@end

@implementation HSPNavigationController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.hidden = NO;
    }
    return self;
}

+ (void)initialize
{
    
    // 设置按钮的主题
    [self setupButtonTheme];
    
}
/**
 *  设置按钮的主题
 */
+ (void)setupButtonTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 修改文字颜色
    NSDictionary *attris = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
    [navBar setTitleTextAttributes:attris];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.barTintColor = HSPBarBgColor;
    self.navigationBar.hidden = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 隐藏工具条
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 覆盖返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"HSP_back_nom" highlightedImage:@"HSP_back_down" target:self action:@selector(back)];
    
    }
    // 第一次(根控制器)不需要隐藏工具条
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
