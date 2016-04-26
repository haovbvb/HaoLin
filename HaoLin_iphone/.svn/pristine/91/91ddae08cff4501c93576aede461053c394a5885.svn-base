//
//  HSPEditViewController.m
//  HaoLin
//
//  Created by PING on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPEditViewController.h"

@interface HSPEditViewController ()

@property (nonatomic, strong) HSPHttpRequest *request;
@property (nonatomic, weak) UITextView *textView;


@end

@implementation HSPEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, 320, 100)];
    textView.text = _submitText;
    textView.font = [UIFont systemFontOfSize:16];
//    textView.contentInset=UIEdgeInsetsMake(-70, 0, 0, 0);
    [self.view addSubview:textView];
    self.textView = textView;
    [self.textView becomeFirstResponder];
}
- (IBAction)submit:(UIButton *)sender
{
    JZDCustomAlertView *alertView = [JZDCustomAlertView sharedInstace];
    
    if ([_submitText isEqualToString:self.textView.text]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    HSPAccount *account = [HSPAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = account.user_id;
    params[@"tokenid"] = account.userTokenid;
    if ([_submitTextId isEqualToString:@"nickname"]) {
        params[@"nickname"] = self.textView.text;
    }else if ([_submitTextId isEqualToString:@"qq_number"]) {
        params[@"qq_number"] = self.textView.text;
//        BOOL isQQ = [self isQQ:self.textView.text];
//        if (!isQQ) {
//            [alertView popAlert:@"请输入正确的QQ号"];
//            return;
//        }
    }else if ([_submitTextId isEqualToString:@"email"]) {
        params[@"email"] = self.textView.text;
        BOOL isEmail = [self isEmail:self.textView.text];
        if (!isEmail) {
            [alertView popAlert:@"请输入正确的邮箱地址"];
            return;
        }
    }else if ([_submitTextId isEqualToString:@"phone"]) {
        params[@"phone"] = self.textView.text;
        BOOL isMobileOrTel = [self isMobileOrTel:self.textView.text];
        if (!isMobileOrTel) {
            [alertView popAlert:@"请输入正确的手机号"];
            return;
        }
    }else if ([_submitTextId isEqualToString:@"user_desc"]) {
        params[@"user_desc"] = self.textView.text;
    }else if ([_submitTextId isEqualToString:@"delivery_address"]) {
        params[@"delivery_address"] = self.textView.text;
    }
    
    __weak JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    [self.request connectionREquesturl:changeUserInfoUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        if ([backDictionary isKindOfClass:[NSError class]]) {
            [alert popAlert:@"修改失败"];
            return;
        }
        
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
            if ([_submitTextId isEqualToString:@"nickname"]) {
                HSPAccount *account = [HSPAccountTool account];
                account.nickname = self.textView.text;
//                [HSPAccountTool saveAccount:account];
            }
            
            [alert popAlert:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [alert popAlert:[backDictionary objectForKey:@"message"]];
        }
    }];
}

//判断是否是正确的手机格式
- (BOOL)isMobileOrTel:(NSString *)number
{
    //(^(\d{3,4}-)?\d{7,8})$|(13[0-9]{9}) 手机号与电话号同时验证的正则
    return [number isMatchedByRegex:@"^(1)[0-9]{10}$"];
}

//判断是否是正确的邮箱格式
- (BOOL)isEmail:(NSString *)number
{
    return [number isMatchedByRegex:@"^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$"];
}

//判断是否是正确的QQ号格式
- (BOOL)isQQ:(NSString *)number
{
    return [number isMatchedByRegex:@"^[1-9]*[1-9][0-9]*$"];
}


#pragma mark - 懒加载
- (HSPHttpRequest *)request
{
    if (!_request) {
        _request = [HSPHttpRequest Instace];
    }
    return _request;
}

@end
