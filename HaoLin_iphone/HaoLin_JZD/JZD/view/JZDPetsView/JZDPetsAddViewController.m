//
//  JZDPetsAddViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDPetsAddViewController.h"

#define HeightOfScreen (device_is_iphone_5)?(230):(200)

@interface JZDPetsAddViewController ()<UIAlertViewDelegate>
{
    UIViewController *currectViewController;
    JZDPetsActivityViewController *activity;
    JZDPetsBBSViewController *bbs;
}
@end

@implementation JZDPetsAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    _publishBrn.frame=CGRectMake(0, HeightOfScreen, 60, 60);
    _publishBrn.exclusiveTouch=YES;
//    _publishBrn.layer.shadowOpacity=1;//设置阴影
    [win addSubview:_publishBrn];
    [win bringSubviewToFront:_publishBrn];
    [self uiconfig];
}

-(void)uiconfig
{
    self.navigationController.navigationBarHidden=YES;
    _publishBrn.hidden=NO;
    activity=[[JZDPetsActivityViewController alloc] initWithNibName:@"JZDPetsActivityViewController" bundle:nil];
//    activity.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64);
    [self addChildViewController:activity];
    bbs=[[JZDPetsBBSViewController alloc] initWithNibName:@"JZDPetsBBSViewController" bundle:nil];
    
    [self addChildViewController:bbs];
    [_petsBottomView addSubview:activity.view];
    if (_topSegment.selectedSegmentIndex==0) {
//        [_petsBottomView addSubview:activity.view];
        currectViewController=activity;
    }else{
//        [_petsBottomView addSubview:bbs.view];
        currectViewController=bbs;
    }
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    _publishBrn.hidden=YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _publishBrn.hidden=NO;
    self.navigationController.navigationBarHidden=YES;
}

- (IBAction)selectPetsAbout:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex==1) {
        [self transitionFromViewController:currectViewController toViewController:bbs duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            bbs.view.frame=CGRectMake(0, 0, self.view.frame.size.width, _petsBottomView.frame.size.height);
        } completion:^(BOOL finished) {
            currectViewController=bbs;
        }];
    }else{
        [self transitionFromViewController:currectViewController toViewController:activity duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
        } completion:^(BOOL finished) {
            currectViewController=activity;
        }];
    }
}
//要验证登录
- (IBAction)petsRightAction:(UIButton *)sender {
    HSPAccount *user=[HSPAccountTool account];
    if (user.userTokenid) {
        JZDsPetsPartyViewController *partyOfMe=[[JZDsPetsPartyViewController alloc] initWithNibName:@"JZDsPetsPartyViewController" bundle:nil];
        JZDNavgationViewController *nav=[[JZDNavgationViewController alloc] initWithNavigationBarClass:[JZDNavgationBar class] toolbarClass:nil];
        nav.viewControllers=@[partyOfMe];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }else{
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:nil message:@"登录后才能查看个人内容" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:@"放弃", nil];
        a.tag=100;
        [a show];
    }
}

/**
 *  UIAlertView 代理
 */

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((alertView.tag==100&&buttonIndex==0)) {
        HSPLoginViewController *login=[[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        HSPNavigationController *nav=[[HSPNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    if (buttonIndex==1&&alertView.tag!=100) {
        HSPLoginViewController *login=[[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        HSPNavigationController *nav=[[HSPNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

- (IBAction)petsLeftAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)publishBrn:(UIButton *)sender {
    HSPAccount *user=[HSPAccountTool account];
    if (!user.userTokenid) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"登录后才能发表内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        return;
    }
    JZDPublishViewController *publish=[[JZDPublishViewController alloc] initWithNibName:@"JZDPublishViewController" bundle:nil];
    publish.typeString=@"1";
    JZDPublishBBSViewController *bbsPublish=[[JZDPublishBBSViewController alloc] initWithNibName:@"JZDPublishBBSViewController" bundle:nil];
    if (_topSegment.selectedSegmentIndex==0) {
        JZDNavgationViewController *nav=[[JZDNavgationViewController alloc] initWithNavigationBarClass:[JZDNavgationBar class] toolbarClass:nil];
        nav.viewControllers=@[publish];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }else{
        JZDNavgationViewController *nav=[[JZDNavgationViewController alloc] initWithNavigationBarClass:[JZDNavgationBar class] toolbarClass:nil];
        nav.viewControllers=@[bbsPublish];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

@end
