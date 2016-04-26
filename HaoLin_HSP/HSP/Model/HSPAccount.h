//
//  HSPAccount.h
//  HaoLin
//
//  Created by PING on 14-9-1.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSPAccount : NSObject

@property (nonatomic, copy) NSString *userTokenid;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *user_mark;
@property (nonatomic, copy) NSString *range_type;
@property (nonatomic, copy) NSString *delivery_address;

+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
