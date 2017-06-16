//
//  ViewController.m
//  本地通知测试
//
//  Created by JGPeng on 17/6/16.
//  Copyright © 2017年 JinGuangPeng. All rights reserved.
//

#import "ViewController.h"
#import "LocalNotificationHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LocalNotificationHelper CreateNotificationWithTitle:@"测试" FireTime:@"2017-06-16 15:26:50" Body:@"测试用类" UserInfo:@{@"name":@"guang"}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
