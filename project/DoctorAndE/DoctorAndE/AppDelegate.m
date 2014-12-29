//
//  AppDelegate.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TabBarViewController.h"
#import "GesturePasswordController.h"

#define NTFC_INIT_CONTROLLER @"ntfcInitController" // 一个初始化控制器的通知

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationInitController:) name:NTFC_INIT_CONTROLLER object:nil];

    if(ISDEBUG){
        [self initTabBarController];
    }else{
        BOOL isBeforLogin = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_IS_BEFOR_LOGIN];
        if(isBeforLogin && (!TOKEN || [TOKEN isEqualToString:@""])){
            [self initLoginController];
        }else{
            [self initTabBarController];
        }
    }
    [self isShouldShowGesturePsw];
    return YES;
}

+ (void)notificationInitController:(InitController)Init {
    [[NSNotificationCenter defaultCenter] postNotificationName:NTFC_INIT_CONTROLLER object:@(Init)];
}

// 收到通知
- (void)notificationInitController:(NSNotification*) notification {
    if([notification.object intValue]){
        [self initTabBarController];
    }else{
        [self initLoginController];
    }
}

// 初始化登录界面
- (void)initLoginController {
    UINavigationController *login= [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    [login.navigationBar setBackgroundImage:IMAGE(@"total-screen_导航栏normal.png") forBarMetrics:UIBarMetricsDefault];
    self.window.rootViewController = login;
}

// 初始化选项卡控制器，并设置为根视图控制器
- (void)initTabBarController {
    TabBarViewController *tab = [[TabBarViewController alloc] init];
    self.window.rootViewController = tab;
}

/**
 *  是否需要验证手势密码
 */
- (void)isShouldShowGesturePsw
{
    if(!APP.gestureIsShow && [TOKEN length] && [[NSUserDefaults standardUserDefaults] boolForKey:KEY_USR_ON_OFF]) {
        APP.gestureIsShow = YES;
        GesturePasswordController *ges = [[GesturePasswordController alloc] initWithType:GesturePasswordTypeVerify];
        [self.window.rootViewController presentViewController:ges animated:YES completion:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self isShouldShowGesturePsw];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
