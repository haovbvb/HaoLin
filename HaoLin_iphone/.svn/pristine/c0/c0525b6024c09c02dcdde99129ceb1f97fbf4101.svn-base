//
//  JZDModuleHttpRequest.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

@protocol JZDModuleHttpRequestDelegate <NSObject>

-(void)requestFinished:(id)responseObject;

-(void)requestFailed:(NSError *)error;

@end

@interface JZDModuleHttpRequest : NSObject
{
    BOOL isNetWork;
}
+(instancetype)sharedInstace;

@property (nonatomic,copy) NSString *postValueKey;
//图片请求
-(void)getImageUrl:(NSString *)url withImage:(void (^)(UIImage *img))blockImage;
//post--block
-(void)connectionREquesturl:(NSString *)urlString withPostDatas:(NSDictionary *)bodyData withJSON:(void (^)(id responeJson))resoponeObject;
//get--block
-(void)connectionRequestUrl:(NSString *)urlString withJSON:(void (^)(id responeJson))resoponeObject;
//get请求--delegate
-(void)connectionRequestUrl:(NSString *)urlString withDelegate:(id<JZDModuleHttpRequestDelegate>)myDelegate;
//post请求
-(void)connectionREquesturl:(NSString *)urlString withPostDatas:(NSDictionary *)bodyData withDelegate:(id)myDelegate withBackBlock:(void(^)(id backDictionary,NSError *error))parameter;
// 上传图片
-(void)connectionUpLoadImage:(NSMutableArray *)imageArray withVoiceData:(NSData *)data withPardic:(NSDictionary *)dic withUrl:(NSString *)urlString withBlock:(void(^)(NSDictionary *dic,NSError * error))signBlock;
@property (nonatomic,strong) UIImage *imageScroll;

@end
