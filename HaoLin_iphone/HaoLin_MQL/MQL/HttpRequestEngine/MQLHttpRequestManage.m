//
//  MQLHttpRequestManage.m
//  HaoLin
//
//  Created by MQL on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLHttpRequestManage.h"

static MQLHttpRequestManage *httpRequestManage = nil;

@interface MQLHttpRequestManage ()

@property (nonatomic, strong) AFHTTPClient *personalHanDanHttpClient;
@property (nonatomic, strong) AFHTTPRequestOperation *personalHanDanHTTPRequestOperation;

@property (nonatomic, strong) AFHTTPClient *hanDanDetailHttpClient;

@property (nonatomic, strong) AFHTTPClient *submitOfShiWuConfirmOrderFormHttpClient;

@property (nonatomic, strong) AFHTTPClient *adInPersonalHttpClient;

@property (nonatomic, strong) AFHTTPClient *adInHanDanWaitingHttpClient;

@end

@implementation MQLHttpRequestManage

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 *  http管理对象
 *
 *  @return
 */
+(MQLHttpRequestManage*)instance
{
    if (httpRequestManage == nil) {
        
        httpRequestManage = [[MQLHttpRequestManage alloc]init];
    }
    
    return httpRequestManage;
}

/**
 *  释放单实例
 */
+(void)freeInstance
{
    httpRequestManage = nil;
}

/////////////////////////////////////////////////////////////

/**
 *  发送个人喊单请求
 */
-(void)sendPersonalHanDanRequestWithPersonalHanDanDataManage:(MQLPersonalHanDanDataManage*)personalHanDanDataManage selectedHanDankind:(NSDictionary*)selectedHanDankind inWhichView:(ViewKind)viewkind

{
    HSPAccount *loginInObject = [HSPAccountTool account];
    
    int cat_id = [[selectedHanDankind objectForKey:@"kindId"]intValue];             //分类id
    int user_id = loginInObject.user_id.intValue;                                   //喊单用户id标识
    NSString *tokenid = loginInObject.userTokenid;                                  //用户登录后分配的令牌
    int call_type = personalHanDanDataManage.charaters.length > 0 ? 2 : 1;         //喊单类型（1、语音，2、文字）
    NSString *call_infos = personalHanDanDataManage.charaters;                     //喊单文字信息
    //NSString *audio = personalHanDanDataManage.audioFilePath;                      //喊单录音
    int server_price = personalHanDanDataManage.serviceCharge;                     //服务费
    NSString *delivery_address = personalHanDanDataManage.sendAddress;             //配送地址

    NSString *user_axis = @"";
    if (personalHanDanDataManage.pushBusinessScope) {
        
        CLLocationCoordinate2D coordinate = personalHanDanDataManage.pushBusinessScope.coordinate;
        user_axis = [NSString stringWithFormat:@"%f,%f", coordinate.longitude, coordinate.latitude];  //用户指定坐标，以该坐标向范围内的商户发起请求
        
    }else{
        
        MQLBMKMapManage *BMKMapManage = [MQLBMKMapManage instance];
        CLLocation *location = [BMKMapManage currentLocation];

        CLLocationCoordinate2D coordinate = location.coordinate;
        user_axis = [NSString stringWithFormat:@"%f,%f", coordinate.longitude, coordinate.latitude];  //用户指定坐标，以该坐标向范围内的商户发起请求
    }

    
    //组织信息字典
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:[NSNumber numberWithInt:cat_id] forKey:@"cat_id"];
    [params setObject:[NSNumber numberWithInt:user_id] forKey:@"user_id"];
    [params setObject:tokenid forKey:@"tokenid"];
    [params setObject:[NSNumber numberWithInt:call_type] forKey:@"call_type"];
    if (call_type == 2) {
        
        [params setObject:call_infos forKey:@"call_infos"];
        [params setObject:@"" forKey:@"audio"];
        
    }else{
        
        [params setObject:@"" forKey:@"call_infos"];
        
    }
    
    [params setObject:[NSNumber numberWithInt:server_price] forKey:@"server_price"];
    [params setObject:delivery_address forKey:@"delivery_address"];
    [params setObject:user_axis forKey:@"user_axis"];
    
    //创建personalHanDanHttpClient
    NSString *pathStr = [NSString stringWithFormat:@"%@%@", UrlHost, UrlOfPersonalHanDan];
    self.personalHanDanHttpClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:@""]];
    NSMutableURLRequest *request = [self.personalHanDanHttpClient multipartFormRequestWithMethod:@"post" path:pathStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
    
        if (call_type == 1) {
            
            
            NSString *wavFilePath = personalHanDanDataManage.wavFilePath;
            NSString *amrFilePath = [wavFilePath stringByReplacingOccurrencesOfString:@"wav" withString:@"amr"];
            
            MQLAudioManage *audioManage = [MQLAudioManage instance];
            [audioManage encodeToAmr:amrFilePath FromWav:wavFilePath];
            NSData *data = [NSData dataWithContentsOfFile:amrFilePath];
            
            [formData appendPartWithFileData:data name:@"audio" fileName:@"audio.amr" mimeType:@"application/octet-stream"];
            
        }
        
    }];
    
    __weak MQLHttpRequestManage *selfOfBlock = self;
    self.personalHanDanHTTPRequestOperation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [selfOfBlock.personalHanDanHTTPRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObj){
    
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil];
        
        [selfOfBlock broadcastPersonalHanDanRequestOver:responseDic inWhichView:viewkind];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
    
        NSDictionary *responseDic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:NetworkError], @"code",
                                            @"网络连接失败，请稍后再试.", @"message", nil];
        
        [self broadcastPersonalHanDanRequestOver:responseDic inWhichView:viewkind];
    }];
    
    [self.personalHanDanHTTPRequestOperation start];
    
}

/**
 *  取消个人喊单请求
 */
-(void)cancelPersonalHanDanRequest
{
    if (self.personalHanDanHTTPRequestOperation) {
        
        [self.personalHanDanHTTPRequestOperation cancel];
        self.personalHanDanHTTPRequestOperation = nil;
        self.personalHanDanHttpClient = nil;
    }
}

/**
 *  广播个人喊单请求结束
 */
-(void)broadcastPersonalHanDanRequestOver:(NSDictionary*)userInfo inWhichView:(ViewKind)viewkind
{
    self.personalHanDanHTTPRequestOperation = nil;
    self.personalHanDanHttpClient = nil;
    
    NSDictionary *myUserInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:viewkind], @"viewkind", userInfo, @"userInfo", nil];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:NotificationOfPersonalHanDanRequestOver object:nil userInfo:myUserInfo];
}

/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////

/**
 *  发送喊单详情请求
 */
-(void)sendHanDanDetailRequest:(NSString*)talk_id
{
    HSPAccount *loginInObject = [HSPAccountTool account];
    
    //组织信息字典
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:loginInObject.user_id forKey:@"user_id"];
    [params setObject:loginInObject.userTokenid forKey:@"tokenid"];
    [params setObject:talk_id forKey:@"talk_id"];
    
    //创建并配置httpClient
    NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@", UrlHost, UrlOfHanDanDetail];
    self.hanDanDetailHttpClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:@""]];//注意，这里的BaseURL设置为空
    self.hanDanDetailHttpClient.parameterEncoding = AFFormURLParameterEncoding;
    [self.hanDanDetailHttpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    //发送post请求
    [self.hanDanDetailHttpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        NSDictionary *backInfo = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:NULL];
        [self broadcastHanDanDetailRequestOver:backInfo];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSDictionary *responseDic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:NetworkError], @"code",
                                     @"网络连接失败，请稍后再试.", @"message", nil];
        
        [self broadcastHanDanDetailRequestOver:responseDic];
        
    }];
    
}

/**
 *  取消喊单详情请求
 */
-(void)cancelHanDanDetailRequest
{
    if (self.hanDanDetailHttpClient) {
        
        NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@", UrlHost, UrlOfHanDanDetail];
        [self.hanDanDetailHttpClient cancelAllHTTPOperationsWithMethod:@"POST" path:pathStr];
        self.hanDanDetailHttpClient = nil;
    }
}

/**
 *  广播喊单详情请求结束
 */
-(void)broadcastHanDanDetailRequestOver:(NSDictionary*)userInfo
{
    self.hanDanDetailHttpClient = nil;
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfHanDanDetailRequestOver object:nil userInfo:userInfo];
    
}

/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////

/**
 *  发送实物确认订单的提交请求
 */
-(void)sendSubmitRequestOfShiWuConfirmOrderForm:(MQLShiWuOrFuWuConfirmOrderFormDataManage*)confirmOrderFormDataManage
{
    HSPAccount *loginInObject = [HSPAccountTool account];
    //组织信息字典
    NSString *user_id = loginInObject.user_id;
    NSString *tokenid = loginInObject.userTokenid;
    NSString *paytype = @"2";
    NSString *talk_id = confirmOrderFormDataManage.talk_id;
    
    NSMutableArray *goods_info = [NSMutableArray array];
    for (int i = 0; i < [confirmOrderFormDataManage.goodDataManage countOfArray]; i++) {
        
        MQLGoodItemInfo *goodItemInfo = [confirmOrderFormDataManage.goodDataManage itemInArray:i];
        if (goodItemInfo.isSelected) {
            
            NSString *goods_id = goodItemInfo.goods_id;
            NSString *goods_num = goodItemInfo.goods_num;
            NSString *goods_price = goodItemInfo.goods_price;
            NSString *goods_name = goodItemInfo.goods_name;
            
            NSDictionary *itemDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                     goods_id, @"goods_id",
                                     goods_name, @"goods_name",
                                     goods_num, @"goods_num",
                                     goods_price, @"goods_price",
                                      nil];
            [goods_info addObject:itemDic];
        }
    }
//    NSData *goods_infoData = [NSJSONSerialization dataWithJSONObject:goods_info options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *goods_infoStr = [[NSString alloc]initWithData:goods_infoData encoding:NSUTF8StringEncoding];
    NSString *goods_infoStr = [goods_info JSONString];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:tokenid forKey:@"tokenid"];
    [params setObject:paytype forKey:@"pay_type"];
    [params setObject:talk_id forKey:@"talk_id"];
    [params setObject:goods_infoStr forKey:@"goods_info"];
    
    //创建并配置httpClient
    NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@", UrlHost, UrlOfSubmitShiWuConfirmOrderForm];
    self.submitOfShiWuConfirmOrderFormHttpClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:@""]];//注意，这里的BaseURL设置为空
    self.submitOfShiWuConfirmOrderFormHttpClient.parameterEncoding = AFFormURLParameterEncoding;
    [self.submitOfShiWuConfirmOrderFormHttpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    //发送post请求
    [self.submitOfShiWuConfirmOrderFormHttpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        NSDictionary *backInfo = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:NULL];
        [self broadcastSubmitRequestOfShiWuConfirmOrderFormOver:backInfo];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSDictionary *responseDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                     [NSNumber numberWithInt:NetworkError], @"code",
                                     @"网络连接失败，请稍后再试.", @"message", nil];
        
        [self broadcastSubmitRequestOfShiWuConfirmOrderFormOver:responseDic];
        
    }];
}

/**
 *  取消实物确认订单的提交请求
 */
-(void)cancelSubmitRequestOfShiWuConfirmOrderForm
{
    if (self.submitOfShiWuConfirmOrderFormHttpClient) {
        
        NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@", UrlHost, UrlOfSubmitShiWuConfirmOrderForm];
        [self.submitOfShiWuConfirmOrderFormHttpClient cancelAllHTTPOperationsWithMethod:@"POST" path:pathStr];
        self.submitOfShiWuConfirmOrderFormHttpClient = nil;
    }
}

/**
 *  广播实物确认订单的提交请求结束
 *
 *  @param userInfo
 */
-(void)broadcastSubmitRequestOfShiWuConfirmOrderFormOver:(NSDictionary*)userInfo
{
    self.submitOfShiWuConfirmOrderFormHttpClient = nil;
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfSubmitRequestOfShiWuConfirmOrderFormOver object:nil userInfo:userInfo];
}



/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////

/**
 *  发送首页广告请求
 */
-(void)sendAdInPersonalRequest
{
    //组织信息字典
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    //创建并配置httpClient
    NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@", UrlHost, UrlOfAdInPersonal];
    self.adInPersonalHttpClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:@""]];//注意，这里的BaseURL设置为空
    self.adInPersonalHttpClient.parameterEncoding = AFFormURLParameterEncoding;
    [self.adInPersonalHttpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    //发送post请求
    [self.adInPersonalHttpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        NSDictionary *backInfo = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:NULL];
        [self broadcastAdInPersonalRequestOver:backInfo];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSDictionary *responseDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                     [NSNumber numberWithInt:NetworkError], @"code",
                                     @"网络连接失败，请稍后再试.", @"message", nil];
        
        [self broadcastAdInPersonalRequestOver:responseDic];
        
    }];
    
    
}

/**
 *  取消首页广告请求
 */
-(void)cancelAdInPersonalRequest
{
    if (self.adInPersonalHttpClient) {
        
        NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@", UrlHost, UrlOfAdInPersonal];
        [self.adInPersonalHttpClient cancelAllHTTPOperationsWithMethod:@"POST" path:pathStr];
        self.adInPersonalHttpClient = nil;
    }
}

/**
 *  广播首页广告请求结束
 */
-(void)broadcastAdInPersonalRequestOver:(NSDictionary*)userInfo
{
    self.adInPersonalHttpClient = nil;
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfAdInPersonalRequestOver object:nil userInfo:userInfo];
}


/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////

/**
 *  发送喊单等待页广告请求
 */
-(void)sendAdInHanDanWaitingRequest
{
    //组织信息字典
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    //创建并配置httpClient
    NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@", UrlHost, UrlOfAdInHanDanWaiting];
    self.adInHanDanWaitingHttpClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:@""]];//注意，这里的BaseURL设置为空
    self.adInHanDanWaitingHttpClient.parameterEncoding = AFFormURLParameterEncoding;
    [self.adInHanDanWaitingHttpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    //发送post请求
    [self.adInHanDanWaitingHttpClient postPath:pathStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        NSDictionary *backInfo = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:NULL];
        [self broadcastAdInHanDanWaitingRequestOver:backInfo];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        NSDictionary *responseDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                     [NSNumber numberWithInt:NetworkError], @"code",
                                     @"网络连接失败，请稍后再试.", @"message", nil];
        
        [self broadcastAdInHanDanWaitingRequestOver:responseDic];
        
    }];
    

}

/**
 *  取消喊单等待页广告请求
 */
-(void)cancelAdInHanDanWaitingRequest
{
    if (self.adInHanDanWaitingHttpClient) {
        
        NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@", UrlHost, UrlOfAdInHanDanWaiting];
        [self.adInHanDanWaitingHttpClient cancelAllHTTPOperationsWithMethod:@"POST" path:pathStr];
        self.adInHanDanWaitingHttpClient = nil;
    }
}

/**
 *  广播喊单等待页广告请求结束
 */
-(void)broadcastAdInHanDanWaitingRequestOver:(NSDictionary*)userInfo
{
    self.adInHanDanWaitingHttpClient = nil;
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfAdInHanDanWaitingRequestOver object:nil userInfo:userInfo];
}


/////////////////////////////////////////////////////////////







@end
