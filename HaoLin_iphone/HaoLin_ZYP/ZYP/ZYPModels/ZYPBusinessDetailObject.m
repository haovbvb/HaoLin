//
//  ZYPBusinessDetailObject.m
//  HaoLin
//
//  Created by mac on 14-9-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPBusinessDetailObject.h"

@implementation ZYPBusinessDetailObject
- (id)initBusinessDetailObjectWithDic:(NSDictionary *)dic
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
