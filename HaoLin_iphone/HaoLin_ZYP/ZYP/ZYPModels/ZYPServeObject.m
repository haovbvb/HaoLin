//
//  ZYPServeObject.m
//  HaoLin
//
//  Created by mac on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPServeObject.h"

@implementation ZYPServeObject
- (id)initOrderServerObjectWithDic:(NSDictionary *)dic
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
