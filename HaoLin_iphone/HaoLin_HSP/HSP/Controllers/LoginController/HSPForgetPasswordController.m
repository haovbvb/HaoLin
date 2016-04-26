//
//  HSPForgetPasswordController.m
//  HaoLin
//
//  Created by PING on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPForgetPasswordController.h"

@interface HSPForgetPasswordController ()<UITextFieldDelegate>
{
    NSTimer *myTimer;
    int myTimerNum;
    UILabel *timerLabel;
}

@property (nonatomic, copy) NSString *mobileCode;

@end

@implementation HSPForgetPasswordController

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
    
    self.title = @"忘记密码";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor,NSForegroundColorAttributeName, nil]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemImage:@"HSP_back_nom" highlightedImage:@"HSP_back_down" target:self action:@selector(back)];
    [_phoneCodeBtn setBackgroundColor:HSPBarBgColor];
    [_submitBtn setBackgroundColor:HSPBarBgColor];
    
    timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(176, 6, 145, 30)];
    timerLabel.hidden = YES;
    timerLabel.text = @"10秒重新获取";
    timerLabel.textAlignment = NSTextAlignmentCenter;
    timerLabel.textColor = [UIColor whiteColor];
    [self.phoneCodeView addSubview:timerLabel];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_phoneCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}


- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    LogFunc
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[self.view class]]) {
            [v resignFirstResponder];
        }
    }
}

- (IBAction)changePasswordBtnClick:(UIButton *)sender {
    
    __weak JZDCustomAlertView *alert = [JZDCustomAlertView sharedInstace];
    if (!_phone.text.length){
        [_phone becomeFirstResponder];
        return;
    };
    if (!_phoneCode.text.length){
        [_phoneCode becomeFirstResponder];
        return;
    };
    if (!_password.text.length){
        [_password becomeFirstResponder];
        return;
    };
    if (_password.text.length) {
        if (![_password.text isEqualToString:_passwordAgain.text]) {
            [alert popAlert:@"两次输入密码不一样"];
            [_passwordAgain becomeFirstResponder];
            return;
        }
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = _phone.text;
    params[@"mobilecode"] = _phoneCode.text;
    params[@"newpassword"] = _password.text;
    HSPHttpRequest *request = [HSPHttpRequest Instace];
    [request connectionREquesturl:forgetPasswordUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        YYLog(@"back ==%@",backDictionary)
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([backDictionary isKindOfClass:[NSError class]]) {
            [alert popAlert:@"修改失败"];
            return;
        }
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
            [alert popAlert:@"修改成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [alert popAlert:@"修改失败"];
            return;
        }
    }];
}
- (IBAction)phoneCodeBtnClick:(UIButton *)sender {
    __weak JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    if (!_phone.text.length){
        [_phone becomeFirstResponder];
        return;
    }
    BOOL isMobileOrTelNum = [self isMobileOrTel:_phone.text];
    if (!isMobileOrTelNum) {
        [alert popAlert:@"请输入正确的电话号码"];
        [_phone becomeFirstResponder];
        return;
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = _phone.text;
    params[@"sms_type"] = @"2";
    
    HSPHttpRequest *request = [HSPHttpRequest Instace];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        [request connectionREquesturl:HSPMobileCodeUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
            YYLog(@"back ==%@",backDictionary)
            if ([backDictionary isKindOfClass:[NSError class]]) {
                [alert popAlert:@"短信发送失败"];
                return;
            }
            if (![[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
                [alert popAlert:[backDictionary objectForKey:@"message"]];
                return;
            }
            if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
                _mobileCode = [[backDictionary objectForKey:@"data"] objectForKey:@"mobilecode"];
                [self startTime];
            }
            
        }];
        
    }];

}

- (void)startTime
{
    myTimerNum = 10;
    [_phoneCodeBtn setTitle:@"" forState:UIControlStateNormal];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerLoop) userInfo:nil repeats:YES];
    _phoneCodeBtn.userInteractionEnabled = NO;
}

- (void)timerLoop
{
    myTimerNum--;
    timerLabel.hidden = NO;
    timerLabel.text = [NSString stringWithFormat:@"%d秒重新获取",myTimerNum];
    if (myTimerNum == 0) {
        [myTimer invalidate];
        timerLabel.hidden = YES;
        [_phoneCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _phoneCodeBtn.userInteractionEnabled = YES;
    }
    
}

//判断是否是正确的手机格式
- (BOOL)isMobileOrTel:(NSString *)number
{
    //(^(\d{3,4}-)?\d{7,8})$|(13[0-9]{9}) 手机号与电话号同时验证的正则
    // 1[3|5|7|8|][0-9]{9}
    // ^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$
    return [number isMatchedByRegex:@"^(1)[0-9]{10}$"];
}


@end
