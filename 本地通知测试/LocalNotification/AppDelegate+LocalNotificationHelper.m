//
//  AppDelegate+LocalNotificationHelper.m
//  iOS本地通知demo
//
//  Created by JGPeng on 17/6/16.
//  Copyright © 2017年 JinGuangPeng. All rights reserved.
//

#import "AppDelegate+LocalNotificationHelper.h"
#import "LocalNotificationHelper.h"


@implementation AppDelegate (LocalNotificationHelper)


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // iOS 10 使用以下方法注册，才能得到授权
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
      }];
#else
    // Override point for customization after application launch.
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    // 这边是推出状态下收到通知
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        //添加处理代码
        UILocalNotification * notf = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
        NSDictionary * dic = notf.userInfo;
        [LocalNotificationHelper ConfigLocalNotification:dic];
    }
#endif
       return YES;
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    // 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    [LocalNotificationHelper ConfigLocalNotification:response.notification.request.content.userInfo];
    completionHandler();
}
#else
#pragma mark - 这边是本地通知程序退出收到通知再次进入后调用的方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    [LocalNotificationHelper ConfigLocalNotification:notification.userInfo];
}
#endif




@end
