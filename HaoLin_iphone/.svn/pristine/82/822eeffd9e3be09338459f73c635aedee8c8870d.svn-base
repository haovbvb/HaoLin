//
//  MQLShiWuConfirmOrderFormView.m
//  HaoLin
//
//  Created by MQL on 14-9-17.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLShiWuConfirmOrderFormView.h"

@interface MQLShiWuConfirmOrderFormView ()<UITableViewDataSource,
                                        UITableViewDelegate,
                                        MQLCellOfSection3InShiWuConfirmTableViewDelegate,
                                        MQLCellOfSection1InShiWuConfirmTableViewDelegate,
                                        MQLCellOfSection6InShiWuConfirmTableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *shiWuConfirmTableView;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  注册通知
 */
-(void)registerNotifications;

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag;


@end

@implementation MQLShiWuConfirmOrderFormView

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

-(void)setConfirmOrderFormDataManage:(MQLShiWuOrFuWuConfirmOrderFormDataManage *)confirmOrderFormDataManage
{
    _confirmOrderFormDataManage = confirmOrderFormDataManage;
    
}

-(void)setOwnerViewController:(UIViewController *)ownerViewController
{
    _ownerViewController = ownerViewController;
}

#pragma mark --MQLShiWuConfirmOrderFormView函数扩展
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    
}

/**
 *  注册通知
 */
-(void)registerNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onReceiveNotificationOfSubmitRequestOfShiWuConfirmOrderFormOver:) name:NotificationOfSubmitRequestOfShiWuConfirmOrderFormOver object:nil];
}

-(void)onReceiveNotificationOfSubmitRequestOfShiWuConfirmOrderFormOver:(NSNotification*)notification
{
    [MBProgressHUD hideHUDForView:self animated:YES];
    
    NSDictionary *userInfo = notification.userInfo;
    int code = [[userInfo objectForKey:@"code"]intValue];
    if (code == 0) {
        
        MQLShiWuFinishOrderFormViewController *vc = [[MQLShiWuFinishOrderFormViewController alloc]initWithNibName:@"MQLShiWuFinishOrderFormViewController" bundle:nil];
        vc.submitResponseData = [userInfo objectForKey:@"data"];
        [self.ownerViewController.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        NSString *msg = [userInfo objectForKey:@"message"];
        [self showAlertViewWithTitle:@"提示" msg:msg tag:-1];
    }
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark -- UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    switch (section) {
        case 0:
            numberOfRows = 1;
            break;
        case 1:
            numberOfRows = [self.confirmOrderFormDataManage.goodDataManage countOfArray];
            break;
        case 2:
            numberOfRows = 1;
            break;
        case 3:
            numberOfRows = [self.confirmOrderFormDataManage.payModeDataManage countOfArray];
            break;
        case 4:
            numberOfRows = 0;   //代金券本期不做，实际rownum为1
            break;
        case 5:
            numberOfRows = [self.confirmOrderFormDataManage.cashCouponDataManage countOfArray];
            break;
        case 6:
            numberOfRows = 1;
            break;
            
        default:
            break;
    }
    
    return numberOfRows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString *reuseIdentifier = @"reuseIdentifierInSection0";
            MQLCellOfSection0InShiWuConfirmTableView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLCellOfSection0InShiWuConfirmTableView" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            }
            
            cell.confirmOrderFormDataManage = self.confirmOrderFormDataManage;
            
            return cell;
        }
            break;
        case 1:
        {
            static NSString *reuseIdentifier = @"reuseIdentifierInSection1";
            MQLCellOfSection1InShiWuConfirmTableView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLCellOfSection1InShiWuConfirmTableView" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                cell.delegate = self;
            }
            
            MQLGoodItemInfo *item =[self.confirmOrderFormDataManage.goodDataManage itemInArray:indexPath.row];
            cell.goodItemInfo = item;
            cell.isLastIndex = [self.confirmOrderFormDataManage.goodDataManage countOfArray] == indexPath.row + 1 ? YES : NO;
            
            return cell;
        }
            break;
        case 2:
        {
            static NSString *reuseIdentifier = @"reuseIdentifierInSection2";
            MQLCellOfSection2InShiWuConfirmTableView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLCellOfSection2InShiWuConfirmTableView" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            }
            
            cell.confirmOrderFormDataManage = self.confirmOrderFormDataManage;
            
            return cell;
        }
            break;
        case 3:
        {
            static NSString *reuseIdentifier = @"reuseIdentifierInSection3";
            MQLCellOfSection3InShiWuConfirmTableView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLCellOfSection3InShiWuConfirmTableView" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                cell.delegate = self;
                
            }
            
            cell.payModeDataManage = self.confirmOrderFormDataManage.payModeDataManage;
            MQLPayModeItemInfo * payModeItemInfo = [self.confirmOrderFormDataManage.payModeDataManage itemInArray:indexPath.row];
            cell.payModeItemInfo = payModeItemInfo;
            cell.isLastIndex = [self.confirmOrderFormDataManage.payModeDataManage countOfArray] == indexPath.row + 1 ? YES : NO;
            
            return cell;
        }
            break;
        case 4:
        {
            static NSString *reuseIdentifier = @"reuseIdentifierInSection4";
            MQLCellOfSection4InShiWuConfirmTableView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLCellOfSection4InShiWuConfirmTableView" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            }
            
            MQLCashCouponDataManage *cashCouponDataManage = self.confirmOrderFormDataManage.cashCouponDataManage;
            cell.cashCouponDataManage = cashCouponDataManage;
            cell.ownerViewController = self.ownerViewController;
            
            return cell;
        }
            break;
        case 5:
        {
            static NSString *reuseIdentifier = @"reuseIdentifierInSection5";
            MQLCellOfSection5InShiWuConfirmTableView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLCellOfSection5InShiWuConfirmTableView" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            }
            
            MQLCashCouponItemInfo *cashCouponItemInfo = [self.confirmOrderFormDataManage.cashCouponDataManage itemInArray:indexPath.row];
            cell.cashCouponItemInfo = cashCouponItemInfo;
            cell.isFirstIndex = indexPath.row == 0 ? YES : NO;
            
            return cell;
        }
            break;
        case 6:
        {
            static NSString *reuseIdentifier = @"reuseIdentifierInSection6";
            MQLCellOfSection6InShiWuConfirmTableView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if (cell == nil) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLCellOfSection6InShiWuConfirmTableView" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
                cell.delegate = self;
            }
            
            cell.confirmOrderFormDataManage = self.confirmOrderFormDataManage;
            cell.ownerViewController = self.ownerViewController;
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger heightForRow = 0;
    
    switch (indexPath.section) {
        case 0:
            heightForRow = 26 + 62 + 26;
            break;
        case 1:
            heightForRow = 48;
            break;
        case 2:
            heightForRow = 13 + 44 + 26;
            break;
        case 3:
            heightForRow = 50;
            break;
        case 4:
            heightForRow = 53;
            break;
        case 5:
            heightForRow = 95;
            break;
        case 6:
            heightForRow = 13 + 47 + 13;
            break;
            
        default:
            break;
    }
    
    return heightForRow;
}

#pragma mark -- MQLCellOfSection3InShiWuConfirmTableViewDelegate

-(void)selectedByUser
{
    [self.shiWuConfirmTableView reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -- MQLCellOfSection1InShiWuConfirmTableViewDelegate

-(void)goodItemInfoChanged
{
    [self.shiWuConfirmTableView reloadSections:[NSIndexSet indexSetWithIndex:6] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -- MQLCellOfSection6InShiWuConfirmTableViewDelegate

/**
 *  提交实物确认订单
 */
-(void)shiWuConfirmOrderFormSubmit
{
    MQLHttpRequestManage *httpRequestManage = [MQLHttpRequestManage instance];
    [httpRequestManage sendSubmitRequestOfShiWuConfirmOrderForm:self.confirmOrderFormDataManage];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

@end
