//
//  MQLHanDanCharacterInputView.h
//  HaoLin
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MQLHanDanCharacterInputViewDelegate <NSObject>

/**
 *  切换到音频录制
 */
-(void)changeToAudioRecord;

/**
 *  输入完后显示“发送喊单视图”
 */
-(void)showSendHanDanViewAfterInputFinish:(NSString*)charaters;

@end

@interface MQLHanDanCharacterInputView : UIView

@property (nonatomic, weak) id<MQLHanDanCharacterInputViewDelegate> delegate;


@end
