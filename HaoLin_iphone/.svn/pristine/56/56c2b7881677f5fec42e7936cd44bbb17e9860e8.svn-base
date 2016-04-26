//
//  MQLCellOfSection2InShiWuConfirmTableView.m
//  HaoLin
//
//  Created by MQL on 14-9-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCellOfSection2InShiWuConfirmTableView.h"

@interface MQLCellOfSection2InShiWuConfirmTableView ()

@property (nonatomic, weak) IBOutlet UILabel *server_priceLab;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  初始化控件内容
 */
-(void)initializeControlContent;

@end

@implementation MQLCellOfSection2InShiWuConfirmTableView

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

#pragma mark --MQLCellOfSection2InShiWuConfirmTableView函数扩展

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
    self.server_priceLab.text = [NSString stringWithFormat:@"%@元", self.confirmOrderFormDataManage.server_price];
    
}


@end
