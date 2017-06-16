//
//  AppDelegate+LocalNotificationHelper.h
//  iOS本地通知demo
//
//  Created by JGPeng on 17/6/16.
//  Copyright © 2017年 JinGuangPeng. All rights reserved.
//

#import "AppDelegate.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
@interface AppDelegate (LocalNotificationHelper)<UNUserNotificationCenterDelegate>
#else
@interface AppDelegate (LocalNotificationHelper)
#endif

@end
