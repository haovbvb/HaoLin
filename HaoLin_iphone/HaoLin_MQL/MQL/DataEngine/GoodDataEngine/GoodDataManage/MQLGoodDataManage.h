//
//  MQLGoodDataManage.h
//  HaoLin
//
//  Created by MQL on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MQLGoodItemInfo;
@interface MQLGoodDataManage : NSObject

@property (nonatomic, strong) NSMutableArray *array; //商品信息列表

/**
 *  获取数组元素总数
 *
 *  @return
 */
-(int)countOfArray;

/**
 *  添加商品项到数组
 *
 *  @param item
 */
-(void)addItemToArray:(MQLGoodItemInfo*)item;

/**
 *  获取指定元素
 *
 *  @param index
 *
 *  @return
 */
-(MQLGoodItemInfo*)itemInArray:(int)index;



@end
