//
//  MQLAppDelegate.m
//  HaoLin
//
//  Created by mac on 14-8-7.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLAppDelegate.h"

@interface MQLAppDelegate ()<BPushDelegate>

@end

@implementation MQLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];

    if (IS_IOS8) {
        
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }else{
        
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }

    
    self.rootViewController = [[MQLCustomTabBarController alloc]init];
    self.window.rootViewController = self.rootViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [MQLDeviceDataManage sharedInstance].deviceToken = [[NSString alloc]initWithData:deviceToken encoding:NSUTF8StringEncoding];
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannel];
    
}

#pragma mark -- BPushDelegate
- (void)onMethod:(NSString*)method response:(NSDictionary*)data
{
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];

        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            
            // 在内存中备份，以便短时间内进入可以看到这些值，而不需要重新bind
            [MQLDeviceDataManage sharedInstance].baiDuPushAppId = appid;
            [MQLDeviceDataManage sharedInstance].baiDuPushChannelId = channelid;
            [MQLDeviceDataManage sharedInstance].baiDuPushUserId = userid;
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    [application setApplicationIconBadgeNumber:0];
    int code = [[userInfo objectForKey:@"code"]intValue];
    
    NSString *notification = nil;
    switch (code) {
        case 1010://推送给商户的喊单信息
        {
            notification = NotificationOfSendToBusiness;
        }
            break;
        case 1011://推送给用户的喊单信息
        {
            notification = NotificationOfSendToPersonal;
        }
            break;
        default:
            break;
    }

    if (notification) {
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:notification object:nil userInfo:userInfo];
    }
}

@end
