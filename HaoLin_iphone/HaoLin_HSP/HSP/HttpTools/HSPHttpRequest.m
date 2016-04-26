//
//  HSPHttpRequest.m
//  HaoLin
//
//  Created by PING on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPHttpRequest.h"

@implementation HSPHttpRequest

+(id)Instace
{
    static HSPHttpRequest *request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request=[[HSPHttpRequest alloc] init];
    });
    return request;
}

/**
 *  post 请求
 *
 */
-(void)connectionREquesturl:(NSString *)urlString withPostDatas:(NSDictionary *)bodyData withDelegate:(id)myDelegate withBackBlock:(void(^)(id backDictionary))parameter
{
    //定义并配置HttpClient
    AFHTTPClient *scanPageHttpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    scanPageHttpClient.parameterEncoding = AFFormURLParameterEncoding;
    [scanPageHttpClient setDefaultHeader:@"Accept" value:@"text/html"];
    [scanPageHttpClient postPath:urlString parameters:bodyData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //系统方式解析json
        NSDictionary *backInfo = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        parameter(backInfo);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        parameter(error);
        if([error code] == NSURLErrorCancelled){
            return;
        }
    }];
}


/**
 *  get请求 代理
 *
 */
-(void)connectionRequestUrl:(NSString *)urlString withDelegate:(id)myDelegate
{
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    __weak id delegate=myDelegate;
    AFJSONRequestOperation *jsonOperation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {if ([delegate respondsToSelector:@selector(requestFinished:)]) {[delegate requestFinished:JSON];}} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {if ([delegate respondsToSelector:@selector(requestFailed:)]) {[delegate requestFailed:error];}}];
    [jsonOperation start];
}

/**
 *  get--block
 *
 */
-(void)connectionRequestUrl:(NSString *)urlString withJSON:(void (^)(id responeJson))resoponeObject
{
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    AFJSONRequestOperation *jsonOperation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                              resoponeObject(JSON);
                                                                                          }
                                                                                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                  resoponeObject(error);
                                                                                          }];
    [jsonOperation start];
}


/**
 *  post 头像上传
 *
 */
-(void)connectionUpLoadImage:(UIImage *)image parameters:(NSDictionary *)params url:(NSString *)urlString withBlock:(void (^)(NSDictionary *dict))backResponseObject
{
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request=[httpClient multipartFormRequestWithMethod:@"POST" path:@"" parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:imageData name:@"headimg" fileName:@"headimg.jpg" mimeType:@"image/jpeg"];
    }];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        YYLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        YYLog(@"上传成功");
        NSDictionary *backInfo = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        backResponseObject(backInfo);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        backResponseObject(error);
    }];
    [operation start];
}

// 图片请求
-(void)getImageUrl:(NSString *)url withImage:(void (^)(UIImage *img))blockImage
{
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1*1024*1024];
    [urlCache setDiskCapacity:50*1024*1024];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSCachedURLResponse *response=[urlCache cachedResponseForRequest:request];
    if (response!=nil) {
        [request setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    }
    AFImageRequestOperation *operation=[AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
        blockImage(image);
    }];
    [operation start];
}



@end
