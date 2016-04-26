//
//  ZYPCategaryListObject.h
//  HaoLin
//
//  Created by mac on 14-8-31.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPCategaryListObject : NSObject
@property (nonatomic, strong)NSString *cat_id; //  商品id标示
@property (nonatomic, strong)NSString *cat_pid; //  商品id标示
@property (nonatomic, strong)NSString *cat_name; //  商品id标示
@property (nonatomic, strong)NSString *child; //  商品id标示
- (id)initWithDictionry:(NSDictionary *)dic;
@end
