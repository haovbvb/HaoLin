//
//  ZYPBusinessDetailObject.h
//  HaoLin
//
//  Created by mac on 14-9-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPBusinessDetailObject : NSObject
@property (nonatomic, strong)NSString *merchant_id;//商户ID标识
@property (nonatomic, strong)NSString *merchant_name;//商户名称
@property (nonatomic, strong)NSString *merchant_amount;//商户余额
@property (nonatomic, strong)NSString *score;//总评分
@property (nonatomic, strong)NSString *comment_num;//评价总数
@property (nonatomic, strong)NSString *axis;//商铺坐标
@property (nonatomic, strong)NSString *shop_address;//商铺地址
@property (nonatomic, strong)NSString *identity_img_z;//身份证正面照
@property (nonatomic, strong)NSString *identity_img_f;//身份证反面照
@property (nonatomic, strong)NSString *trade_img;//营业执照
@property (nonatomic, strong)NSString *health_img;//为什许可证
@property (nonatomic, strong)NSString *product_desc;//产品介绍
@property (nonatomic, strong)NSString *activ_desc;//活动介绍
@property (nonatomic, strong)NSString *photo;//商户照片，数组，多张
@property (nonatomic, strong)NSString *mobile;//注册手机号
@property (nonatomic, strong)NSString *phone;//联系电话
@property (nonatomic, strong)NSString * mer_desc;//商家介绍

- (id)initBusinessDetailObjectWithDic:(NSDictionary *)dic;
@end
