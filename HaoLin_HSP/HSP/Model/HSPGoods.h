//
//  HSPGoods.h
//  HaoLin
//
//  Created by PING on 14-9-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSPGoods : NSObject

/**
 *  "annex_id": "51",
 "order_id": "63",
 "goods_id": "1",
 "goods_name": "黑人牙膏300克装",
 "goods_num": "10",
 "goods_price": "20.00"
 */

@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *goods_price;

@end
