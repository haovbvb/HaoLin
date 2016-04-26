//
//  ZYPorderObject.h
//  HaoLin
//
//  Created by mac on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPorderObject : NSObject
@property (nonatomic, strong)NSString *order_id;//订单id
@property (nonatomic, strong)NSString *order_sn;//	订单编号
@property (nonatomic, strong)NSString *order_type;//订单类型（1.实物类订单，2.服务类订单）
@property (nonatomic, strong)NSString *user_id;//用户（下单人）id
@property (nonatomic, strong)NSString *merchant_id;//商家id
@property (nonatomic, strong)NSString *should_price;//应支付总金额
@property (nonatomic, strong)NSString *real_price;//实际支付总金额
@property (nonatomic, strong)NSString *server_price;//服务费
@property (nonatomic, strong)NSString *pay_type;//支付类型（1:在线支付，2:货到付款，3：其他支付（代金券））
@property (nonatomic, strong)NSString *coupons;//代金券使用（0：未使用代金券，>0：表示使用代金券并显示使用的代金券具体数额）
@property (nonatomic, strong)NSString *order_desc;//订单文字描述
@property (nonatomic, strong)NSString *order_audio;//订单音频描述
@property (nonatomic, strong)NSString *status;//订单状态（0：订单取消，1.已确认，2.未支付，3.已支付，4.已发货，5.已完成，6.已评价）申明：当状态为3，4时表示商家已经发货，用户这时候不能做取消订单操作
@property (nonatomic, strong)NSString *createtime;//订单创建时间
@property (nonatomic, strong)NSString *changetime;//状态更新时间
@property (nonatomic, strong)NSString *goodsinfo;//  关联数组
@property (nonatomic, strong)NSString *cat_name;//  水站
@property (nonatomic, strong)NSString *cat_id;// 水站对应的图片
- (id)initWithOrderDictionary:(NSDictionary *)dic;
@end
