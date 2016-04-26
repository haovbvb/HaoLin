//
//  MQLHanDanNoResponseView1.m
//  HaoLin
//
//  Created by MQL on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLHanDanNoResponseView1.h"

@interface MQLHanDanNoResponseView1 ()

@property (nonatomic, weak) IBOutlet UIButton *sendHanDanAgainBtn;
@property (nonatomic, weak) IBOutlet UIButton *hanDanAgainBtn;

-(IBAction)sendHanDanAgainBtnClicked:(id)sender;
-(IBAction)hanDanAgainBtnClicked:(id)sender;


/**
 *  自定义初始化
 */
-(void)customInitialization;


@end

@implementation MQLHanDanNoResponseView1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    
    //自定义初始化
    [self customInitialization];
    
}

#pragma mark -- MQLHanDanNoResponseView1函数扩展

-(IBAction)sendHanDanAgainBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(sendHanDanAgainInHanDanNoResponseView1)]) {
        
        [self.delegate sendHanDanAgainInHanDanNoResponseView1];
    }
}

-(IBAction)hanDanAgainBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(hanDanAgainInHanDanNoResponseView1)]) {
        
        [self.delegate hanDanAgainInHanDanNoResponseView1];
    }
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    [self.sendHanDanAgainBtn setBackgroundImage:[UIImage imageNamed:@"MQLConfirmSendNormalBtn"] forState:UIControlStateNormal];
    [self.sendHanDanAgainBtn setBackgroundImage:[UIImage imageNamed:@"MQLConfirmSendSelectedBtn"] forState:UIControlStateHighlighted];
    
    [self.hanDanAgainBtn setBackgroundImage:[UIImage imageNamed:@"MQLHanDanAgainNormalBtn"] forState:UIControlStateNormal];
    [self.hanDanAgainBtn setBackgroundImage:[UIImage imageNamed:@"MQLHanDanAgainSelectedBtn"] forState:UIControlStateHighlighted];
}

@end
