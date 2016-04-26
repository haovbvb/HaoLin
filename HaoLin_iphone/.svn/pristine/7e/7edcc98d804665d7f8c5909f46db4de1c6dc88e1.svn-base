//
//  ZYPLoginViewController.m
//  HaoLin
//
//  Created by mac on 14-8-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPLoginViewController.h"

@interface ZYPLoginViewController ()<UITextFieldDelegate>
{
    ZYPLoginAndRegisterManger *login;
}
@end

@implementation ZYPLoginViewController

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
    // Do any additional setup after loading the view from its nib.
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }

    self.navigationController.navigationBar.hidden = YES;
    self.passWord.delegate = self;
    self.phoneNumberTextF.delegate = self;
    //  添加手势，取消键盘的第一响应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    login  = [ZYPLoginAndRegisterManger shareManger];
}
//  手势方法
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self.passWord resignFirstResponder];
    [self.phoneNumberTextF resignFirstResponder];
}
#pragma mark - 代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//  忘记密码
- (IBAction)forgetPassword:(id)sender
{
    ZYPChangePasswordViewController *changeViewC = [[ZYPChangePasswordViewController alloc] initWithNibName:@"ZYPChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:changeViewC animated:YES];
}
//  登陆
- (IBAction)login:(id)sender
{
    [self.phoneNumberTextF resignFirstResponder];
    [self.passWord resignFirstResponder];
    MQLDeviceDataManage *dataManger = [MQLDeviceDataManage sharedInstance];
    //  显示加载图标
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [login loginWithUserName:self.phoneNumberTextF.text password:self.passWord.text userid:dataManger.baiDuPushUserId tokenid:dataManger.baiDuPushChannelId  withJSON:^(id responeObjects) {
        if ([responeObjects isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responeObjects;
            if ([[dic objectForKey:@"code"] intValue] == 0) {
                NSDictionary *sourceDic = [dic objectForKey:@"data"];
                ZYPLoginInformation *loginObject = [[ZYPLoginInformation alloc] initLoginInformationWithDictionary:sourceDic];
                [ZYPObjectManger shareInstance].loginInObject = loginObject;
                
                [ZYPObjectManger shareInstance].state = 0;
                //  隐藏加载图标
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else {
                //  隐藏加载图标
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }];
}
//  注册账号
- (IBAction)registerAccount:(id)sender
{
    ZYPRegiseterViewController *registerViewC = [[ZYPRegiseterViewController alloc] initWithNibName:@"ZYPRegiseterViewController" bundle:nil];
    [self.navigationController pushViewController:registerViewC animated:YES];
    
}
//  返回
- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
