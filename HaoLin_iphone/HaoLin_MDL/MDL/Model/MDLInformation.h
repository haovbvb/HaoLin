//
//  MDLInformation.h
//  HaoLin
//
//  Created by apple on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDLInformation : NSObject

@property(nonatomic,retain)NSString *goods_num;            //返回数量
@property(nonatomic,retain)NSString *goods_id;             //商品ID
@property(nonatomic,retain)NSString *goods_price;          //商品价钱

@property (nonatomic,retain)NSMutableArray * goodsubarry;

@end
