//
//  MDLNetworkservice.m
//  HAOLINAPP
//
//  Created by apple on 14-8-11.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//

#import "MDLNetworkservice.h"


@implementation MDLNetworkservice

+(MDLNetworkservice *)shareservice
{
    static MDLNetworkservice *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[MDLNetworkservice alloc] init];
    });
    return service;

}

//获取喊单详情
-(void)ConnectToobtain:(NSString *)USERIDNAME TOKENID:(NSString *)TOKENID talkid:(NSString *)talkid withJSON:(void (^)(id responseObject))responseObject
{
//    NSString *urlstr =[NSString stringWithFormat:ktalkinfosUrl,USERIDNAME,TOKENID,talkid ];
//    [self connectWithParmsDic:nil withBlock:responseObject url:urlstr];
    
}

// 商户抢单提交
- (void)ConnectSubmit:(NSString *)userid tokenid:(NSString *)tokenid talkid:(NSString *)talkid goodsinfo:(NSMutableArray *)goodsinfo  withJSON:(void (^)(id responseObject))responseObject
{
    
    NSString *urlstr =[NSString stringWithFormat:kgrabtoUrl,userid,tokenid,talkid,goodsinfo ];
    [self connectWithParmsDic:nil withBlock:responseObject url:urlstr];
}

//获取分类下的商品
- (void)ConnectToobtaindic:(NSString *)userid tokenid:(NSString *)tokenid catid:(NSString *)catid page:(NSString *)page withJSON:(void (^)(id responseObject))responseObject
{
//    NSMutableDictionary *bodydic=[NSMutableDictionary dictionaryWithObjectsAndKeys:USERIDNAME,@"user_id",TOKENID,@"tokenid",catid,@"cat_id", nil];Kgoodslisturl
    NSString *urlstr =[NSString stringWithFormat:Kgoodslisturl,userid,tokenid,catid,page];
 
    [self connectWithParmsDic:nil withBlock:responseObject url:urlstr];
}
//获取商户经营范围分类
- (void)Connectdafenlei:(NSString *)userid tokenid:(NSString *)tokenid  withJSON:(void (^)(id responseObject))responseObject
{
    NSString *urlstr =[NSString stringWithFormat:Kmerchantcatgoryurl ,userid,tokenid];
    
    [self connectWithParmsDic:nil withBlock:responseObject url:urlstr];
    
}

- (void)connectWithParmsDic:(NSDictionary *)dic withBlock:(void (^)(id responseObject))block  url:(NSString *)url
{
    NSLog(@"%@",url);
    NSString *urlstring = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlstring] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    [request setHTTPMethod:kConnectPostType];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/json", nil]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"获取到的数据为：%@",JSON);
        NSLog(@"%@",request);
        block(JSON);
//        NSMutableDictionary *dic=JSON;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id data) {
        NSLog(@"发生错误！%@",error);
        block(error);
        NSLog(@"%@",request);
    }];
    
    [operation start];

}
/*
+(id)requst

{
//    NSMutableDictionary *bodydic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"15210926718",@"user_id",@"KCEH9XKZV2A24442",@"tokenid",@"41409212866",@"talk_id", nil];
    
    NSString *str = [NSString stringWithFormat:ktalkinfosUrl,USERIDNAME1,TOKENID1,@"41409212866"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];

    [request setHTTPMethod:@"POST"];

    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    //  json 解析操作
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        block(JSON);
        NSLog(@"json %@",JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        block(error);
        NSLog(@"%@",error);
    }];
    //  执行操作
    [operation start];

    return request;

}

    
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/json", nil]];
//    
//    AFJSONRequestOperation *operation1 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary* JSON) {
//        NSLog(@"00000000获取到的数据为：%@",JSON);
//        NSLog(@"22222222requst %@",request);
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id data) {
//        NSLog(@"发生错误！%@",error);
////        NSLog(@"11111111%@",response);
//    }];
//    [operation1 start];


//    NSURL *NSurl = [NSURL URLWithString:url];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:NSurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//
//    NSString *dicvalueString=[dic JSONString];
//
//    NSString *postString=[NSString stringWithFormat:@"%@=%@",_QDpostValueKey,dicvalueString];
//
//    NSData *data=[postString  dataUsingEncoding:NSUTF8StringEncoding];
//
//    [request setHTTPMethod:kConnectPostType];
//    [request setHTTPBody:data];

// http 代理初始化
//    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:url]];

//  通过AFHTTPClient初始化一个MutableURLRequest
//    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:nil parameters:dic];



*/
@end
