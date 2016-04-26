//
//  MQLShiWuOrFuWuConfirmOrderFormView.m
//  HaoLin
//
//  Created by MQL on 14-9-16.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLShiWuOrFuWuConfirmOrderFormView.h"

@interface MQLShiWuOrFuWuConfirmOrderFormView ()<UIAlertViewDelegate>

@property (nonatomic, strong) MQLShiWuOrFuWuConfirmOrderFormDataManage *confirmOrderFormDataManage;

@property (nonatomic, weak) IBOutlet UIView *navView;
@property (nonatomic, weak) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, weak) IBOutlet UIButton *reloadBtn;

-(IBAction)backBtnClicked:(id)sender;
-(IBAction)reloadBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  注册通知
 */
-(void)registerNotifications;

/**
 *  启动喊单详情请求
 */
-(void)startHanDanDetailRequest;


/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag;

/**
 *  加载确认订单视图
 */
-(void)loadConfirmOrderFormView;

/**
 *  加载实物确认订单视图
 */
-(void)loadShiWuConfirmOrderFormView;

/**
 *  加载服务确认订单视图
 */
-(void)loadFuWuConfirmOrderFormView;



@end

@implementation MQLShiWuOrFuWuConfirmOrderFormView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

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
    
    //注册通知
    [self registerNotifications];
    
}

-(void)setTalk_id:(NSString *)talk_id
{
    _talk_id = talk_id;
    
    [self startHanDanDetailRequest];
}

#pragma mark -- MQLShiWuOrFuWuConfirmOrderFormView函数扩展

-(IBAction)backBtnClicked:(id)sender
{
    BOOL isShowAlert = YES;
    
    for (UIView *view in self.contentScrollView.subviews) {
        
        if ([view isMemberOfClass:[MQLFuWuConfirmOrderFormView class]]) {
            
            isShowAlert = NO;
            break;
        }
    }
    
    if (isShowAlert) {
        
        [self showAlertViewWithTitle:@"提示" msg:@"您确定要取消订单，重新喊单吗？" tag:100];
    }else{
        
        [self.ownerViewController.navigationController popToRootViewControllerAnimated:YES];
    }

    
}

-(IBAction)reloadBtnClicked:(id)sender
{
    self.reloadBtn.hidden = YES;
    [self startHanDanDetailRequest];
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.navView.backgroundColor = BGOrangeColor;
    //self.contentScrollView.contentSize = CGSizeMake(320, 504);
    
    if (IS_IPHONE_5) {
        
        CGRect frame = self.reloadBtn.frame;
        frame.origin = CGPointMake(110, 202 - 20);
        self.reloadBtn.frame = frame;
        
    }else{
        
        CGRect frame = self.reloadBtn.frame;
        frame.origin = CGPointMake(110, 158 -20);
        self.reloadBtn.frame = frame;
    }
    
}

/**
 *  注册通知
 */
-(void)registerNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onReceiveNotificationOfHanDanDetailRequestOver:) name:NotificationOfHanDanDetailRequestOver object:nil];
}

-(void)onReceiveNotificationOfHanDanDetailRequestOver:(NSNotification*)notification
{
    [MBProgressHUD hideHUDForView:self.contentScrollView animated:YES];
    
    int code = [[notification.userInfo objectForKey:@"code"]intValue];
    if (code == 0) {
        
        self.confirmOrderFormDataManage = [[MQLShiWuOrFuWuConfirmOrderFormDataManage alloc]init];
        [self.confirmOrderFormDataManage parseHanDanDetailRequestResponse:notification.userInfo];
        [self loadConfirmOrderFormView];
        
    }else{
        
        self.reloadBtn.hidden = NO;
        
        NSString *msg = [notification.userInfo objectForKey:@"message"];
        [self showAlertViewWithTitle:@"提示" msg:msg tag:-1];
        
    }
    
    
}

/**
 *  启动喊单详情请求
 */
-(void)startHanDanDetailRequest
{
    MQLHttpRequestManage *manage = [MQLHttpRequestManage instance];
    [manage sendHanDanDetailRequest:_talk_id];
    
    [MBProgressHUD showHUDAddedTo:self.contentScrollView animated:YES];
}

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag
{
    
    UIAlertView *alert = nil;
    if (tag == 100) {
        
        alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
    }else{
        
        alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
    }
    
    alert.tag = tag;
    [alert show];
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        
        if (buttonIndex == 1) {
            
            [self.ownerViewController.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

/**
 *  加载确认订单视图
 */
-(void)loadConfirmOrderFormView
{
    if ([self.confirmOrderFormDataManage.talk_type compare:@"1"] == 0) {//实物
        
        NSLog(@"1");
        [self loadShiWuConfirmOrderFormView];
        
    }else if ([self.confirmOrderFormDataManage.talk_type compare:@"2"] == 0){//服务
        
        NSLog(@"2");
        [self loadFuWuConfirmOrderFormView];
    }
}

/**
 *  加载实物确认订单视图
 */
-(void)loadShiWuConfirmOrderFormView
{
    MQLShiWuConfirmOrderFormView *confirmView = [[[NSBundle mainBundle]loadNibNamed:@"MQLShiWuConfirmOrderFormView" owner:nil options:nil]lastObject];
    confirmView.confirmOrderFormDataManage = self.confirmOrderFormDataManage;
    confirmView.ownerViewController = self.ownerViewController;
    confirmView.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:confirmView];
}

/**
 *  加载服务确认订单视图
 */
-(void)loadFuWuConfirmOrderFormView
{
    MQLFuWuConfirmOrderFormView *confirmView = [[[NSBundle mainBundle]loadNibNamed:@"MQLFuWuConfirmOrderFormView" owner:nil options:nil]lastObject];
    confirmView.ownerViewController = self.ownerViewController;
    confirmView.confirmOrderFormDataManage = self.confirmOrderFormDataManage;
    confirmView.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:confirmView];
}




@end
