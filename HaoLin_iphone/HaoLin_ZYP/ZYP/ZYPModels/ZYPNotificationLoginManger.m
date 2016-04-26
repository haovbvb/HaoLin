//
//  ZYPNotificationLoginManger.m
//  HaoLin
//
//  Created by mac on 14-9-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPNotificationLoginManger.h"

@implementation ZYPNotificationLoginManger
/**
 *  通知实现
 *
 *  @param controller 传过来的controller
 */
+ (void)getNotificationFromController:(UIViewController *)controller
{
    HSPLoginViewController *loginvc = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
    [controller presentViewController:loginvc animated:YES completion:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginIn:) name:zypNotificationLogin object:controller];
}
/**
 *  收到通知出发的方法
 *
 *  @param no NSNotification实例
 */
- (void)loginIn:(NSNotification *)no
{
    UIViewController *vc = [no object];
    HSPLoginViewController *loginvc = [[HSPLoginViewController alloc] initWithNibName:@"HSPLoginViewController" bundle:nil];
    [vc presentViewController:loginvc animated:YES completion:nil];
}
/**
 *  移除观察者实现
 */
+ (void)freeInstance
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:zypNotificationLogin object:nil];
}

@end