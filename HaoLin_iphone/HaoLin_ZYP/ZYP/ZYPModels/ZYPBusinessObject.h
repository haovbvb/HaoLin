//
//  ZYPBusinessObject.h
//  HaoLin
//
//  Created by mac on 14-9-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPBusinessObject : NSObject
@property (nonatomic, strong)NSString *merchant_id;//商户id
@property (nonatomic, strong)NSString *thumb;//商铺缩略图
@property (nonatomic, strong)NSString *range_type;//商铺类型（1.实物，2.服务）
@property (nonatomic, strong)NSString *merchant_name;//商铺名称
@property (nonatomic, strong)NSString *axis;//商铺坐标
@property (nonatomic, strong)NSString *shop_address;//商户地址
@property (nonatomic, strong)NSString *score;//总评分
@property (nonatomic, strong)NSString *comment_num;//评价总数
@property (nonatomic, strong)NSString *phone;//联系电话
@property (nonatomic, strong)NSString *distance;//用户到商铺之间的距离，当参数axis为空时，该返回为-1，标识无法计算出距离
- (id)initBusinessObjectWithDic:(NSDictionary *)dic;
@end
