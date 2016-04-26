//
//  ZYPLoginInformation.h
//  HaoLin
//
//  Created by mac on 14-8-29.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPLoginInformation : NSObject
@property (nonatomic,strong)NSString *user_id;//用户ID标识
@property (nonatomic,strong)NSString *nickname;//昵称
@property (nonatomic,strong)NSString *mobile;//手机号
@property (nonatomic,strong)NSString *phone;//手机号

@property (nonatomic,strong)NSString *email;//邮箱
@property (nonatomic,strong)NSString *headimg;//头像（压缩后的小图）
@property (nonatomic,strong)NSString *bigheadimg;//头像（大图片）
@property (nonatomic,strong)NSString *change_time;//修改时间

@property (nonatomic,strong)NSString *user_mark;//是否开通商户（0：未开通，1.正在整合中，2.已开通）
@property (nonatomic,strong)NSString *status;//状态（0：正常，1：封禁）
@property (nonatomic,strong)NSString *register_time;//注册时间
@property (nonatomic,strong)NSString *tokenid;//登陆后分配给用户的唯一令牌标识，涉及用户操作时需要提交该令牌给服务器以做验证
@property (nonatomic,strong)NSString *merchant_name;//商户名称
@property (nonatomic,strong)NSString *merchant_amount;//商户余额
@property (nonatomic,strong)NSString *user_desc;//用户余额
;//用户余额
@property (nonatomic,strong)NSString *amount;//用户余额
@property (nonatomic,strong)NSString *qq_number;//QQ号码
@property (nonatomic,strong)NSString *range_type;//实物和服务类型（1实物，2服务）

- (id)initLoginInformationWithDictionary:(NSDictionary *)dic;
@end
