//
//  ZYPLoginAndRegisterManger.m
//  HaoLin
//
//  Created by mac on 14-8-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPLoginAndRegisterManger.h"

@implementation ZYPLoginAndRegisterManger
//  单例
+ (ZYPLoginAndRegisterManger *)shareManger
{
    static ZYPLoginAndRegisterManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[ZYPLoginAndRegisterManger alloc] init];
    });
    return manger;
}
#pragma mark - 登录 注册 修改密码
//  登陆
- (void)loginWithUserName:(NSString *)mobile password:(NSString *)password  userid:(NSString *)userid tokenid:(NSString *)token  withJSON:(void (^)(id responeObjects))responeObject
{
    //  参数字典
    NSDictionary *parmsDic = [NSDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",password,@"password",deviceType,@"device_type",userid,@"push_user_id",token,@"channel_id", nil];
    NSString *str = [NSString stringWithFormat:@"%@mobile=%@&password=%@&push_user_id=%@&channel_id=%@&device_type=%@",loginUrl,mobile,password,userid,token,deviceType];
    [self connectWithParmsDic:parmsDic withBlock:responeObject url:str];
}
//  修改密码
- (void)changePassword:(NSString *)password1 userid:(NSString *)user_id tokenid:(NSString *)tokenid withJSON:(void (^)(id responeObjects))responeObject
{
     NSDictionary *parmsDic = [NSDictionary dictionaryWithObjectsAndKeys:user_id,@"user_id",password1,@"password",tokenid,@"tokenid", nil];
    NSString *str = [NSString stringWithFormat:@"%@password=%@&user_id=%@&tokenid=%@",changeUrl,password1,user_id,tokenid];
    [self connectWithParmsDic:parmsDic withBlock:responeObject url:str];
}
//  注册
- (void)registerWithUserName:(NSString *)mobile password:(NSString *)password1  nickName:(NSString *)nickname  withJSON:(void (^)(id responeObjects))responeObject
{
    NSDictionary *parmsDic = [NSDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",password1,@"password",nickname,@"nickname", nil];
    NSString *str = [NSString stringWithFormat:@"%@nickname=%@&mobile=%@&password=%@",registerUrl,nickname,mobile,password1];
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self connectWithParmsDic:parmsDic withBlock:responeObject url:url];
}
#pragma mark - post 请求
//  post 请求
- (void)connectWithParmsDic:(NSDictionary *)dic withBlock:(void (^)(id responeObjects))block  url:(NSString *)url1
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url1] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    NSLog(@"%@",request);
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:20];
    //  设置解析的数据类型
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json", @"text/html", nil]];
    //  json 解析操作
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        block(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(error);
        NSLog(@"%@",error);
    }];
    //  执行操作
    [operation start];
}

@end
