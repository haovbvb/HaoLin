//
//  HSPProfileCell.m
//  HaoLin
//
//  Created by PING on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPProfileCell.h"


@implementation HSPProfileCell


- (void)setItem:(HSPProfileItem *)item
{
    _item = item;
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    
    if (item.accessory) {
        
        // 用户
        if ([item.accessory isEqualToString:@"UIImage"]) {
            HSPSettingHeadIconView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HSPSettingHeadIconView" owner:nil options:nil] lastObject];
            if (item.userInfo.tempHeadImg) {
                infoView.headIcon.image = [UIImage circleImageWithName:item.userInfo.tempHeadImg borderWidth:0.1 borderColor:nil];
                
            }else{
                NSURL *url = [NSURL URLWithString:item.userInfo.headimg];
                infoView.headIcon.image = [UIImage circleImageWithName:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]] borderWidth:0.1 borderColor:nil];
            }
            self.accessoryView = infoView;
        }else if ([item.accessory isEqualToString:@"nick"]) {
            HSPSettingInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HSPSettingInfoView" owner:nil options:nil] lastObject];
            infoView.userInfoLabel.text = item.userInfo.nickname;
            self.accessoryView = infoView;
        }else if ([item.accessory isEqualToString:@"gender"]) {
            HSPSettingInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HSPSettingInfoView" owner:nil options:nil] lastObject];
            infoView.userInfoLabel.text = item.userInfo.gender;
            self.accessoryView = infoView;
        }else if ([item.accessory isEqualToString:@"qqNumber"]) {
            HSPSettingInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HSPSettingInfoView" owner:nil options:nil] lastObject];
            infoView.userInfoLabel.text = item.userInfo.qq_number;
            self.accessoryView = infoView;
        }else if ([item.accessory isEqualToString:@"email"]) {
            HSPSettingInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HSPSettingInfoView" owner:nil options:nil] lastObject];
            infoView.userInfoLabel.text = item.userInfo.email;
            self.accessoryView = infoView;
        }else if ([item.accessory isEqualToString:@"phone"]) {
            HSPSettingInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HSPSettingInfoView" owner:nil options:nil] lastObject];
            infoView.userInfoLabel.text = item.userInfo.mobile;
            self.accessoryView = infoView;
        }else if ([item.accessory isEqualToString:@"userDesc"]) {
            HSPSettingInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HSPSettingInfoView" owner:nil options:nil] lastObject];
            infoView.userInfoLabel.text = item.userInfo.user_desc;
            self.accessoryView = infoView;
        }else  {
            HSPSettingInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HSPSettingInfoView" owner:nil options:nil] lastObject];
            infoView.userInfoLabel.text = @"";
            self.accessoryView = infoView;
        }
        
    } else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}



@end
