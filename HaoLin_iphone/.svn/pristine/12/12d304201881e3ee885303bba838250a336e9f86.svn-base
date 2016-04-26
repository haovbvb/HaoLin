//
//  HSPProfileItem.m
//  HaoLin
//
//  Created by PING on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPProfileItem.h"

@implementation HSPProfileItem
@synthesize userInfo = _userInfo;

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)ProfileItemWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (HSPUserInfo *)userInfo
{
    return _userInfo;
}

@end
