//
//  MDLgoodsdata.h
//  HaoLin
//
//  Created by apple on 14-9-4.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDLgoodsdata : NSObject


@property (nonatomic,retain)NSMutableArray  *goodsdataarry; //分类下子类内容

@property (nonatomic,retain)NSString *goodsid;             //商品ID
@property (nonatomic,retain)NSString *goodsname;           //商品名称
@property (nonatomic,retain)NSString *goodsprice;          //商品价格
@property (nonatomic,retain)NSString *goodspid;            //分类ID
@property (nonatomic,retain)NSString *goodsnum;            //商品数量
@property (nonatomic,retain)NSString *goodsxinprice;       //商品新价格

@end
