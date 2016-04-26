//
//  MQLCellOfSection0InShiWuConfirmTableView.m
//  HaoLin
//
//  Created by MQL on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCellOfSection0InShiWuConfirmTableView.h"

@interface MQLCellOfSection0InShiWuConfirmTableView ()

@property (nonatomic, weak) IBOutlet UILabel *shouHuoRenNameLab;
@property (nonatomic, weak) IBOutlet UILabel *shouHuoRenTelLab;
@property (nonatomic, weak) IBOutlet UILabel *shouHuoRenAddLab;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  初始化控件内容
 */
-(void)initializeControlContent;


@end

@implementation MQLCellOfSection0InShiWuConfirmTableView

- (void)awakeFromNib
{
    // Initialization code
    [self customInitialization];
}

-(void)setConfirmOrderFormDataManage:(MQLShiWuOrFuWuConfirmOrderFormDataManage *)confirmOrderFormDataManage
{
    _confirmOrderFormDataManage = confirmOrderFormDataManage;
    
    [self initializeControlContent];
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
    self.shouHuoRenNameLab.text = [NSString stringWithFormat:@"收货人：%@", self.confirmOrderFormDataManage.user_name];
    self.shouHuoRenTelLab.text = self.confirmOrderFormDataManage.mobile;
    self.shouHuoRenAddLab.text = self.confirmOrderFormDataManage.delivery_address;
    
}

@end
