//
//  MQLHanDanNoResponseView2.m
//  HaoLin
//
//  Created by MQL on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLHanDanNoResponseView2.h"

@interface MQLHanDanNoResponseView2 ()

@property (nonatomic, weak) IBOutlet UIButton *contactBusinessBtn;
@property (nonatomic, weak) IBOutlet UIButton *sendHanDanAgainBtn;
@property (nonatomic, weak) IBOutlet UIButton *hanDanAgainBtn;

-(IBAction)contactBusinessBtnClicked:(id)sender;
-(IBAction)sendHanDanAgainBtnClicked:(id)sender;
-(IBAction)hanDanAgainBtnClicked:(id)sender;


/**
 *  自定义初始化
 */
-(void)customInitialization;


@end

@implementation MQLHanDanNoResponseView2

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

#pragma mark -- MQLHanDanNoResponseView2函数扩展

-(IBAction)contactBusinessBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(contactBusinessInHanDanNoResponseView2)]) {
        
        [self.delegate contactBusinessInHanDanNoResponseView2];
    }
}

-(IBAction)sendHanDanAgainBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(sendHanDanAgainInHanDanNoResponseView2)]) {
        
        [self.delegate sendHanDanAgainInHanDanNoResponseView2];
    }
}

-(IBAction)hanDanAgainBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(hanDanAgainInHanDanNoResponseView2)]) {
        
        [self.delegate hanDanAgainInHanDanNoResponseView2];
    }
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    
}

@end
