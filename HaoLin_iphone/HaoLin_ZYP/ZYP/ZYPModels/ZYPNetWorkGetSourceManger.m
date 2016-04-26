//
//  ZYPNetWorkGetSourceManger.m
//  HaoLin
//
//  Created by mac on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPNetWorkGetSourceManger.h"



@interface ZYPNetWorkGetSourceManger ()


@end
@implementation ZYPNetWorkGetSourceManger
//  上传头像 post
- (void)uploadImage:(UIImage *)headimag userID:(NSString *)userid token:(NSString *)tokenidq name:(NSString *)imageName completion:(void (^)(id responedObject))respond
{
    NSString *urlStr = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&headimg=%@",uploadUrl,userid,tokenidq,imageName];
    NSURL *url = [NSURL URLWithString:urlStr];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request=[httpClient multipartFormRequestWithMethod:@"POST" path:urlStr parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        NSData *imageData = UIImageJPEGRepresentation(headimag, 0.5);
            [formData appendPartWithFileData:imageData name:imageName fileName:imageName mimeType:@"image/jpeg"];
    }];
    [request setTimeoutInterval:20];
    //  返回的JSON数据
    AFJSONRequestOperation *operation1 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"json %@",JSON);
        respond(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        respond(error);
    }];
    //  执行操作
    [operation1 start];
    
}

//  上传商户信息 post
- (void)businessUPload:(NSMutableArray *)imageArray filedLetter:(NSArray *)filedArray  urlString:(NSString *)urlString para:(NSDictionary *)dic completion:(void (^)(id responedObject))respond
{
    NSString *url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlstr = [NSURL URLWithString:url];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:urlstr];
    
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"" parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //  上传图片
        if(imageArray.count){
        for (int i = 0; i < imageArray.count; i ++) {
            NSData *imageData = UIImageJPEGRepresentation([imageArray objectAtIndex:i], 0.5);
            [formData appendPartWithFileData:imageData name:[filedArray objectAtIndex:i] fileName:[NSString stringWithFormat:@"image%d.jpg",i] mimeType:@"image/jpeg"];
        }
        }
    }];
    [request setTimeoutInterval:20];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
              YYLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.responseData!=nil) {
            NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
            respond(dic);
        }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            respond(error);
    }];
    [operation start];
}

//  商品分类列表 get，信息消息（get）
- (void)connectWithUrlString:(NSString *)urlString completion:(void(^)(id responedObject))respondSource
{
    NSString *string  = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:string];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json", @"text/html", nil]];

    NSMutableURLRequest *request = [client requestWithMethod:@"GET" path:string parameters:nil];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@",JSON);
        respondSource(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        respondSource(error);
    }];
    [request setTimeoutInterval:20];
    [operation start];
}
//   修改商品 post , 修改商户资料 post, 添加商品post ，获取分类下的商品列表 post ,删除商品 post ,喊单详情 post
//  只需要传入拼接好参数的urlString
- (void)connectWithUrlStr:(NSString *)urlString completion:(void (^)(id respondObject))respondSource
{
    NSString *url1 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:url1];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:url1 parameters:nil];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json", @"text/html", nil]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@",JSON);
        respondSource(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        respondSource(error);
    }];
    [operation start];
}
@end
