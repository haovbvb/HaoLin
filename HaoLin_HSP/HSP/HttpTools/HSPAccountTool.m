//
//  HSPAccountTool.m
//  HaoLin
//
//  Created by PING on 14-9-1.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPAccountTool.h"
static HSPAccountTool *hspAcount = nil;
static HSPAccount *userInfo = nil;
@implementation HSPAccountTool

+ (BOOL)saveAccount:(HSPAccount *)account
{
    // 获取doc的目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"account.data"];
    
    // 存储返回的用户信息
    return  [NSKeyedArchiver archiveRootObject:account toFile:filePath];
}

+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hspAcount=[[HSPAccountTool alloc] init];
    });
    return;
}

+ (HSPAccount *)account
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[HSPAccount alloc] init];
    });
    return userInfo;
    
//    // 获取doc的目录
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *filePath = [docPath stringByAppendingPathComponent:@"account.data"];
//    
//    // 获取用户存储的授权信息
//    HSPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (BOOL)clearAccount:(HSPAccount *)account
{
    account.userTokenid = @"";
    account.user_id = @"";
    account.nickname = @"";
    account.headimg = @"";
    account.user_mark = @"";
    account.range_type = @"";
    return YES;
}



@end
