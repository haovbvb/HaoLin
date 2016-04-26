//
//  ZYPOrderReleatedObject.m
//  HaoLin
//
//  Created by mac on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPOrderReleatedObject.h"

@implementation ZYPOrderReleatedObject
- (id)initWithReleatedOrderDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
@end
