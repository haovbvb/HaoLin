//
//  ZYPDetailGoodsObject.m
//  HaoLin
//
//  Created by mac on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPDetailGoodsObject.h"

@implementation ZYPDetailGoodsObject
- (id)initDetailGoodsObjectWithDic:(NSDictionary *)dic
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
