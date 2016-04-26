//
//  MQLPayModeDataManage.h
//  HaoLin
//
//  Created by MQL on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MQLPayModeItemInfo;
@interface MQLPayModeDataManage : NSObject

@property (nonatomic, strong) NSMutableArray *array;    //支付方式列表

/**
 *  获取数组元素总数
 *
 *  @return
 */
-(int)countOfArray;

/**
 *  添加支付方式项到数组
 *
 *  @param item
 */
-(void)addItemToArray:(MQLPayModeItemInfo*)item;

/**
 *  获取指定元素
 *
 *  @param index
 *
 *  @return
 */
-(MQLPayModeItemInfo*)itemInArray:(int)index;

/**
 *  取消选择项的选中状态
 */
-(void)cancelSelectedItem;


@end