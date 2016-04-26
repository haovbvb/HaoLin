//
//  MDLQiangdanliebiao.h
//  HaoLin
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//


/*
 
 014-08-29 17:39:12.374 HaoLin[49260:60b] 获取到的数据为：{
 "call_infos" = "\U60f3\U8981\U4e00\U76d2\U4e2d\U534e\U9999\U70df";
 "call_type" = 2;
 "cat_id" = 3;
 "delivery_address" = "\U5317\U4eac\U5e02\U6d77\U6dc0\U533a\U96c5\U7f8e\U79d1\U6280\U56ed";
 mobile = 15910216409;
 "server_price" = 5;
 status = 1;
 "talk_id" = 41409304695;
 "talk_type" = 1;
 "user_axis" = "116.324446,40.043968";
 "user_id" = 4;
 "user_name" = robin12545;
 }
 
 
 */


#import <Foundation/Foundation.h>

@interface MDLQiangdanliebiao : NSObject

@property(nonatomic ,retain) NSMutableArray *callinfos;       //喊单文字信息
@property(nonatomic ,retain) NSMutableArray *serverprice;     //服务费
@property(nonatomic ,retain) NSMutableArray *deliveryaddress; //配送地址
@property(nonatomic ,retain) NSMutableArray *type;            //喊单类型
@property(nonatomic ,retain) NSMutableArray *audio;           //语音地址

@property(nonatomic ,retain) NSMutableDictionary *Liebiaodic; //

@end
