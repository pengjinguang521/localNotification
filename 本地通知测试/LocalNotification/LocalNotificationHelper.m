//
//  LocalNotificationHelper.m
//  iOS本地通知demo
//
//  Created by JGPeng on 17/6/16.
//  Copyright © 2017年 JinGuangPeng. All rights reserved.
//

#import "LocalNotificationHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "AppDelegate+LocalNotificationHelper.h"
#import <UIKit/UIKit.h>

#define DateFormatType                        @"yyyy-MM-dd HH:mm:ss"
@implementation LocalNotificationHelper



// 这边是对收到通知 即 点击消息栏的事件处理
+ (void)ConfigLocalNotification:(NSDictionary *)info{

    // 1.6.设置应用图标左上角显示的数字
    [UIApplication sharedApplication].applicationIconBadgeNumber -= 1;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Title" message:[NSString stringWithFormat:@"%@",info] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}



/**
 创建本地通知的方法 －－ 适配 iOS 10
 @param title 弹框的标题
 @param fireTime 事件触发的时间
 @param body 弹框的内容
 @param userInfo 包含的字典信息
 */
+ (void)CreateNotificationWithTitle:(NSString *)title
                           FireTime:(NSString *)fireTime
                               Body:(NSString *)body
                           UserInfo:(NSDictionary *)userInfo{
    
    int count = [LocalNotificationHelper countTimeIntervalWithShould:fireTime];
#ifdef NSFoundationVersionNumber_iOS_9_x_Max  // iOS 10的通知
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = userInfo;
    // 在 设定时间 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:count repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond" content:content trigger:trigger];
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {}];
    
#else  //   iOS 10以下的通知
    // 1.创建一个本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    // 1.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:count];
    // 1.2.设置通知内容
    localNote.alertBody = body;
    // 1.3.设置锁屏时,字体下方显示的一个文字
    localNote.alertTitle = title;
    localNote.hasAction = YES;
    // 1.5.设置通过到来的声音
    localNote.soundName = UILocalNotificationDefaultSoundName;

    // 1.7.设置一些额外的信息
    localNote.userInfo = userInfo;
    // 2.执行通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
#endif


}
+ (void)SendFire{
    NSLog(@"发出通知");
#ifdef NSFoundationVersionNumber_iOS_9_x_Max  // iOS 10的通知
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"本地推送Title" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"本地推送Body"  arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"hello" : @"how are you", @"msg" : @"success"};
    // 在 设定时间 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond" content:content trigger:trigger];
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {}];
    
#else  //   iOS 10以下的通知
    // 1.创建一个本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    // 1.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    // 1.2.设置通知内容
    localNote.alertBody = @"这是一个本地推送";
    // 1.3.设置锁屏时,字体下方显示的一个文字
    localNote.alertAction = @"看我";
    localNote.hasAction = YES;
    // 1.4.设置启动图片(通过通知打开的)
    localNote.alertLaunchImage = @"../Documents/1.jpg";
    // 1.5.设置通过到来的声音
    localNote.soundName = UILocalNotificationDefaultSoundName;
    // 1.6.设置应用图标左上角显示的数字
    localNote.applicationIconBadgeNumber = 1;
    // 1.7.设置一些额外的信息
    localNote.userInfo = @{@"hello" : @"how are you", @"msg" : @"success"};
    // 2.执行通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
#endif
}
//判断[当前时间]与[结束时间]中间的秒数  为0 已结束
+ (int)countTimeIntervalWithShould:(NSString *)shouldDateString{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:DateFormatType];
    NSDate * checkDate = [dateFormatter dateFromString:[LocalNotificationHelper GetCurrentTime]];
    NSDate *shouldDate = [dateFormatter dateFromString:shouldDateString];
    NSTimeInterval interval1 = [checkDate timeIntervalSince1970];
    NSTimeInterval interval2 = [shouldDate timeIntervalSince1970];
    double interval = interval2-interval1;
    if (interval < 0) {
        interval = 0;
    }
    return interval;
}

//获取当前时间
+ (NSString *)GetCurrentTime{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:DateFormatType];
    NSString * localTime = [dateFormatter stringFromDate:date];
    return localTime;
}




@end
