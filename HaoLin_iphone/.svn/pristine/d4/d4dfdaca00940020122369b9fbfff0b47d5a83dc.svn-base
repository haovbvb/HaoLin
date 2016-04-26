//
//  MQLLoginView.m
//  HaoLin
//
//  Created by mac on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLLoginView.h"


@interface MQLLoginView ()

@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, weak) IBOutlet UITextField *phoneNumberTF;
@property (nonatomic, weak) IBOutlet UITextField *pswTF;
@property (nonatomic, weak) IBOutlet UIButton *loginBtn;

@property (nonatomic, weak) IBOutlet UILabel *haiMeiZhuCeLab;
@property (nonatomic, weak) IBOutlet UIButton *zhuCeBtn;
@property (nonatomic, weak) IBOutlet UILabel *baLab;


-(IBAction)btnClicked:(id)sender;
-(IBAction)forgetPswBtnClicked:(id)sender;
-(IBAction)loginBtnClicked:(id)sender;
-(IBAction)zhuCeBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  登陆请求前的一般性检查
 *
 *  @return
 */
-(BOOL)generalCheckBeforeLoginRequest;

/**
 *  显示alert
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertWithTitle:(NSString*)title msg:(NSString*)msg tag:(NSInteger)tag;


@end

@implementation MQLLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    //自定义初始化
    [self customInitialization];
    
}

#pragma mark -- MQLLoginView函数扩展

-(IBAction)btnClicked:(id)sender
{
    [self.ownerViewController.navigationController popViewControllerAnimated:YES];
}

-(IBAction)forgetPswBtnClicked:(id)sender
{
    NSLog(@"忘记密码");
}

-(IBAction)loginBtnClicked:(id)sender
{
    NSLog(@"login");
    if ([self generalCheckBeforeLoginRequest]) {
        
    }
    
}

-(IBAction)zhuCeBtnClicked:(id)sender
{
    NSLog(@"注册");
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.contentScrollView.contentSize = CGSizeMake(320, 504);
    
    [self.backBtn setImage:[UIImage imageNamed:@"MQLBackNormalBtn"] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"MQLBackSelectedBtn"] forState:UIControlStateHighlighted];
    
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"MQLLoginBtnNormalBG"] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"MQLLoginBtnSelectedBG"] forState:UIControlStateHighlighted];
    
    
    NSString *text = @"还没有账户？赶快去";
    CGSize size = [self boundingRectWithSize:CGSizeMake(320, 0) withFont:self.haiMeiZhuCeLab.font withText:text];
    self.haiMeiZhuCeLab.frame = CGRectMake(self.haiMeiZhuCeLab.frame.origin.x,
                                           self.haiMeiZhuCeLab.frame.origin.y,
                                           size.width,
                                           self.haiMeiZhuCeLab.frame.size.height);
    self.zhuCeBtn.frame = CGRectMake(self.haiMeiZhuCeLab.frame.origin.x + size.width,
                                     self.zhuCeBtn.frame.origin.y,
                                     self.zhuCeBtn.frame.size.width,
                                     self.zhuCeBtn.frame.size.height);
    
    self.baLab.frame = CGRectMake(self.zhuCeBtn.frame.origin.x + self.zhuCeBtn.frame.size.width,
                                  self.baLab.frame.origin.y,
                                  self.baLab.frame.size.width,
                                  self.baLab.frame.size.height);

}

- (CGSize)boundingRectWithSize:(CGSize)size withFont:(UIFont*)font withText:(NSString*)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                             options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

/**
 *  登陆请求前的一般性检查
 *
 *  @return
 */
-(BOOL)generalCheckBeforeLoginRequest
{
    BOOL canRequest = YES;
    NSString *msg = @"";
    if (self.phoneNumberTF.text.length == 0) {
        canRequest = NO;
        msg = @"请输入手机号码";
    }else{
        
        if (self.pswTF.text.length == 0) {
            canRequest = NO;
            msg = @"请输入您的密码";
        }
    }
    
    [self showAlertWithTitle:@"提示" msg:msg tag:0];
    
    return canRequest;
}

/**
 *  显示alert
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertWithTitle:(NSString*)title msg:(NSString*)msg tag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
