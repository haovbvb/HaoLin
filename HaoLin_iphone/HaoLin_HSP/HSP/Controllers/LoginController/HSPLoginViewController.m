//
//  HSPLoginViewController.m
//  HaoLin
//
//  Created by PING on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPLoginViewController.h"

@interface HSPLoginViewController () <UITextFieldDelegate>

@end

@implementation HSPLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = HSPBgColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _navBgView.backgroundColor = HSPBarBgColor;
    [_loginBtn setBackgroundColor:HSPBarBgColor];
    self.title = @"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor,NSForegroundColorAttributeName, nil]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"HSP_back_nom" highlightedImage:@"HSP_back_down" target:self action:@selector(backBtnClick:)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}


- (IBAction)loginBtnClick:(id)sender {
    
    [self.view endEditing:YES];
    
    if (!_phoneNumber.text.length) {
        [_phoneNumber becomeFirstResponder];
        return;
    }
    if (!_password.text.length) {
        [_password becomeFirstResponder];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = _phoneNumber.text;
//    params[@"password"] = [_password.text md5String];
    params[@"password"] = _password.text;
    params[@"device_type"] = @"2";
    params[@"push_user_id"] = [MQLDeviceDataManage sharedInstance].baiDuPushUserId;
    params[@"channel_id"] = [MQLDeviceDataManage sharedInstance].baiDuPushChannelId;
    
    __weak JZDCustomAlertView *alert = [JZDCustomAlertView sharedInstace];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HSPHttpRequest *request = [HSPHttpRequest Instace];
    [request connectionREquesturl:HSPLoginUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        YYLog(@"backDictionary==%@",backDictionary);
        if ([backDictionary isKindOfClass:[NSError class]]) {
            [alert popAlert:@"登录失败"];
            return;
        }
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
            NSDictionary *dict = [backDictionary objectForKey:@"data"];
            
            [HSPAccount accountWithDict:dict];

            JZDPushSingl *singl=[JZDPushSingl sharedInstance];
            singl.token_idStr = [dict objectForKey:@"Tokenid"];
            singl.userIdStr = [dict objectForKey:@"user_id"];
            
            /**
             *  发送通知，商家界面
             */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil userInfo:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            /**
             *  亚鹏加
             */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"你好" object:nil];
            
        }else{
            [alert popAlert:[backDictionary objectForKey:@"message"]];
        }
        
    }];
}

- (IBAction)registerBtnClick:(id)sender {
    
    HSPRegisterViewController *registerContoller = [[HSPRegisterViewController alloc] initWithNibName:@"HSPRegisterViewController" bundle:nil];
//    HSPNavigationController *nav = [[HSPNavigationController alloc] initWithRootViewController:registerContoller];
    [self.navigationController pushViewController:registerContoller animated:YES];
     
}

- (IBAction)forgetPassword:(UIButton *)sender {
    HSPForgetPasswordController *forgetController = [[HSPForgetPasswordController alloc] initWithNibName:@"HSPForgetPasswordController" bundle:nil];
//    HSPNavigationController *nav = [[HSPNavigationController alloc] initWithRootViewController:forgetController];
    [self.navigationController pushViewController:forgetController animated:YES];
}

- (IBAction)backBtnClick:(UIButton *)sender {
    /**
     *  发送通知，我的和订单界面接收，给A状态为YES,让登陆界面弹出，不至于循环弹出
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"A" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        /**
         *  再次判断A的状态，让我的和订单界面进行交互
         */
        [self performSelector:@selector(a) withObject:nil afterDelay:0.2];
    }];
}

- (void)a
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"log" object:nil];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    LogFunc
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (id obj in _phoneView.subviews) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }
    
    for (id obj in _passwordView.subviews) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }
    

}
@end
