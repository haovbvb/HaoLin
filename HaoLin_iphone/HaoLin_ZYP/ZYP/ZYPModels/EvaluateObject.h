//
//  EvaluateObject.h
//  HaoLin
//
//  Created by mac on 14-9-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluateObject : NSObject
@property (nonatomic, strong)NSString *comment_id;//评价内容id
@property (nonatomic, strong)NSString *merchant_id;//商户id
@property (nonatomic, strong)NSString *score;//评价分数（星星）
@property (nonatomic, strong)NSString *comment_info;//评价内容
@property (nonatomic, strong)NSString *comment_uid;//评价者id
@property (nonatomic, strong)NSString *nickname;//评价者昵称
@property (nonatomic, strong)NSString *createtime;//评价时间
- (id)initEvaluateObjectWithDic:(NSDictionary *)dic;
@end
