//
//  MQLCellOfSection4InShiWuConfirmTableView.m
//  HaoLin
//
//  Created by MQL on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCellOfSection4InShiWuConfirmTableView.h"

@interface MQLCellOfSection4InShiWuConfirmTableView ()

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  初始化控件内容
 */
-(void)initializeControlContent;

/**
 *添加单击手势
 */
-(void)addTapGesture;


@end

@implementation MQLCellOfSection4InShiWuConfirmTableView

- (void)awakeFromNib
{
    // Initialization code
    [self customInitialization];
    
    //添加单击手势
    [self addTapGesture];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCashCouponDataManage:(MQLCashCouponDataManage *)cashCouponDataManage
{
    _cashCouponDataManage = cashCouponDataManage;
    
}

-(void)setOwnerViewController:(UIViewController *)ownerViewController
{
    _ownerViewController = ownerViewController;
    
}

#pragma mark -- MQLCellOfSection4InShiWuConfirmTableView函数扩展

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
    
}

/**
 *添加单击手势
 */
-(void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tap];
}

-(void)onTap:(UITapGestureRecognizer*)tap
{
    NSLog(@"进入代金券选择");//注意结合个人中心里的代金券页面一起考虑处理
}


@end
