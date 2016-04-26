//
//  MQLPushBusinessScopeCellInSendHanDanView.m
//  HaoLin
//
//  Created by MQL on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLPushBusinessScopeCellInSendHanDanView.h"

@interface MQLPushBusinessScopeCellInSendHanDanView ()

@property (nonatomic, strong) CLLocation *businessLocation;

@property (nonatomic, weak) IBOutlet UILabel *businessLocationLab;
@property (nonatomic, weak) IBOutlet UIButton *setBusinessLocationBtn;


-(IBAction)setBusinessLocationBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;


@end

@implementation MQLPushBusinessScopeCellInSendHanDanView

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
    
    if (personalHanDanDataManage.pushBusinessScope == nil) {
        
        self.businessLocationLab.text = @"当前位置附近";
        
    }else{
        
        self.businessLocationLab.text = @"所选位置附近";
        
    }
}

#pragma mark -- MQLPushBusinessScopeCellInSendHanDanView函数扩展

-(IBAction)setBusinessLocationBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(setBusinessLocationBtnClicked)]) {
        
        [self.delegate setBusinessLocationBtnClicked];
    }
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    
    [self.setBusinessLocationBtn setImage:[UIImage imageNamed:@"MQLBusinessLocateNormalBtn"] forState:UIControlStateNormal];
    [self.setBusinessLocationBtn setImage:[UIImage imageNamed:@"MQLBusinessLocateSelectedBtn"] forState:UIControlStateHighlighted];
    
}

@end
