//
//  HSPSettingHeadIconView.h
//  HaoLin
//
//  Created by PING on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSPUserInfo;

@interface HSPSettingHeadIconView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headIcon;

@property (nonatomic, strong) HSPUserInfo *userInfo;

@end
