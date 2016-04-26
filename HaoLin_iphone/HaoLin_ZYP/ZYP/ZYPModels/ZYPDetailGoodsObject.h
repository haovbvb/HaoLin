//
//  ZYPDetailGoodsObject.h
//  HaoLin
//
//  Created by mac on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPDetailGoodsObject : NSObject
@property (nonatomic, strong)NSString *goods_id;//商品id
@property (nonatomic, strong)NSString *cat_id;//商品分类
@property (nonatomic, strong)NSString *goods_name;//商品名字
@property (nonatomic, strong)NSString *goods_img;//商品照片
@property (nonatomic, strong)NSString *goods_price;//商品价格
- (id)initDetailGoodsObjectWithDic:(NSDictionary *)dic;

@end
