//
//  ZYPPhoneChangeVC.m
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPPhoneChangeVC.h"

@interface ZYPPhoneChangeVC ()

@end

@implementation ZYPPhoneChangeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    self.titleLabel.backgroundColor = ZYPBGColor;

    self.phoneText.text = self.phoneNumber;
    [self.phoneText becomeFirstResponder];
}
- (IBAction)over:(id)sender
{

    [self prama:@"phone" realNss:self.phoneText.text];
}
- (void)prama:(NSString *)str realNss:(NSString *)source
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak ZYPPhoneChangeVC *changeVC = self;
    HSPAccount *accout = [HSPAccountTool account];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&%@=%@",changeBusinessInfor,accout.user_id,str,source];
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
    {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         if ([respondObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = respondObject;
                if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
//                    [changeVC alertWithMessage:@"修改成功"];
                    [changeVC.navigationController popViewControllerAnimated:YES];
                }else
                {
                    [changeVC alertWithMessage:[dic objectForKey:@"message"]];
                }
            }else
            {
                [changeVC alertWithMessage:@"上传失败"];
            }
    }];
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
