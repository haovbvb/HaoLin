//
//  HSPProfileGroup.m
//  HaoLin
//
//  Created by PING on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPProfileGroup.h"

@implementation HSPProfileGroup

- (instancetype)initwithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.header = dict[@"header"];
        self.footer = dict[@"footer"];
        NSArray *array = dict[@"items"];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *d in array) {
            HSPProfileItem *item = [HSPProfileItem ProfileItemWithDict:d];
            [arrayM addObject:item];
        }
        self.items = arrayM;
    }
    return self;
}

+ (instancetype)ProfileGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initwithDict:dict];
}

+ (NSArray *)groupsWithName:(NSString *)name
{
    // 加载Plist
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
    NSArray *array = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self ProfileGroupWithDict:dict]];
    }
    return arrayM;
}

@end
