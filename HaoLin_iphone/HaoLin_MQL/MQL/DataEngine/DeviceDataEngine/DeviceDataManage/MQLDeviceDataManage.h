//
//  MQLDeviceDataManage.h
//  GeneralMerchandiseStore
//
//  Created by 马千里 on 14-5-7.
//  Copyright (c) 2014年 maqianli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQLDeviceDataManage : NSObject

@property (nonatomic, strong) NSString *osVersion;      //系统版本
@property (nonatomic, strong) NSString *osType;         //系统类型
@property (nonatomic, strong) NSString *mobilePhone;    //手机型号
@property (nonatomic, strong) NSString *model;          //机器模型
@property (nonatomic, strong) NSString *screenHeight;   //屏幕高度
@property (nonatomic, strong) NSString *screenWidth;    //屏幕宽度
@property (nonatomic, strong) NSString *densityDpi;      //屏幕密度

@property (nonatomic, strong) NSString *deviceToken;    //设备令牌

//应用ID，就是百度开发者中心的应用基本信息中的应用ID。客户端绑定调用返回值中可获得。
@property (nonatomic, strong) NSString *baiDuPushAppId;
//推送通道ID，通常指一个终端，如一台android系统手机。客户端绑定调用返回值中可获得。
@property (nonatomic, strong) NSString *baiDuPushChannelId;
//应用的用户ID，一个应用在多个端，可以都属于同一用户（即对应一个userid）。user id和channel id配合可以唯一指定一个应用的特定终端。如果应用不是基于百度账户的账户体系，单独用user就通常指定了一个应用的特定终端。客户端绑定调用返回值中可获得。
@property (nonatomic, strong) NSString *baiDuPushUserId;





/**
 *  获取单实例
 *
 *  @return 返回单实例
 */
+(MQLDeviceDataManage*)sharedInstance;

/**
 *  删除单实例
 */
+(void)deleteSharedInstance;


@end
