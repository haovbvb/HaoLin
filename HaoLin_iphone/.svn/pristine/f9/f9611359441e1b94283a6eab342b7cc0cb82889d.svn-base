//
//  JZDCheckButton.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZDCheckButtonDelegate;

@interface JZDCheckButton : UIButton

@property (nonatomic,assign) BOOL Checked;
@property (nonatomic,weak) __weak id<JZDCheckButtonDelegate> delegate;

@property (nonatomic,assign) CGRect buttonImageRect;
@property (nonatomic,assign) CGRect buttonTitleRect;
@end

@protocol JZDCheckButtonDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(JZDCheckButton *)checkbox checked:(BOOL)checked;

@end
