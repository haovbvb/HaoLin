//
//  ZYPNetWorkGetSourceManger.h
//  HaoLin
//
//  Created by mac on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPNetWorkGetSourceManger : NSObject
//  上传头像 post
- (void)uploadImage:(UIImage *)headimag userID:(NSString *)userid token:(NSString *)tokenidq name:(NSString *)imageName completion:(void (^)(id responedObject))respond;
//  上传商户资料 post
- (void)businessUPload:(NSMutableArray *)imageArray filedLetter:(NSArray *)filedArray  urlString:(NSString *)urlString para:(NSDictionary *)dic completion:(void (^)(id responedObject))respond;
//  商品分类列表 get
- (void)connectWithUrlString:(NSString *)urlString completion:(void(^)(id responedObject))respondSource;
//  修改产品 post , 修改商户资料 post, 添加商品post,删除商品 post,获取分类下的商品列表 post
//  只需要传入拼接好参数的urlString
- (void)connectWithUrlStr:(NSString *)urlString completion:(void (^)(id respondObject))respondSource;
//  加载图片

@end
