//
//  HSPRegisterViewController.h
//  HaoLin
//
//  Created by PING on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPRegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *registerScrollView;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *phoneCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgain;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)registerBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

- (IBAction)checkGender:(UIButton *)sender;
- (IBAction)agreeBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerBusinessBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeBtn;
- (IBAction)phoneCodeBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *seviceRuleBtn;
- (IBAction)seviceRuleBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *phoneCodeView;

@end
