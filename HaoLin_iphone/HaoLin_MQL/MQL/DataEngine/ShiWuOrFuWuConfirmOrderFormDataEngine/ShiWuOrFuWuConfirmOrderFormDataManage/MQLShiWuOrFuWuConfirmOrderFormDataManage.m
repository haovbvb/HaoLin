//
//  MQLShiWuOrFuWuConfirmOrderFormDataManage.m
//  HaoLin
//
//  Created by MQL on 14-9-17.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLShiWuOrFuWuConfirmOrderFormDataManage.h"

@interface MQLShiWuOrFuWuConfirmOrderFormDataManage ()


@end

@implementation MQLShiWuOrFuWuConfirmOrderFormDataManage

-(id)init
{
    self = [super init];
    if (self) {
        
        _call_type = @"";    //喊单类型（1、语音，2、文字）
        _audio = @"";        //语音存放地址
        _call_infos = @"";   //喊单文字信息
        _cat_id = @"";       //喊单分类
        _delivery_address = @""; //配送地址
        _merchant_id = @"";      //商户id
        _merchant_mobile = @"";  //商户手机号
        _merchant_name = @"";    //商户名称
        _merchant_phone = @"";   //商户联系电话
        _mobile = @"";           //用户手机号
        _server_price = @"";     //服务费
        _talk_id = @"";          //会话id
        _talk_type = @"";        //喊单类型（1.实物类喊单，2.服务类喊单）
        _user_axis = @"";        //用户地理坐标
        _user_id = @"";          //用户id
        _user_name = @"";        //用户昵称
        
        _goodDataManage = [[MQLGoodDataManage alloc]init];
        _payModeDataManage = [[MQLPayModeDataManage alloc]init];
        _cashCouponDataManage = [[MQLCashCouponDataManage alloc]init];
        
        //初始化“支付方式列表”
        {
            MQLPayModeItemInfo *payModeItemInfo = [[MQLPayModeItemInfo alloc]init];
            payModeItemInfo.payModeName = @"在线支付";
            payModeItemInfo.isSelected = NO;
            [_payModeDataManage addItemToArray:payModeItemInfo];
            
            payModeItemInfo = [[MQLPayModeItemInfo alloc]init];
            payModeItemInfo.payModeName = @"货到付款";
            payModeItemInfo.isSelected = YES;
            [_payModeDataManage addItemToArray:payModeItemInfo];
            
            payModeItemInfo = [[MQLPayModeItemInfo alloc]init];
            payModeItemInfo.payModeName = @"其他支付(代金券)";
            payModeItemInfo.isSelected = NO;
            [_payModeDataManage addItemToArray:payModeItemInfo];
            
        }
        
        
    }
    return self;
}

/**
 *  解析喊单请求响应
 *
 *  @param response
 */
-(void)parseHanDanDetailRequestResponse:(NSDictionary*)response
{
    self.call_type = [[response objectForKey:@"data"]objectForKey:@"call_type"];
    self.audio = [[response objectForKey:@"data"]objectForKey:@"audio"];
    self.call_infos = [[response objectForKey:@"data"]objectForKey:@"call_infos"];
    self.cat_id = [[response objectForKey:@"data"]objectForKey:@"cat_id"];
    self.delivery_address = [[response objectForKey:@"data"]objectForKey:@"delivery_address"];
    self.merchant_id = [[response objectForKey:@"data"]objectForKey:@"merchant_id"];
    self.merchant_mobile = [[response objectForKey:@"data"]objectForKey:@"merchant_mobile"];
    self.merchant_name = [[response objectForKey:@"data"]objectForKey:@"merchant_name"];
    self.merchant_phone = [[response objectForKey:@"data"]objectForKey:@"merchant_phone"];
    self.mobile = [[response objectForKey:@"data"]objectForKey:@"mobile"];
    self.server_price = [[response objectForKey:@"data"]objectForKey:@"server_price"];
    self.talk_id = [[response objectForKey:@"data"]objectForKey:@"talk_id"];
    self.talk_type = [[response objectForKey:@"data"]objectForKey:@"talk_type"];
    self.user_axis = [[response objectForKey:@"data"]objectForKey:@"user_axis"];
    self.user_id = [[response objectForKey:@"data"]objectForKey:@"user_id"];
    self.user_name = [[response objectForKey:@"data"]objectForKey:@"user_name"];
    
    NSArray *array = [[response objectForKey:@"data"]objectForKey:@"goodsinfo"];
    if ([array count]) {
        
        for (NSDictionary *dic in array) {
            
            NSString *goods_id = [dic objectForKey:@"goods_id"];
            NSString *goods_name = [dic objectForKey:@"goods_name"];
            NSString *goods_num = [dic objectForKey:@"goods_num"];
            NSString *goods_price = [dic objectForKey:@"goods_price"];
            
            MQLGoodItemInfo *item = [[MQLGoodItemInfo alloc]init];
            item.goods_id = goods_id;
            item.goods_name = goods_name;
            item.goods_num = goods_num;
            item.goods_price = goods_price;
            [self.goodDataManage addItemToArray:item];
        }
    }
}

@end











