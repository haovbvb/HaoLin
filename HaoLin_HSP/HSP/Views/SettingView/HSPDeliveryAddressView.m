//
//  HSPDeliveryAddressView.m
//  HaoLin
//
//  Created by PING on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPDeliveryAddressView.h"

@interface HSPDeliveryAddressView ()

@end

@implementation HSPDeliveryAddressView
@synthesize userInfoItem = _userInfoItem;

- (HSPUserInfo *)userInfoItem
{
    return _userInfoItem;
}

- (void)setUserInfoItem:(HSPUserInfo *)userInfoItem
{
    _userInfoItem = userInfoItem;
    
    if (userInfoItem.delivery_address) {
        _addressLabel.text = userInfoItem.delivery_address;
    }else{
        _addressLabel.text = @"";
    }
    _addressLabel.numberOfLines = 0;
    [_addressLabel sizeToFit];
}

@end
