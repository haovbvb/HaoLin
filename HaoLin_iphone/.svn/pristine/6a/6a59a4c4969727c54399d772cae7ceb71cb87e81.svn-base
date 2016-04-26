//
//  MQLCharacterCellInSendHanDanView.m
//  HaoLin
//
//  Created by MQL on 14-8-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCharacterCellInSendHanDanView.h"

@interface MQLCharacterCellInSendHanDanView ()

@property (nonatomic, weak) IBOutlet UILabel *charactersLab;

/**
 *  自定义初始化
 */
-(void)customInitialization;

@end

@implementation MQLCharacterCellInSendHanDanView

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
    
    self.charactersLab.text = personalHanDanDataManage.charaters;
    
}

#pragma mark --MQLCharacterCellInSendHanDanView函数扩展
/**
 *  自定义初始化
 */
-(void)customInitialization
{
    
}

@end
