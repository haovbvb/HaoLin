//
//  MQLDeviceDataManage.m
//  GeneralMerchandiseStore
//
//  Created by 马千里 on 14-5-7.
//  Copyright (c) 2014年 maqianli. All rights reserved.
//

#import "MQLDeviceDataManage.h"
#import"sys/utsname.h"

static MQLDeviceDataManage *sharedDeviceDataManage = nil;

@interface MQLDeviceDataManage ()

/**
 *  初始化属性值
 */
-(void)initPropertyValue;

@end

@implementation MQLDeviceDataManage

-(id)init
{
    self = [super init];
    if (self) {
        
        self.osVersion = @"";      //系统版本
        self.osType = @"";         //系统类型
        self.mobilePhone = @"";    //手机型号
        self.model = @"";          //机器模型
        self.screenHeight = @"0";   //屏幕高度
        self.screenWidth = @"0";    //屏幕宽度
        self.densityDpi = @"0";     //屏幕密度
        
        self.deviceToken = @"";
        self.baiDuPushAppId = @"";
        self.baiDuPushChannelId = @"";
        self.baiDuPushUserId = @"";
        
    }
    return self;
}

/**
 *  获取单实例
 *
 *  @return 返回单实例
 */
+(MQLDeviceDataManage*)sharedInstance
{
    if (sharedDeviceDataManage == nil) {
        sharedDeviceDataManage = [[MQLDeviceDataManage alloc]init];
        [sharedDeviceDataManage initPropertyValue];
    }
    return sharedDeviceDataManage;
}

/**
 *  删除单实例
 */
+(void)deleteSharedInstance
{
    sharedDeviceDataManage = nil;
}

/**
 *  初始化属性值
 */
-(void)initPropertyValue
{
    UIDevice *device = [UIDevice currentDevice];
    self.osVersion = [device systemVersion];
    self.osType = [device systemName];
    self.model = [device model];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    self.mobilePhone = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    self.screenHeight = [NSString stringWithFormat:@"%f", [UIScreen mainScreen].bounds.size.height];
    self.screenWidth = [NSString stringWithFormat:@"%f", [UIScreen mainScreen].bounds.size.width];
    
}

@end
