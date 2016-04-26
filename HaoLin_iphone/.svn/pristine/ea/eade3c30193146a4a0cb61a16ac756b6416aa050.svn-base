//
//  HSPOrder.h
//  HaoLin
//
//  Created by PING on 14-9-4.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HSPOrderUserInfo;

@interface HSPOrder : NSObject

@property (nonatomic, copy) NSString *cat_id;
@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *order_type;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *merchant_id;
@property (nonatomic, copy) NSString *should_price;
@property (nonatomic, copy) NSString *real_price;
@property (nonatomic, copy) NSString *server_price;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *coupons;
@property (nonatomic, copy) NSString *order_desc;
@property (nonatomic, copy) NSString *order_audio;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *changetime;
@property (nonatomic, copy) NSString *delivery_address;


@property (nonatomic, strong) NSMutableArray *goodsM;

@property (nonatomic, assign) CGFloat cellH;

@property (nonatomic, strong) HSPOrderUserInfo *userinfo;

- (NSString *)orderStatusStr:(NSString *)string;
- (NSString *)orderTime:(NSString *)createtime dateFromat:(NSString *)format;
- (NSString *)orderPayType:(NSString *)payType;

@end
