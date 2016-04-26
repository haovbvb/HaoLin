//
//  HSPOrder.m
//  HaoLin
//
//  Created by PING on 14-9-4.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPOrder.h"

@implementation HSPOrder

/**
 *  返回订单状态
 *
 */
- (NSString *)orderStatusStr:(NSString *)status
{
    int s = [status intValue];
    switch (s) {
        case 0:
            status = @"订单取消";
            break;
        case 1:
            status = @"已确认";
            break;
        case 2:
            status = @"待发货";
            break;
        case 3:
            status = @"待收货";
            break;
        case 4:
            status = @"已发货";
            break;
        case 5:
            status = @"已发货";
            break;
        case 6:
            status = @"已发货";
            break;
        case 7:
            status = @"待服务";
            break;
        case 8:
            status = @"已服务";
            break;
            
        default:
            break;
    }
    return status;
}

- (NSString *)orderTime:(NSString*)createtime dateFromat:(NSString *)format
{
    if (!format) {
        format = @"MM-dd hh:mm";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *createdTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[createtime doubleValue]]];
    return [NSString stringWithFormat:@"下单时间: %@",createdTime];
}

/**
 *  支付类型
 *
 *  @param payType 1:在线支付，2:货到付款，3：其他支付（代金券）
 *
 *  @return payType
 */
- (NSString *)orderPayType:(NSString *)payType
{
    int s = [payType intValue];
    switch (s) {
        case 1:
            payType = @"在线支付";
            break;
        case 2:
            payType = @"货到付款";
            break;
        case 3:
            payType = @"其他支付(代金券)";
            break;
        default:
            break;
    }
    return payType;
}

@end
