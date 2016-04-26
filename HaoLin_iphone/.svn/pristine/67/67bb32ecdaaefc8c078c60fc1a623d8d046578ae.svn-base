//
//  MQLSendAddressInputView.h
//  HaoLin
//
//  Created by MQL on 14-9-30.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLPersonalHanDanDataManage;

@protocol MQLSendAddressInputViewDelegate <NSObject>

-(void)sendAddressInputFinish;

@end

@interface MQLSendAddressInputView : UIView

@property (nonatomic, strong) MQLPersonalHanDanDataManage *personalHanDanDataManage;
@property (nonatomic, weak) id<MQLSendAddressInputViewDelegate> delegate;

/**
 *  注销第一响应
 */
-(void)resignInputTVFirstResponder;


@end
