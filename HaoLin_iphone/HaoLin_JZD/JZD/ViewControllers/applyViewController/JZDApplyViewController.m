//
//  JZDApplyViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//  报名----

#import "JZDApplyViewController.h"

@interface JZDApplyViewController ()<UITextFieldDelegate>
{
    JZDModuleHttpRequest *request;
    JZDCustomAlertView *alert;
}
@end

@implementation JZDApplyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    request = [JZDModuleHttpRequest sharedInstace];
    alert = [JZDCustomAlertView sharedInstace];
    [self uiconfig];
}

-(void)uiconfig
{
    self.title=@"报名";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor, NSForegroundColorAttributeName, nil]];
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_qqOrWeChatField.text isMatchedByRegex:@"[1-9][0-9]{4,}"];
    YYLog(@"*****%@",@([_qqOrWeChatField.text isMatchedByRegex:@"[1-9][0-9]{4,}"]));
}

- (IBAction)applyCommit:(UIButton *)sender {
    if (_phoneNumField.text.length==0) {
        [self lockAnimationForView:_phoneNumField];
    }else if (_qqOrWeChatField.text.length==0){
        [self lockAnimationForView:_qqOrWeChatField];
    }
    //^[1-9]*[1-9][0-9]*$
    if ([_qqOrWeChatField.text isMatchedByRegex:@"[1-9][0-9]{4,}"]) {
        [alert popAlert:@"请输入正确qq号"];
        return;
    }
    HSPAccount *user=[HSPAccountTool account];
    NSDictionary *dic=@{@"user_id": user.user_id,@"group_id":_group_Id,@"tel":_phoneNumField.text,@"qq":_qqOrWeChatField.text,@"des":_describeTextView.text};
    __weak JZDApplyViewController *wself=self;
//    [request connectionREquesturl:ApplyPetsParty withPostDatas:dic withDelegate:nil withBackBlock:^(id backDictionary) {
//        YYLog(@"%@",backDictionary);
//        [wself backInfo:backDictionary];
//    }];
    [request connectionREquesturl:[NSString stringWithFormat:ApplyPetsParty,user.userTokenid] withPostDatas:dic withDelegate:nil withBackBlock:^(id backDictionary, NSError *error) {
//        YYLog(@"%@",backDictionary);
        [wself backInfo:backDictionary];
    }];
}

-(void)backInfo:(id)backDictionary
{
    if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [alert popAlert:@"报名成功,请等待审核"];
    }else if([[backDictionary objectForKey:@"code"] isEqualToString:@"1120"]){
        [alert popAlert:@"你已经申请过并在审核中"];
    }else if ([[backDictionary objectForKey:@"code"] isEqualToString:@"1123"]){
        [alert popAlert:@"手机号错误"];
    }else if ([[backDictionary objectForKey:@"code"] isEqualToString:@"-2"]){
        [alert popAlert:@"内容不能这空"];
    }else{
        [alert popAlert:[backDictionary objectForKey:@"message"]];
    }
}

-(void)lockAnimationForView:(UIView *)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:1];
    [lbl addAnimation:animation forKey:nil];
}

@end
