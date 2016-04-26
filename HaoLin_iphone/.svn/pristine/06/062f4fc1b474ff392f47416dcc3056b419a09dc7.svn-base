//
//  MQLHttpRequestManage.h
//  HaoLin
//
//  Created by MQL on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ViewKind_SendHanDan,
    ViewKind_View1,
    ViewKind_View2
}ViewKind;

@class ZYPObjectManger, MQLPersonalHanDanDataManage, MQLShiWuOrFuWuConfirmOrderFormDataManage;
@interface MQLHttpRequestManage : NSObject

/**
 *  http管理对象
 *
 *  @return
 */
+(MQLHttpRequestManage*)instance;

/**
 *  释放单实例
 */
+(void)freeInstance;

/////////////////////////////////////////////////////////////

/**
 *  发送个人喊单请求
 */
-(void)sendPersonalHanDanRequestWithPersonalHanDanDataManage:(MQLPersonalHanDanDataManage*)personalHanDanDataManage selectedHanDankind:(NSDictionary*)selectedHanDankind inWhichView:(ViewKind)viewkind;

/**
 *  取消个人喊单请求
 */
-(void)cancelPersonalHanDanRequest;

/**
 *  广播个人喊单请求结束
 */
-(void)broadcastPersonalHanDanRequestOver:(NSDictionary*)userInfo inWhichView:(ViewKind)viewkind;

/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////

/**
 *  发送喊单详情请求
 */
-(void)sendHanDanDetailRequest:(NSString*)talk_id;


/**
 *  取消喊单详情请求
 */
-(void)cancelHanDanDetailRequest;


/**
 *  广播喊单详情请求结束
 */
-(void)broadcastHanDanDetailRequestOver:(NSDictionary*)userInfo;

/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////

/**
 *  发送实物确认订单的提交请求
 */
-(void)sendSubmitRequestOfShiWuConfirmOrderForm:(MQLShiWuOrFuWuConfirmOrderFormDataManage*)confirmOrderFormDataManage;

/**
 *  取消实物确认订单的提交请求
 */
-(void)cancelSubmitRequestOfShiWuConfirmOrderForm;

/**
 *  广播实物确认订单的提交请求结束
 *
 *  @param userInfo
 */
-(void)broadcastSubmitRequestOfShiWuConfirmOrderFormOver:(NSDictionary*)userInfo;



/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////

/**
 *  发送首页广告请求
 */
-(void)sendAdInPersonalRequest;

/**
 *  取消首页广告请求
 */
-(void)cancelAdInPersonalRequest;

/**
 *  广播首页广告请求结束
 */
-(void)broadcastAdInPersonalRequestOver:(NSDictionary*)userInfo;


/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////

/**
 *  发送喊单等待页广告请求
 */
-(void)sendAdInHanDanWaitingRequest;

/**
 *  取消喊单等待页广告请求
 */
-(void)cancelAdInHanDanWaitingRequest;

/**
 *  广播喊单等待页广告请求结束
 */
-(void)broadcastAdInHanDanWaitingRequestOver:(NSDictionary*)userInfo;


/////////////////////////////////////////////////////////////




@end
