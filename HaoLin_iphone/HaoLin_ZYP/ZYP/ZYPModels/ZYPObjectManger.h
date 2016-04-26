//
//  ZYPObjectManger.h
//  HaoLin
//
//  Created by mac on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYPLoginInformation;
@interface ZYPObjectManger : NSObject
{
}
//  单例类， 管理对象
+ (ZYPObjectManger *)shareInstance;
@property (nonatomic, assign)NSInteger state;
@property (nonatomic,strong)ZYPLoginInformation *loginInObject;
@property (nonatomic, strong)NSString *barTitle;
@property (nonatomic, strong)NSString *barTitle1;
@property (nonatomic, strong)NSString *tokenID;


+ (void)free;
@end
