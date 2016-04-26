//
//  MQLTryListenCellInSendHanDanView.m
//  HaoLin
//
//  Created by MQL on 14-8-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLTryListenCellInSendHanDanView.h"

@interface MQLTryListenCellInSendHanDanView ()

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, weak) IBOutlet UIButton *tryListenBtn;

-(IBAction)tryListenBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;


@end

@implementation MQLTryListenCellInSendHanDanView

-(void)dealloc
{
    
}

- (void)awakeFromNib
{
    // 自定义初始化
    [self customInitialization];
    
}

#pragma mark --MQLTryListenCellInSendHanDanView函数扩展

-(IBAction)tryListenBtnClicked:(id)sender
{
    
    NSString *filePath = self.personalHanDanDataManage.wavFilePath;
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
    [self.player play];
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    [self.tryListenBtn setBackgroundImage:[UIImage imageNamed:@"MQLHanDanAudioTryListenNormalBtn"] forState:UIControlStateNormal];
    [self.tryListenBtn setBackgroundImage:[UIImage imageNamed:@"MQLHanDanAudioTryListenSelectedBtn"] forState:UIControlStateHighlighted];
}



@end
