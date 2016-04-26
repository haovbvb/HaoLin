//
//  ZYPOrderDetailObject.h
//  HaoLin
//
//  Created by mac on 14-9-5.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//
/**
 *  {
 code = 0;
 data =     {
 changetime = 0;
 coupons = 0;
 createtime = 1411899568;
 "merchant_id" = 116;
 "merchant_name" = "\U6d69\U5b87";
 merchantinfo =         {
 "merchant_id" = 116;
 "merchant_name" = "\U6d69\U5b87";
 mobile = 123444444;
 phone = "";
 "shop_address" = "\U6d77\U6dc0\U533a\U897f\U4e09\U65d7";
 };
 "order_audio" = "";
 "order_desc" = "\U5c0f\U857e\U6700\U65b0";
 "order_id" = 177;
 "order_sn" = 201409281411899568;
 "order_type" = 2;
 "pay_type" = 2;
 "real_price" = 0;
 "server_price" = 3;
 "should_price" = 0;
 status = 4;
 "user_id" = 110;
 userinfo =         {
 "delivery_address" = "\U5965\U8fd0\U6751\U501a\U6797\U5bb6\U56ed24\U53f7\U697c8\U5355\U5143301";
 mobile = 18911894414;
 nickname = "\U5c0f\U78ca";
 "user_id" = 110;
 };
 };
 message = "\U83b7\U53d6\U6570\U636e\U6210\U529f";
 }
  */
#import <Foundation/Foundation.h>

@interface ZYPOrderDetailObject : NSObject
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
@property (nonatomic, strong)NSString *goodsinfo;//关联数组
@property (nonatomic, strong)NSString *userinfo;//个人信息
@property (nonatomic, strong)NSString *merchantinfo;//商家信息
@property (nonatomic, strong)NSString *delivery_address;//配送地址

- (id)initWithOrderDetailDic:(NSDictionary *)dic;

@end
/**
 {
 code = 0;
 data =     {
 changetime = 0;
 coupons = 0;
 createtime = 1408605035;
 goodsinfo =         (
 {
 "annex_id" = 45;
 "goods_id" = 1;
 "goods_name" = "\U9ed1\U4eba\U7259\U818f300\U514b\U88c5";
 "goods_num" = 10;
 "goods_price" = "20.00";
 "order_id" = 60;
 },
 {
 "annex_id" = 46;
 "goods_id" = 3;
 "goods_name" = "\U70ab\U8fc8\U53e3\U9999\U7cd6100\U514b";
 "goods_num" = 3;
 "goods_price" = "9.50";
 "order_id" = 60;
 }
 );
 "merchant_id" = 102;
 "merchant_name" = "\U5475\U5475";
 merchantinfo =         {
 "merchant_id" = 102;
 "merchant_name" = "\U5475\U5475";
 mobile = 123999999;
 phone = "";
 "shop_address" = "\U6d77\U6dc0\U533a\U897f\U4e09\U65d7";
 };
 "order_audio" = "";
 "order_desc" = "\U60f3\U8981\U4e00\U76d2\U4e2d\U534e\U9999\U70df";
 "order_id" = 60;
 "order_sn" = 201408211408605035;
 "order_type" = 1;
 "pay_type" = 1;
 "real_price" = "228.5";
 "server_price" = 5;
 "should_price" = "228.5";
 status = 5;
 "user_id" = 4;
 userinfo =         {
 "delivery_address" = "\U5317\U4eac\U5e02\U6d77\U6dc0\U533a\U4e2d\U5173\U6751\U521b\U4e1a\U5927\U53a6125125";
 mobile = 15910216409;
 nickname = robin123;
 "user_id" = 4;
 };
 };
 message = "\U83b7\U53d6\U6570\U636e\U6210\U529f";
 }
 
 */