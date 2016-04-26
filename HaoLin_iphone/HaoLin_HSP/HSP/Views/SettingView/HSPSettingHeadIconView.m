//
//  HSPSettingHeadIconView.m
//  HaoLin
//
//  Created by PING on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPSettingHeadIconView.h"

@interface HSPSettingHeadIconView ()

@end

@implementation HSPSettingHeadIconView
@synthesize userInfo = _userInfo;

- (HSPUserInfo *)userInfo
{
    return _userInfo;
}


- (void)setUserInfo:(HSPUserInfo *)userInfo
{
    _userInfo = userInfo;
    if (userInfo.tempHeadImg != nil) {
        _headIcon.image = [UIImage circleImageWithName:userInfo.tempHeadImg borderWidth:0.1 borderColor:nil];
    }else{
        NSURL *url = [NSURL URLWithString:userInfo.headimg];
        _headIcon.image = [UIImage circleImageWithName:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]] borderWidth:0.1 borderColor:nil];
    }
}


@end
