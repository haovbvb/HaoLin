//
//  MQLCellOfSection6InShiWuConfirmTableView.m
//  HaoLin
//
//  Created by MQL on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCellOfSection6InShiWuConfirmTableView.h"

@interface MQLCellOfSection6InShiWuConfirmTableView ()<UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *sumLab;
@property (nonatomic, weak) IBOutlet UIButton *payBtn;
@property (nonatomic, weak) IBOutlet UIButton *confirmBtn;

-(IBAction)hanDanAgainBtnClicked:(id)sender;
-(IBAction)payBtnClicked:(id)sender;
-(IBAction)confirmBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  初始化控件内容
 */
-(void)initializeControlContent;

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag;

@end

@implementation MQLCellOfSection6InShiWuConfirmTableView

- (void)awakeFromNib
{
    // Initialization code
    [self customInitialization];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

#pragma mark -- MQLCellOfSection6InShiWuConfirmTableView扩展函数

-(IBAction)hanDanAgainBtnClicked:(id)sender
{
    [self.ownerViewController.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)payBtnClicked:(id)sender
{
    
}

-(IBAction)confirmBtnClicked:(id)sender
{
    //先判断是否有商品被选中
    BOOL isSelected = NO;
    
    for (int i = 0; i < [self.confirmOrderFormDataManage.goodDataManage countOfArray]; i++) {
        
        MQLGoodItemInfo *item = [self.confirmOrderFormDataManage.goodDataManage itemInArray:i];
        if (item.isSelected) {
            
            isSelected = YES;
            break;
        }
    }
    
    if (isSelected) {
        
        if ([self.delegate respondsToSelector:@selector(shiWuConfirmOrderFormSubmit)]) {
            
            [self.delegate shiWuConfirmOrderFormSubmit];
        }
    }else{
        
        [self showAlertViewWithTitle:@"提示" msg:@"请选择商品." tag:-1];
    }

}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    
}

/**
 *  初始化控件内容
 */
-(void)initializeControlContent
{
    float sum = 0.0;
    int count =[self.confirmOrderFormDataManage.goodDataManage countOfArray];
    for (int i = 0; i < count; i++) {
        
        MQLGoodItemInfo *goodItemInfo = [self.confirmOrderFormDataManage.goodDataManage itemInArray:i];
        if (goodItemInfo.isSelected) {
            
            sum += goodItemInfo.goods_price.floatValue * goodItemInfo.goods_num.intValue;
        }
        
    }
    self.sumLab.text = [NSString stringWithFormat:@"金额：￥%.2f", sum];
    
    MQLPayModeItemInfo *payModeItemInfo = [self.confirmOrderFormDataManage.payModeDataManage itemInArray:1];
    if (payModeItemInfo.isSelected) {
        
        self.payBtn.hidden = YES;
        self.confirmBtn.hidden = NO;
        
    }else{
        
        self.payBtn.hidden = NO;
        self.confirmBtn.hidden = YES;
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = tag;
    [alert show];
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}


@end
