//
//  EvaluateObject.m
//  HaoLin
//
//  Created by mac on 14-9-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "EvaluateObject.h"

@implementation EvaluateObject
- (id)initEvaluateObjectWithDic:(NSDictionary *)dic
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
