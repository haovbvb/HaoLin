//
//  JZDModuleHttpRequest.m
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDModuleHttpRequest.h"

@implementation JZDModuleHttpRequest
+(id)sharedInstace
{
    static JZDModuleHttpRequest *request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request=[[JZDModuleHttpRequest alloc] init];
    });
    return request;
}

//get--代理
-(void)connectionRequestUrl:(NSString *)urlString withDelegate:(id)myDelegate
{
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    __weak id delegate=myDelegate;
    AFJSONRequestOperation *jsonOperation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request
                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                            if ([delegate respondsToSelector:@selector(requestFinished:)]) {
                            [delegate requestFinished:JSON];}}
                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                              if ([delegate respondsToSelector:@selector(requestFailed:)]) {
                                  [delegate requestFailed:error];
                              }
                          }];
    [jsonOperation start];
}
//get--block
-(void)connectionRequestUrl:(NSString *)urlString withJSON:(void (^)(id responeJson))resoponeObject
{
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    AFJSONRequestOperation *jsonOperation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request
                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                     resoponeObject(JSON);
//                     YYLog(@"%@",JSON);
                 }
                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                     YYLog(@"%@",error);
                     resoponeObject(error);
                 }];
    [jsonOperation start];
}
//post--block--参数为json形式
-(void)connectionREquesturl:(NSString *)urlString withPostDatas:(NSDictionary *)bodyData withJSON:(void (^)(id responeJson))resoponeObject
{
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    NSString *valueString=[bodyData JSONString];
    NSString *postString=[NSString stringWithFormat:@"%@=%@",_postValueKey,valueString];
    NSData *data=[postString  dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    AFJSONRequestOperation *jsonOperation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        resoponeObject(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        resoponeObject(error);
    }];
    [jsonOperation start];
}

//post
-(void)connectionREquesturl:(NSString *)urlString withPostDatas:(NSDictionary *)bodyData withDelegate:(id)myDelegate withBackBlock:(void(^)(id backDictionary,NSError *error))parameter
{
    /*
     //系统请求方式
     NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
     NSString *valueString=[bodyData JSONString];
     NSString *postString=[NSString stringWithFormat:@"%@=%@",_postValueKey,valueString];
     NSData *data=[postString  dataUsingEncoding:NSUTF8StringEncoding];
     [request setHTTPMethod:@"POST"];
     [request setHTTPBody:data];
     [AFHTTPRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
     __weak id delegate=myDelegate;
     AFJSONRequestOperation *jsonOperation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
     if ([delegate respondsToSelector:@selector(requestFinished:)]) {
     [delegate requestFinished:JSON];
     }
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
     if ([delegate respondsToSelector:@selector(requestFailed:)]) {
     [delegate requestFailed:error];
     }
     }];
     [jsonOperation start];
     */
    //定义并配置HttpClient
    NSString *pathStr= urlString;
    AFHTTPClient *scanPageHttpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    scanPageHttpClient.parameterEncoding = AFFormURLParameterEncoding;
    [scanPageHttpClient setDefaultHeader:@"Accept" value:@"text/html"];
    [scanPageHttpClient postPath:pathStr parameters:bodyData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //系统方式解析json
        NSDictionary *backInfo = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        parameter(backInfo,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        parameter(nil,error);
        if([error code] == NSURLErrorCancelled){
            return;
        }
    }];
}

//图片请求
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
//    AFImageRequestOperation *op=[AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:^UIImage *(UIImage *image) {
//        return image;
//    } success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        blockImage(image);
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        YYLog(@"图片加载失败");
//    }];
    [operation start];
}

//上传图片
-(void)connectionUpLoadImage:(NSMutableArray *)imageArray withVoiceData:(NSData *)data withPardic:(NSDictionary *)dic withUrl:(NSString *)urlString withBlock:(void(^)(NSDictionary *dic,NSError * error))signBlock
{
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request=[httpClient multipartFormRequestWithMethod:@"POST" path:@"" parameters:dic constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        if(imageArray.count){
            for(int i=0;i<imageArray.count;i++){
                NSData *imageData = UIImageJPEGRepresentation(imageArray[i], 0.5);
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"pic_%d",i+1] fileName:[NSString stringWithFormat:@"pic_%d.jpg",i+1] mimeType:@"image/jpeg"];
            }
        }
        if (data) {
            [formData appendPartWithFileData:data name:@"voice" fileName:@"voice.amr" mimeType:@"audio/AMR"];
        }
    }];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        YYLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *backInfo = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        signBlock(backInfo,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        signBlock(nil,error);
    }];
    [operation start];
}
    
@end
