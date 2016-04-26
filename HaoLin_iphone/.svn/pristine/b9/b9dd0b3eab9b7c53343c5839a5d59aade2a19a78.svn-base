//
//  MQLGoodDataManage.m
//  HaoLin
//
//  Created by MQL on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLGoodDataManage.h"

@implementation MQLGoodDataManage

-(id)init
{
    self = [super init];
    if (self) {
        
        _array = [NSMutableArray array];
    }
    return self;
}

/**
 *  获取数组元素总数
 *
 *  @return
 */
-(int)countOfArray
{
    return [self.array count];
}

/**
 *  添加商品项到数组
 *
 *  @param item
 */
-(void)addItemToArray:(MQLGoodItemInfo*)item
{
    [self.array addObject:item];
}

/**
 *  获取指定元素
 *
 *  @param index
 *
 *  @return
 */
-(MQLGoodItemInfo*)itemInArray:(int)index
{
    if (self.countOfArray > 0) {
        
        if (index < self.countOfArray && index >=0) {
            
            return [self.array objectAtIndex:index];
        }
    }
    
    return nil;
}

@end
