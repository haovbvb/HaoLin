//
//  ZYPProductDescVc.m
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPProductDescVc.h"

@interface ZYPProductDescVc ()<UITextViewDelegate>

@end

@implementation ZYPProductDescVc

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
    [self prama:@"product_desc" realNss:self.productDescText.text];
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)prama:(NSString *)str realNss:(NSString *)source
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak ZYPProductDescVc *nameVC = self;
    HSPAccount *accout = [HSPAccountTool account];

    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&%@=%@",changeBusinessInfor,accout.user_id,str,source];
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         if ([respondObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *dic = respondObject;
             if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
//                 [nameVC alertWithMessage:@"提交成功"];
                 [nameVC.navigationController popViewControllerAnimated:YES];
             }else
             {
                 [nameVC alertWithMessage:[dic objectForKey:@"message"]];
             }
         }else
         {
             [nameVC alertWithMessage:@"信息上传失败"];
         }
         
     }];
    
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
    self.productDescText.text = self.produceText;
    [self.productDescText becomeFirstResponder];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text length] > 300) {
        return NO;
    }else
    {
        return YES;
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%d",[textView.text length]); 
    if ([textView.text length] > 300)
    {
        [textView resignFirstResponder];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end