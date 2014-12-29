//
//  BackBtn.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-17.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 自定义NavigationBarItem
 */
@interface MyBarBtnItem : UIBarButtonItem
/**
 *  使用图片和标题初始化返回按钮
 *
 *  @param imgName  图片
 *  @param title    标题
 *  @param target   目标
 *  @param action   方法
 *
 *  @return 导航栏按钮
 */
- (instancetype)initWithImageName:(NSString *)imgName withTitle:(NSString *)title withTarget:(id)target withAction:(SEL)action;

/**
 *  使用标题初始化返回按钮
 *
 *  @param title  标题
 *  @param target 目标
 *  @param action 方法
 *
 *  @return 导航栏按钮
 */
- (instancetype)initWithTitle:(NSString *)title withTarget:(id)target withAction:(SEL)action;
/**
 *  初始化返回按钮，点击默认返回上一页
 *
 *  @param imgName 图片
 *  @param title   标题
 *  @param vc      视图控制器
 *
 *  @return 导航栏按钮
 */
- (instancetype)initDefaultClickBackWithImageName:(NSString *)imgName withTitle:(NSString *)title withViewController:(UIViewController *)vc;
@end