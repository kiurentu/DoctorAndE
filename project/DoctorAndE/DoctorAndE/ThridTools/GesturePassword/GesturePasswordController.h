//
//  GesturePasswordController.h
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "TentacleView.h"
#import "GesturePasswordView.h"

/**
 *  手势密码的控制器
 */
@interface GesturePasswordController : UIViewController <VerificationDelegate,ResetDelegate,GesturePasswordDelegate>
/**
 *  手势密码控制器的类型
 */
typedef NS_ENUM(NSInteger, GesturePasswordType){
    /**
     *  重置、新建
     */
    GesturePasswordTypeReset = 0,
    /**
     *  验证存在的密码
     */
    GesturePasswordTypeVerify
};
@property (assign, nonatomic) GesturePasswordType type;
- (id)initWithType:(GesturePasswordType) GesturePasswordType;
/**
 *  清空密码
 */
+ (void)clear;
/**
 *  判断是否已存在手势密码
 *
 *  @return 是否存在
 */
+ (BOOL)exist;

@end
