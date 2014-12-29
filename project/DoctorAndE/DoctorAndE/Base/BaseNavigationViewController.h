//
//  BaseViewController.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-5.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  控制TabBar的Hidden的代理
 */
@protocol TabBarHidden <NSObject>
- (void)setTabBarHidden:(BOOL)hidden;
@end

/**
 *  NavigationController基类，控制TabBar显示和隐藏
 */
@interface BaseNavigationViewController : UINavigationController
{
    @private
    BOOL isFirst;
}
@property (weak, nonatomic) id<TabBarHidden> tabBarHiddenDelegate;
@end
