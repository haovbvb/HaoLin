//
//  ZYPOrderReleatedObject.h
//  HaoLin
//
//  Created by mac on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPOrderReleatedObject : NSObject
@property (nonatomic, strong)NSString *goods_id;//商品id
@property (nonatomic, strong)NSString *goods_name;//商品名称
@property (nonatomic, strong)NSString *goods_num;//商品数量
@property (nonatomic, strong)NSString *goods_price;//商品单价
@property (nonatomic, strong)NSString *annex_id;//

- (id)initWithReleatedOrderDictionary:(NSDictionary *)dic;

@end
