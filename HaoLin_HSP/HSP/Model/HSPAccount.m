//
//  HSPAccount.m
//  HaoLin
//
//  Created by PING on 14-9-1.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPAccount.h"

@implementation HSPAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    HSPAccount *account = [HSPAccountTool account];
    account.userTokenid = [dict objectForKey:@"Tokenid"];
    account.user_id = [dict objectForKey:@"user_id"];
    account.nickname = [dict objectForKey:@"nickname"];
    account.headimg = [dict objectForKey:@"headimg"];
    account.user_mark = [dict objectForKey:@"user_mark"];
    account.range_type = [dict objectForKey:@"range_type"];
    account.delivery_address = [dict objectForKey:@"delivery_address"];
    return account;
    
}

+ (void)clearAccount
{
    HSPAccount *account = [HSPAccountTool account];
    account.userTokenid = @"";
    account.user_id = @"";
    account.nickname = @"";
    account.headimg = @"";
    account.user_mark = @"";
    account.range_type = @"";
}

/**
 *   归档一个对象到文件中的时候会调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userTokenid forKey:@"tokenid"];
    [encoder encodeObject:self.user_id forKey:@"user_id"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.headimg forKey:@"headimg"];
    [encoder encodeObject:self.user_mark forKey:@"user_mark"];
    [encoder encodeObject:self.range_type forKey:@"range_type"];
}

/**
 *  解归档一个数据的时候会调用

 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.userTokenid = [decoder decodeObjectForKey:@"tokenid"];
        self.user_id = [decoder decodeObjectForKey:@"user_id"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.headimg = [decoder decodeObjectForKey:@"headimg"];
        self.user_mark = [decoder decodeObjectForKey:@"user_mark"];
        self.range_type = [decoder decodeObjectForKey:@"range_type"];
    }
    return self;
}

@end
