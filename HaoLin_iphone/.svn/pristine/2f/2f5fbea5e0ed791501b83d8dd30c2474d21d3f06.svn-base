//
//  MQLServiceChargeCellInSendHanDanView.m
//  HaoLin
//
//  Created by MQL on 14-8-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLServiceChargeCellInSendHanDanView.h"

@interface MQLServiceChargeCellInSendHanDanView ()<MQLServiceChargeSelectorViewDelegate>



@property (nonatomic, weak) IBOutlet UIView *serviceChargeSelectorViewContainer;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加ServiceChargeSelectorView
 */
-(void)addServiceChargeSelectorView;


@end

@implementation MQLServiceChargeCellInSendHanDanView

-(void)dealloc
{
    
}

- (void)awakeFromNib
{
    // 自定义初始化
    [self customInitialization];
    
}

-(void)setPersonalHanDanDataManage:(MQLPersonalHanDanDataManage *)personalHanDanDataManage
{
    _personalHanDanDataManage = personalHanDanDataManage;
    
    //添加ServiceChargeSelectorView
    [self addServiceChargeSelectorView];
}

#pragma mark --MQLServiceChargeCellInSendHanDanView函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    
}

/**
 *  添加ServiceChargeSelectorView
 */
-(void)addServiceChargeSelectorView
{
    MQLServiceChargeSelectorView *view = [[[NSBundle mainBundle]loadNibNamed:@"MQLServiceChargeSelectorView" owner:nil options:nil]lastObject];
    view.delegate = self;
    view.serviceCharge = self.personalHanDanDataManage.serviceCharge;
    view.frame = self.serviceChargeSelectorViewContainer.bounds;
    [self.serviceChargeSelectorViewContainer addSubview:view];
}

#pragma mark -- MQLServiceChargeSelectorViewDelegate

-(void)serviceChargeSelectorValueChanged:(int)value
{
    self.personalHanDanDataManage.serviceCharge = value;
}

@end
