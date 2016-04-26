//
//  MQLPayModeDataManage.m
//  HaoLin
//
//  Created by MQL on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLPayModeDataManage.h"

@implementation MQLPayModeDataManage

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
    return self.array.count;
    
}

/**
 *  添加支付方式项到数组
 *
 *  @param item
 */
-(void)addItemToArray:(MQLPayModeItemInfo*)item
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
-(MQLPayModeItemInfo*)itemInArray:(int)index
{
    if (self.countOfArray > 0) {
        
        if (index < self.countOfArray && index >=0) {
            
            return [self.array objectAtIndex:index];
        }
    }
    
    return nil;
}

/**
 *  取消选择项的选中状态
 */
-(void)cancelSelectedItem
{
    for (MQLPayModeItemInfo *item in self.array) {
        
        if (item.isSelected) {
            
            item.isSelected = NO;
            break;
        }
    }
}

@end
