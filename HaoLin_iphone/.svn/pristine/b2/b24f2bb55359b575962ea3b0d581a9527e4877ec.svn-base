//
//  HSPHttpRequest.h
//  HaoLin
//
//  Created by PING on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HSPHttpRequestDelegate <NSObject>

-(void)requestFinished:(id)responseObject;

-(void)requestFailed:(NSError *)error;

@end

@interface HSPHttpRequest : NSObject

{
    BOOL isNetWork;
}
+(instancetype)Instace;

/**
 *  post 请求 delegate实现
 *
 */
-(void)connectionREquesturl:(NSString *)urlString withPostDatas:(NSDictionary *)bodyData withDelegate:(id)myDelegate withBackBlock:(void(^)(id backDictionary))parameter;

/**
 *  get请求,delegate实现
 *
 *  @param urlString  url
 *  @param myDelegate 代理
 */
-(void)connectionRequestUrl:(NSString *)urlString withDelegate:(id<HSPHttpRequestDelegate>)myDelegate;

-(void)connectionRequestUrl:(NSString *)urlString withJSON:(void (^)(id responeJson))resoponeObject;

/**
 *  post上传图片
 *
 *  @param UIImage 图片数组
 *  @param params      参数
 *  @param url  url
 */
-(void)connectionUpLoadImage:(UIImage *)image parameters:(NSDictionary *)params url:(NSString *)urlString withBlock:(void (^)(NSDictionary *dict))backResponseObject;

-(void)getImageUrl:(NSString *)url withImage:(void (^)(UIImage *img))blockImage;


@end
