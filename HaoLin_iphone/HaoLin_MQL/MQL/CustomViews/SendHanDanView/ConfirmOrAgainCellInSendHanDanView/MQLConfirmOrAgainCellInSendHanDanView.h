//
//  MQLConfirmOrAgainCellInSendHanDanView.h
//  HaoLin
//
//  Created by MQL on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLPersonalHanDanDataManage;

@protocol MQLConfirmOrAgainCellInSendHanDanViewDelegate <NSObject>

-(void)confirmSendBtnClicked;
-(void)hanDanAgainBtnClicked;

@end

@interface MQLConfirmOrAgainCellInSendHanDanView : UITableViewCell

@property (nonatomic, strong) MQLPersonalHanDanDataManage *personalHanDanDataManage;
@property (nonatomic, weak) id<MQLConfirmOrAgainCellInSendHanDanViewDelegate> delegate;

@end
