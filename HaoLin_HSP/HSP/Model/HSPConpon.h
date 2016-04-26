//
//  HSPConpon.h
//  HaoLin
//
//  Created by PING on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSPConpon : NSObject


/**
 coupon_id	代金券id
 coupon_code	代金券激活码
 coupon_price	代金券金额
 begintime	使用开始时间
 endtime	使用结束时间
 user_id	所属用户id
 status	状态：2.已激活（未使用），3.已使用
 createtime	代金券生成时间 */

/**
 *  代金券激活码
 */
@property (nonatomic, copy) NSString *coupon_code;
/**
 *  代金券金额
 */
@property (nonatomic, copy) NSString *coupon_price;
/**
 *  使用开始时间,使用结束时间
 */
@property (nonatomic, copy) NSString *begintime;
@property (nonatomic, copy) NSString *endtime;
/**
 *  状态：2.已激活（未使用），3.已使用
 */
@property (nonatomic, copy) NSString *status;

@end
