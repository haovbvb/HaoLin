//
//  JZDEvaluateViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDEvaluateViewController.h"

@interface JZDEvaluateViewController ()<UITextViewDelegate,UIAlertViewDelegate>
{
    JZDModuleHttpRequest *request;
}
@end

@implementation JZDEvaluateViewController

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
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    self.title=@"评价";
    request=[JZDModuleHttpRequest sharedInstace];
    _evaluateContent.layer.masksToBounds=YES;
    _evaluateContent.layer.cornerRadius=5;
    _evaluateContent.contentInset=UIEdgeInsetsMake(-65, 0, 0, 0);
}

-(void)back
{
    [_evaluateContent resignFirstResponder];
    if (_evaluateContent.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您还没有评价,确实要放弃么." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"放弃", nil];
        [alert show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _assistlable.hidden=YES;
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0) {
        _assistlable.hidden=NO;
    }else{
        _assistlable.hidden=YES;
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _assistlable.hidden=NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)evaluateAction:(UIButton *)sender {
    HSPAccount *user=[HSPAccountTool account];
//    JZDPushSingl *singl=[JZDPushSingl sharedInstance];
    NSString *uid,*tid;
    if (user.user_id) {
        uid=user.user_id;
        tid=user.userTokenid;
    }else{
        uid=@"";
        tid=@"";
    }
    if (!_evaluateContent.text.length) {
        JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
        [alert popAlert:@"评价内容不能为空"];
        return;
    }
    NSDictionary *dic=@{@"user_id":uid,@"group_id":_groupId,@"content":_evaluateContent.text,@"code":@"0",@"tokenid":tid};
    __weak JZDEvaluateViewController *wself=self;
    [request connectionREquesturl:Evaluate withPostDatas:dic withDelegate:nil withBackBlock:^(id backDictionary, NSError *error) {
        [wself backInfo:backDictionary];
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)backInfo:(NSDictionary *)dic
{
    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    __weak typeof(self) wself=self;
    if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
        [alert popAlert:@"评论成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wself.navigationController popViewControllerAnimated:YES];
        });
    }else{
        [alert popAlert:[dic objectForKey:@"message"]];
        return;
    }
}

@end
