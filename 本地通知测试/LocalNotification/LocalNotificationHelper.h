//
//  LocalNotificationHelper.h
//  iOS本地通知demo
//
//  Created by JGPeng on 17/6/16.
//  Copyright © 2017年 ;. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationHelper : NSObject


#pragma mark - 所有本地通知创建的方法 －－
/**
 创建本地通知的方法 －－ 适配 iOS 10
 @param title 弹框的标题
 @param fireTime 事件触发的时间  @"yyyy-MM-dd HH:mm:ss"
 @param body 弹框的内容
 @param userInfo 包含的字典信息
 */
+ (void)CreateNotificationWithTitle:(NSString *)title
                           FireTime:(NSString *)fireTime
                               Body:(NSString *)body
                           UserInfo:(NSDictionary *)userInfo;


#pragma mark - 所有的本地通知都会进入该方法 已经适配iOS 10 －－
+ (void)ConfigLocalNotification:(NSDictionary *)info;


// 按钮测试用  －－
+ (void)SendFire;

@end
