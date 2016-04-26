//
//  HSPProfileGroup.h
//  HaoLin
//
//  Created by PING on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSPProfileGroup : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;

@property (nonatomic, strong) NSArray *items;

- (instancetype)initwithDict:(NSDictionary *)dict;
+ (instancetype)ProfileGroupWithDict:(NSDictionary *)dict;

/**
 *  加载Plist所有分组数据
 */
+ (NSArray *)groupsWithName:(NSString *)name;

@end
