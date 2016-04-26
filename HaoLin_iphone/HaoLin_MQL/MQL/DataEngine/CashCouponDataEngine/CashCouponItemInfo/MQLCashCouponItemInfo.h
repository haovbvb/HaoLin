//
//  MQLCashCouponItemInfo.h
//  HaoLin
//
//  Created by MQL on 14-9-17.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQLCashCouponItemInfo : NSObject

@property (nonatomic, copy) NSString *coupon_id;    //代金券id
@property (nonatomic, copy) NSString *coupon_code;  //代金券激活码
@property (nonatomic, copy) NSString *coupon_price; //代金券金额
@property (nonatomic, copy) NSString *begintime;    //使用开始时间
@property (nonatomic, copy) NSString *endtime;      //使用结束时间
@property (nonatomic, copy) NSString *status;       //状态
@property (nonatomic, copy) NSString *createtime;   //代金券生成时间

@end
