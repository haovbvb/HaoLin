//
//  MQLConfirmOrAgainCellInSendHanDanView.m
//  HaoLin
//
//  Created by MQL on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLConfirmOrAgainCellInSendHanDanView.h"

@interface MQLConfirmOrAgainCellInSendHanDanView ()

@property (nonatomic, weak) IBOutlet UIButton *confirmSendBtn;
@property (nonatomic, weak) IBOutlet UIButton *hanDanAgainBtn;

-(IBAction)confirmSendBtnClicked:(id)sender;
-(IBAction)hanDanAgainBtnClicked:(id)sender;


/**
 *  自定义初始化
 */
-(void)customInitialization;


@end

@implementation MQLConfirmOrAgainCellInSendHanDanView

-(void)dealloc
{
    
}

- (void)awakeFromNib
{
    // 自定义初始化
    [self customInitialization];
    
}

#pragma mark -- MQLConfirmOrAgainCellInSendHanDanView函数扩展

-(IBAction)confirmSendBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(confirmSendBtnClicked)]) {
        
        [self.delegate confirmSendBtnClicked];
    }
}

-(IBAction)hanDanAgainBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(hanDanAgainBtnClicked)]) {
        
        [self.delegate hanDanAgainBtnClicked];
    }
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    [self.confirmSendBtn setBackgroundImage:[UIImage imageNamed:@"MQLConfirmSendNormalBtn"] forState:UIControlStateNormal];
    [self.confirmSendBtn setBackgroundImage:[UIImage imageNamed:@"MQLConfirmSendSelectedBtn"] forState:UIControlStateHighlighted];
    
    [self.hanDanAgainBtn setBackgroundImage:[UIImage imageNamed:@"MQLHanDanAgainNormalBtn"] forState:UIControlStateNormal];
    [self.hanDanAgainBtn setBackgroundImage:[UIImage imageNamed:@"MQLHanDanAgainSelectedBtn"] forState:UIControlStateHighlighted];
}

@end
