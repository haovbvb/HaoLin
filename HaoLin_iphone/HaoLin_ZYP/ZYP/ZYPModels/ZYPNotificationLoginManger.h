//
//  ZYPNotificationLoginManger.h
//  HaoLin
//
//  Created by mac on 14-9-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  通知name
 */
@interface ZYPNotificationLoginManger : NSObject
/**
 *  弹出登陆界面通知类
 */
+ (void)getNotificationFromController:(UIViewController *)controller;
/**
 *  去除观察者
 */
+ (void)freeInstance;
@end
