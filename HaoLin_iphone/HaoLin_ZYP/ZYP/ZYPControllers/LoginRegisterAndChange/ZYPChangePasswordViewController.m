//
//  ZYPChangePasswordViewController.m
//  HaoLin
//
//  Created by mac on 14-8-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPChangePasswordViewController.h"

@interface ZYPChangePasswordViewController ()<UITextFieldDelegate>
{
    ZYPLoginAndRegisterManger *changePassword;
}
@end

@implementation ZYPChangePasswordViewController

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
        self.scrollView.contentSize = CGSizeMake(320, 600);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.scrollView.frame = CGRectMake(0, 64, 320, 416);
        self.scrollView.contentSize = CGSizeMake(320,500);
    }

    //  添加手势，取消键盘的第一响应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    changePassword = [ZYPLoginAndRegisterManger shareManger];
    
}
//  手势方法
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self.Password resignFirstResponder];
    [self.sameNewPassword resignFirstResponder];
    [self.phoneNumberT resignFirstResponder];
    [self.autheNumberT resignFirstResponder];
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

//  返回上一级
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//  获取验证码
- (IBAction)getAutheNumber:(id)sender
{
    
}
//  确认修改
- (IBAction)makeSureChange:(id)sender
{
    MQLDeviceDataManage *dataManger = [MQLDeviceDataManage sharedInstance];

    [changePassword changePassword:self.Password.text userid:dataManger.baiDuPushAppId tokenid:dataManger.baiDuPushChannelId withJSON:^(id responeObjects) {
        NSDictionary *dic = responeObjects;
        if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
        {
            [self alertWithMessage:[dic objectForKey:@"message"]];
        }else
        {
            [self alertWithMessage:[dic objectForKey:@"message"]];
        }
    }];
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
