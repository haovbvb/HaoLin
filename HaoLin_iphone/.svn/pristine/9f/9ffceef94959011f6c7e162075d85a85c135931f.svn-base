//
//  MQLCustomTabBarController.m
//  NavAndTabOfUse
//
//  Created by dangdai on 13-6-2.
//  Copyright (c) 2013年 bfec. All rights reserved.
//

#import "MQLCustomTabBarController.h"
#import "MQLCustomNavigationController.h"


@interface MQLCustomTabBarController ()<MQLCustomTabBarDelegate>

/*
 添加子视图控制器
 */
-(void)loadViewControllers;

/*
 添加自定义tabBarView
 */
-(void)loadCustomTabBarView;



@end

@implementation MQLCustomTabBarController


-(void)dealloc
{

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.lastTabBarItemIndex = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 添加子视图控制器
    [self loadViewControllers];
    
    //添加自定义tabBarView
    [self loadCustomTabBarView];
    
}

/*
 添加子视图控制器
 */
-(void)loadViewControllers
{
    MQLPersonalViewController *personalViewController = [[MQLPersonalViewController alloc]initWithNibName:@"MQLPersonalViewController" bundle:nil];
    MQLCustomNavigationController *personalNavigationController = [[MQLCustomNavigationController alloc]initWithRootViewController:personalViewController];
    personalNavigationController.interactivePopGestureRecognizer.enabled = NO;
    
    MQLBusinessViewController *businessViewController = [[MQLBusinessViewController alloc]initWithNibName:@"MQLBusinessViewController" bundle:nil];
    MQLCustomNavigationController *businessNavigationController = [[MQLCustomNavigationController alloc]initWithRootViewController:businessViewController];
    businessNavigationController.interactivePopGestureRecognizer.enabled = NO;
    
    MQLPartyViewController *partyViewController = [[MQLPartyViewController alloc]initWithNibName:@"MQLPartyViewController" bundle:nil];
    MQLCustomNavigationController *partyNavigationController = [[MQLCustomNavigationController alloc]initWithRootViewController:partyViewController];
    partyNavigationController.interactivePopGestureRecognizer.enabled = NO;
    
    MQLPetsViewController *petsViewController = [[MQLPetsViewController alloc]initWithNibName:@"MQLPetsViewController" bundle:nil];
    MQLCustomNavigationController *petsNavigationController = [[MQLCustomNavigationController alloc]initWithRootViewController:petsViewController];
    petsNavigationController.interactivePopGestureRecognizer.enabled = NO;
    
    
    self.viewControllers = [NSArray arrayWithObjects:personalNavigationController,
                            businessNavigationController,
                            partyNavigationController,
                            petsNavigationController, nil];
    
}

/*
 添加自定义tabBarView
 */
-(void)loadCustomTabBarView
{
    NSArray *normalImageArray = [NSArray arrayWithObjects:
                                 @"MQLPersonalNomalTabBarItem",
                                 @"MQLBusinessNormalTabBarItem",
                                 @"MQLMyNormalTabBarItem",
                                 @"MQLOrderformNormalTabBarItem", nil];
    
    NSArray *selectedImageArray = [NSArray arrayWithObjects:
                                   @"MQLPersonalSelectedTabBarItem",
                                   @"MQLBusinessSelectedTabBarItem",
                                   @"MQLMySelectedTabBarItem",
                                   @"MQLOrderformSelectedTabBarItem", nil];
    
    NSArray *titlesArray = [NSArray arrayWithObjects:@"个人", @"商家", @"我的", @"订单", nil];
    
    MQLCustomTabBar *tabBar = [[MQLCustomTabBar alloc]initWithFrame:self.tabBar.bounds normalImageArray:normalImageArray selectedImageArray:selectedImageArray titlesArray:titlesArray];
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    
    
}

#pragma MQLCustomTabBarDelegate
-(void)didSelectImageViewWithSelectedIndex:(NSUInteger)selectedIndex
{
    if (self.selectedIndex == 0 || self.selectedIndex == 1) {
        
        self.lastTabBarItemIndex = self.selectedIndex;
    }
    self.selectedIndex = selectedIndex;
}
//(2_0, 6_0)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.selectedViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

//(6.0 and later)
- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

//(6.0 and later)
- (NSUInteger)supportedInterfaceOrientations
{
    return self.selectedViewController.supportedInterfaceOrientations;
}

//(6.0 and later)
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

@end
