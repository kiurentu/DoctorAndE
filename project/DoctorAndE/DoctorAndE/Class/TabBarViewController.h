//
//  TabBarViewController.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  各模块的选择界面
 */
@interface TabBarViewController : UITabBarController

// 界面跳转的选择
typedef NS_ENUM (NSInteger, SelectIndex) {
	SelectIndexHome = 0,
	SelectIndexHealthManagement,
	SelectIndexAppCentre,
	SelectIndexPersonalCentre
};

// 发送一个通知，让选项卡跳转到指定页面
+ (void)notificationSelectIndex:(SelectIndex)SelectIndex;
@end
