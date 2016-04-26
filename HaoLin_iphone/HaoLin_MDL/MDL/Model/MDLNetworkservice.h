//
//  MDLNetworkservice.h
//  HAOLINAPP
//
//  Created by apple on 14-8-11.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDLNetworkservice : NSObject

@property (nonatomic,copy) NSString *QDpostValueKey;

+(MDLNetworkservice *)shareservice;

//获取喊单详情
-(void)ConnectToobtain:(NSString *)USERIDNAME TOKENID:(NSString *)TOKENID talkid:(NSString *)talkid withJSON:(void (^)(id responseObject))responseObject;

// 商户抢单提交
- (void)ConnectSubmit:(NSString *)userid tokenid:(NSString *)tokenid talkid:(NSString *)talkid goodsinfo:(NSMutableArray *)goodsinfo  withJSON:(void (^)(id responseObject))responseObject;

//获取分类下的商品
- (void)ConnectToobtaindic:(NSString *)userid tokenid:(NSString *)tokenid catid:(NSString *)catid page:(NSString *)page withJSON:(void (^)(id responseObject))responseObject;

- (void)Connectdafenlei:(NSString *)userid tokenid:(NSString *)tokenid  withJSON:(void (^)(id responseObject))responseObject;


//+(id)requst;

@end
