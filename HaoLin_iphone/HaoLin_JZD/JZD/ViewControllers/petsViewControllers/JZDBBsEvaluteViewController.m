//
//  JZDBBsEvaluteViewController.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDBBsEvaluteViewController.h"

@interface JZDBBsEvaluteViewController ()<UITextViewDelegate>

@end

@implementation JZDBBsEvaluteViewController

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
    self.title=@"用户评价";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    [self.navigationItem setLeftItemWithImage:[UIImage imageNamed:@"HSP_back_nom"] selectedImage:[UIImage imageNamed:@"HSP_back_down"] target:self action:@selector(back)];
    _evaluteContent.layer.masksToBounds=YES;
    _evaluteContent.layer.cornerRadius=5;
    _evaluteContent.contentInset=UIEdgeInsetsMake(-65, 0, 0, 0);
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _infoLable.hidden=YES;
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0) {
        _infoLable.hidden=NO;
    }else{
        _infoLable.hidden=YES;
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _infoLable.hidden=NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)evaluate:(UIButton *)sender {
    JZDModuleHttpRequest *request=[JZDModuleHttpRequest sharedInstace];
    JZDCustomAlertView *alert=[JZDCustomAlertView sharedInstace];
    HSPAccount *user=[HSPAccountTool account];
    NSString *uid=@"";
    NSString *tid=@"";
    if (user.user_id) {
        uid=user.user_id;
        tid=user.userTokenid;
    }
    NSDictionary *dic=@{@"user_id": uid,@"posts_id":_posts_id,@"content":_evaluteContent.text,@"tokenid":tid};
    [request connectionREquesturl:[NSString stringWithFormat:EvaluateBBS,user.userTokenid] withPostDatas:dic withDelegate:nil withBackBlock:^(id backDictionary, NSError *error) {
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"1133"]) {
            [alert popAlert:@"登录用户才能评论"];
        }else if([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]){
            [alert popAlert:@"评论成功"];
            __weak typeof(self) wself=self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wself.navigationController popViewControllerAnimated:YES];
            });
        }else if([[backDictionary objectForKey:@"code"] isEqualToString:@"-2"]){
            [alert popAlert:@"评价内容不能为空"];
        }
    }];
}

@end
