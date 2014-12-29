//
//  AppDelegate.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

/**
 * 发送通知，设置对应页面
 */
typedef NS_ENUM (NSInteger, InitController){
    InitLoginController = 0, // 设置登录页
    InitTabBarController // 设置选项卡
};
@property (strong, nonatomic) UIWindow *window;

// 发送一个通知，初始化一个控制器，并且把它设置为根控制器
+ (void)notificationInitController:(InitController)Init;

@end
