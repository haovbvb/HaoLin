//
//  ZYPorderObject.m
//  HaoLin
//
//  Created by mac on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPorderObject.h"

@implementation ZYPorderObject
//  这里用到kvc
- (id)initWithOrderDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
// 重写该方法，当键值不配对的时候调用，否则会抛出异常
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

@end
