//
//  ZYPOverViewController.m
//  HaoLin
//
//  Created by mac on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPOverViewController.h"

@interface ZYPOverViewController ()
{
    HSPAccount *account;
}
@end

@implementation ZYPOverViewController

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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您已成功提交资料哦亲" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    account = [HSPAccountTool account];
    if ([account.userTokenid length] > 0)
    {
        [self.loginBtn setTitle:@"点击商家主界面" forState:UIControlStateNormal];
    }else
    {
        [self.loginBtn setTitle:@"点击马上登陆" forState:UIControlStateNormal];
    }
    // Do any additional setup after loading the view from its nib.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 240, 200)];
    label.text = @"信息资料提交成功,请耐心等待审核吧!";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.layer.borderWidth= 1;
    label.layer.cornerRadius = 5;
    label.numberOfLines = 0;
    [self.view addSubview:label];
}
//  label自适应高度
- (CGFloat)heightOfLabelFromString:(NSString *)text
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGSize size1 = [text boundingRectWithSize:CGSizeMake(280, 0) options:  NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    return size1.height;
}
- (IBAction)login:(id)sender
{
    if ([account.userTokenid length] > 0)
    {
        account.user_mark = @"1";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        HSPLoginViewController *view = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
        [ZYPObjectManger shareInstance].tokenID = @"you";
        [self.navigationController pushViewController:view animated:YES];
    }
}

//  完成提交信息
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
