//
//  ZYPRegiseterViewController.m
//  HaoLin
//
//  Created by mac on 14-8-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPRegiseterViewController.h"

@interface ZYPRegiseterViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    ZYPLoginAndRegisterManger *regiSter;
}
@property (nonatomic, strong)NSString *userid;
@end

@implementation ZYPRegiseterViewController

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
        self.scrollView.contentSize  = CGSizeMake(320, 500);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.scrollView.frame = CGRectMake(0, 64, 320, 416);
        self.scrollView.contentSize  = CGSizeMake(320, 500);
    }
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    regiSter = [ZYPLoginAndRegisterManger shareManger];
    //  添加手势，取消键盘的第一响应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}
//  手势方法
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self.passWord resignFirstResponder];
    [self.phoneNumber resignFirstResponder];
    [self.samePassWord resignFirstResponder];
    [self.getAuthenticationNumber resignFirstResponder];
    [self.nickName resignFirstResponder];
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
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getAutheNumber:(id)sender
{
    
}
- (IBAction)nextStep:(id)sender
{
    //  显示加载图标
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [regiSter registerWithUserName:self.phoneNumber.text  password:self.passWord.text nickName:self.nickName.text withJSON:^(id responeObjects) {
        //  隐藏加载图标
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([responeObjects isKindOfClass:[NSDictionary class]] ) {
             NSDictionary *dic = responeObjects;
            NSString *code = [dic objectForKey:@"code"];
            if ([code isEqualToString:@"0"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"点击去人进入下一页完善资料？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                self.userid = [dic objectForKey:@"user_id"];
                [alert show];
            }else if ([code isEqualToString:@"-2"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册失败" message:@"请重新注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else if ([code isEqualToString:@"1005"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该用户已存在" message:@"请重新注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"服务器问题" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
//  uialert 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        ZYPRegWriteInformationVC *writeVC = [[ZYPRegWriteInformationVC alloc] initWithNibName:@"ZYPRegWriteInformationVC" bundle:nil];
        writeVC.user_id = self.userid;
        [self.navigationController pushViewController:writeVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
