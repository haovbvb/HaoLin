//
//  MQLShiWuOrFuWuConfirmOrderFormDataManage.h
//  HaoLin
//
//  Created by MQL on 14-9-17.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MQLGoodDataManage;
@class MQLCashCouponDataManage;
@class MQLPayModeDataManage;

@interface MQLShiWuOrFuWuConfirmOrderFormDataManage : NSObject

@property (nonatomic, copy) NSString *call_type;    //喊单类型（1、语音，2、文字）
@property (nonatomic, copy) NSString *audio;        //语音存放地址
@property (nonatomic, copy) NSString *call_infos;   //喊单文字信息
@property (nonatomic, copy) NSString *cat_id;       //喊单分类
@property (nonatomic, copy) NSString *delivery_address; //配送地址
@property (nonatomic, copy) NSString *merchant_id;      //商户id
@property (nonatomic, copy) NSString *merchant_mobile;  //商户手机号
@property (nonatomic, copy) NSString *merchant_name;    //商户名称
@property (nonatomic, copy) NSString *merchant_phone;   //商户联系电话
@property (nonatomic, copy) NSString *mobile;           //用户手机号
@property (nonatomic, copy) NSString *server_price;     //服务费
@property (nonatomic, copy) NSString *talk_id;          //会话id
@property (nonatomic, copy) NSString *talk_type;        //喊单类型（1.实物类喊单，2.服务类喊单）
@property (nonatomic, copy) NSString *user_axis;        //用户地理坐标
@property (nonatomic, copy) NSString *user_id;          //用户id
@property (nonatomic, copy) NSString *user_name;        //用户昵称


@property (nonatomic, strong) MQLGoodDataManage *goodDataManage;
@property (nonatomic, strong) MQLPayModeDataManage *payModeDataManage;
@property (nonatomic, strong) MQLCashCouponDataManage *cashCouponDataManage;



/**
 *  解析喊单请求响应
 *
 *  @param response
 */
-(void)parseHanDanDetailRequestResponse:(NSDictionary*)response;


@end
