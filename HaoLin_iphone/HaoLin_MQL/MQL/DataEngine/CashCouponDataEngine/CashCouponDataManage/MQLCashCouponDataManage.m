//
//  MQLCashCouponDataManage.m
//  HaoLin
//
//  Created by MQL on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCashCouponDataManage.h"

@implementation MQLCashCouponDataManage

-(id)init
{
    self = [super init];
    if (self) {
        
        _pageNumber = -1;
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
 *  添加代金券项到数组
 *
 *  @param item
 */
-(void)addItemToArray:(MQLCashCouponItemInfo*)item
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
-(MQLCashCouponItemInfo*)itemInArray:(int)index
{
    if (self.countOfArray > 0) {
        
        if (index < self.countOfArray && index >=0) {
            
            return [self.array objectAtIndex:index];
        }
    }
    
    return nil;
}



@end
