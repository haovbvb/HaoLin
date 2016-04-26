//
//  MQLCashCouponDataManage.h
//  HaoLin
//
//  Created by MQL on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MQLCashCouponItemInfo;
@interface MQLCashCouponDataManage : NSObject

@property int pageNumber;                               //当前页码
@property (nonatomic, strong) NSMutableArray *array;    //代金券列表

/**
 *  获取数组元素总数
 *
 *  @return
 */
-(int)countOfArray;

/**
 *  添加代金券项到数组
 *
 *  @param item
 */
-(void)addItemToArray:(MQLCashCouponItemInfo*)item;

/**
 *  获取指定元素
 *
 *  @param index
 *
 *  @return
 */
-(MQLCashCouponItemInfo*)itemInArray:(int)index;


@end
