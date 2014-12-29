//
//  Tools.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-4.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  工具集合
 */
@interface Tools : NSObject

/**
 *  显示一个信息提示，1.8秒后消失
 *
 *  @param message 提示的信息
 */
+ (void)showMessage:(NSString *)message;

/**
 *  显示一个信息提示框
 *
 *  @param message 提示的信息
 *  @param sec     显示时间（秒）
 */
+ (void)showMessage:(NSString *)message andTime:(float)sec;

/**
 *  使用颜色创建图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  创建一个NavigationBar的返回按钮(废弃，请使用createNavigationBarWithImageName:withTItle:andTarget:action或者createDefaultClickBackBtnWithTitle:withViewController:)
 *
 *  @param title  标题
 *  @param target 目标
 *  @param action 方法
 *
 *  @return NavigationBar的按钮
 */
+ (UIBarButtonItem *)createNavigationBarBackBtn:(NSString *)title andTarget:(id)target action:(SEL)action NS_DEPRECATED_IOS(2_0, 3_0);
/**
 *  创建一个NavigationBar的返回按钮，默认点击返回上一页
 *
 *  @param title 标题
 *  @param vc    视图控制器
 *
 *  @return NavigationBar的按钮
 */
+ (UIBarButtonItem*)createDefaultClickBackBtnWithTitle:(NSString*)title withViewController:(UIViewController*)vc;
/**
 *  创建一个NavigationBar的返回按钮
 *
 *  @param title  标题
 *  @param target 目标
 *  @param action 方法
 *
 *  @return NavigationBar的按钮
 */
+ (UIBarButtonItem*)createNavigationBarWithTitle:(NSString *)title andTarget:(id)target action:(SEL)action;
/**
 *  创建一个NavigationBar的返回按钮
 *
 *  @param imgName 图片
 *  @param title   标题
 *  @param target  目标
 *  @param action  方法
 *
 *  @return NavigationBar的按钮
 */
+ (UIBarButtonItem*)createNavigationBarWithImageName:(NSString*)imgName withTitle:(NSString *)title andTarget:(id)target action:(SEL)action;
@end