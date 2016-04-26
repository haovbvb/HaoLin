//
//  MQLFuWuConfirmOrderFormView.m
//  HaoLin
//
//  Created by MQL on 14-9-17.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLFuWuConfirmOrderFormView.h"

@interface MQLFuWuConfirmOrderFormView ()

@property (nonatomic, weak) IBOutlet UILabel *finishNoteLab;

@property (nonatomic, weak) IBOutlet UIView *tapView;
@property (nonatomic, weak) IBOutlet UILabel *telLab;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  初始化控件内容
 */
-(void)initializeControlContent;

/**
 *  添加tap手势
 */
-(void)addTapGesture;


@end

@implementation MQLFuWuConfirmOrderFormView

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
    [self customInitialization];
    
    [self addTapGesture];
    
}

-(void)setConfirmOrderFormDataManage:(MQLShiWuOrFuWuConfirmOrderFormDataManage *)confirmOrderFormDataManage
{
    _confirmOrderFormDataManage = confirmOrderFormDataManage;
    
    [self initializeControlContent];
}

-(void)setOwnerViewController:(UIViewController *)ownerViewController
{
    _ownerViewController = ownerViewController;
    
}

#pragma mark -- MQLFuWuConfirmOrderFormView扩展函数
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.telLab.textColor = BGOrangeColor;
}

/**
 *  初始化控件内容
 */
-(void)initializeControlContent
{
    NSString *merchant_name = self.confirmOrderFormDataManage.merchant_name;
    NSString *note = [NSString stringWithFormat:@"您的喊单已被\"%@\"抢单，具体情况可以跟商家具体沟通，谢谢配合！", merchant_name];
    self.finishNoteLab.text = note;
    [self.finishNoteLab sizeToFit];
    
    NSString *merchant_mobile = self.confirmOrderFormDataManage.merchant_mobile;
    NSString *merchant_phone = self.confirmOrderFormDataManage.merchant_phone;
    
    if (merchant_phone.length > 0) {
        
        self.telLab.text = merchant_phone;
    }else{
        
        self.telLab.text = merchant_mobile;
    }
    
}

/**
 *  添加tap手势
 */
-(void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.tapView addGestureRecognizer:tap];
    
}

-(void)onTap:(UITapGestureRecognizer*)tap
{
    NSLog(@"联系商家");
    
    NSString *model = [MQLDeviceDataManage sharedInstance].model;
    if([model isEqualToString:@"iPod touch"]||[model  isEqualToString:@"iPad"]||[model  isEqualToString:@"iPhone Simulator"]){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"好的,知道了" otherButtonTitles:nil,nil];
        [alert show];
        
    }else{
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.telLab.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}



@end
