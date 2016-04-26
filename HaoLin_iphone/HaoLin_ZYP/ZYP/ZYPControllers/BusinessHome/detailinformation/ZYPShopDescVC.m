//
//  ZYPShopDescVC.m
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPShopDescVC.h"

@interface ZYPShopDescVC ()

@end

@implementation ZYPShopDescVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)over:(id)sender
{
    [self prama:@"mer_desc" realNss:self.shopDescTextView.text];
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    self.shopDescTextView.text = self.shopDescText;
    [self.shopDescTextView becomeFirstResponder];
}
- (void)prama:(NSString *)str realNss:(NSString *)source
{
    /**
     *  隐藏加载状态
     */
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak ZYPShopDescVC *nameVC = self;
    HSPAccount *accout = [HSPAccountTool account];

    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&%@=%@",changeBusinessInfor,accout.user_id,str,source];
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         if ([respondObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *dic = respondObject;
             if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                 /**
                  *  隐藏加载状态
                  */
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                 [nameVC alertWithMessage:@"提交成功"];
                 [nameVC.navigationController popViewControllerAnimated:YES];
             }else
             {
                 /**
                  *  隐藏加载状态
                  */
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                 [nameVC alertWithMessage:[dic objectForKey:@"message"]];
             }

         }else
         {
             /**
              *  隐藏加载状态
              */
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             [self alertWithMessage:@"信息上传失败"];
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
