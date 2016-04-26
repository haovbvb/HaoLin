//
//  MQLShiWuFinishOrderFormView.m
//  HaoLin
//
//  Created by MQL on 14-9-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLShiWuFinishOrderFormView.h"

@interface MQLShiWuFinishOrderFormView ()

@property (nonatomic, weak) IBOutlet UIView *navView;
@property (nonatomic, weak) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, weak) IBOutlet UILabel *finishNoteLab;

@property (nonatomic, weak) IBOutlet UIView *tapView;
@property (nonatomic, weak) IBOutlet UILabel *telLab;


-(IBAction)backBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加tap手势
 */
-(void)addTapGesture;


@end

@implementation MQLShiWuFinishOrderFormView

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
    
    //添加tap手势
    [self addTapGesture];
    
    
}

-(void)setOwnerViewController:(UIViewController *)ownerViewController
{
    _ownerViewController = ownerViewController;
    
}

-(void)setSubmitResponseData:(NSDictionary *)submitResponseData
{
    _submitResponseData = submitResponseData;
    
    NSString *merchant_mobile = [submitResponseData objectForKey:@"merchant_mobile"];
    NSString *merchant_phone = [submitResponseData objectForKey:@"merchant_phone"];
    
    if (merchant_phone.length > 0) {
        
        self.telLab.text = merchant_phone;
    }else{
        
        self.telLab.text = merchant_mobile;
    }
    
}

#pragma mark -- MQLShiWuFinishOrderFormView 函数扩展

-(IBAction)backBtnClicked:(id)sender
{
    [self.ownerViewController.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.navView.backgroundColor = BGOrangeColor;
    self.finishNoteLab.text = @"您已成功完成订单，您预定的物品马上将会送达给您，请您耐心等待，建议您收到货后，再确认收货，否则可能收不到货物。";
    [self.finishNoteLab sizeToFit];
    
    self.telLab.textColor = BGOrangeColor;
    
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
