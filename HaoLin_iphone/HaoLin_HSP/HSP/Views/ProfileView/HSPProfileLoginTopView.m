//
//  HSPProfileLoginTopView.m
//  HaoLin
//
//  Created by PING on 14-9-1.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPProfileLoginTopView.h"


@implementation HSPProfileLoginTopView
@synthesize  account= _account;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (HSPAccount *)account
{
    return _account;
}


- (void)setAccount:(HSPAccount *)account
{
    _account = account;
    
    HSPHttpRequest *request = [HSPHttpRequest Instace];
    [request getImageUrl:account.headimg withImage:^(UIImage *img) {
        _headIcon.image = [UIImage circleImageWithName:img borderWidth:0.1 borderColor:nil];
    }];
    
    _nickName.text = account.nickname;
}



@end
