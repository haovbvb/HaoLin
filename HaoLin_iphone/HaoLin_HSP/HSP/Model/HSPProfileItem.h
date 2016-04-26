//
//  HSPProfileItem.h
//  HaoLin
//
//  Created by PING on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HSPUserInfo;

@interface HSPProfileItem : NSObject

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  图标名称
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  右侧显示的控件类名
 */
@property (nonatomic, copy) NSString *accessory;
/**
 *  目标类名（用PUSH展现的视图控制器的类名）
 */
@property (nonatomic, copy) NSString *destClassName;
/**
 *  要加载的plist数据文件名
 */
@property (nonatomic, copy) NSString *plistName;
/**
 调用的函数名
 */
@property (nonatomic, copy) NSString *callFunction;
/**
 保存到系统偏好中的键名
 */
@property (nonatomic, copy) NSString *keyName;

@property (nonatomic, copy) NSString *text;

/**
 *  userInfo
 */
@property (nonatomic, strong) HSPUserInfo *userInfo;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ProfileItemWithDict:(NSDictionary *)dict;

@end
