//
//  ZYPShopNameVC.m
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPShopNameVC.h"

@interface ZYPShopNameVC ()

@end

@implementation ZYPShopNameVC

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
- (IBAction)over:(id)sender
{
    [self prama:@"merchant_name" realNss:self.shopNameTextView.text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    self.titleLabel.backgroundColor = ZYPBGColor;

    // Do any additional setup after loading the view from its nib.
    self.shopNameTextView.text = self.nameText;
    [self.shopNameTextView becomeFirstResponder];
}
- (void)prama:(NSString *)str realNss:(NSString *)source
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak ZYPShopNameVC *nameVC = self;
    HSPAccount *accout = [HSPAccountTool account];

    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&%@=%@",changeBusinessInfor,accout.user_id,str,source];
    NSLog(@"%@",urlString);
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         if ([respondObject isKindOfClass:[NSDictionary class]]) {
             if ([respondObject isKindOfClass:[NSDictionary class]]) {
                 NSDictionary *dic = respondObject;
                 if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
//                     [nameVC alertWithMessage:@"提交成功"];
                     [nameVC.navigationController popViewControllerAnimated:YES];
                 }else
                 {
                     [nameVC alertWithMessage:[dic objectForKey:@"message"]];
                 }
             }
         }else
         {
             [self alertWithMessage:@"信息提交失败"];
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