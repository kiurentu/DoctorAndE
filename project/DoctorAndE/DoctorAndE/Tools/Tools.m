//
//  Tools.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-4.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "Tools.h"
#import "MBProgressHUD.h"
#import "MyBarBtnItem.h"

@implementation Tools

+ (void)showMessage:(NSString *)message
{
    [Tools showMessage:message andTime:1.8f];
}

+ (void)showMessage:(NSString *)message andTime:(float)sec
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];

    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:13];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:sec];
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIBarButtonItem *)createNavigationBarBackBtn:(NSString *)title andTarget:(id)target action:(SEL)action
{
    return [Tools createNavigationBarWithImageName:@"icon返回" withTitle:title andTarget:target action:action];
}

+ (UIBarButtonItem *)createDefaultClickBackBtnWithTitle:(NSString *)title withViewController:(UIViewController *)vc
{
    return [[MyBarBtnItem alloc] initDefaultClickBackWithImageName:@"icon返回" withTitle:title withViewController:vc];
}

+ (UIBarButtonItem *)createNavigationBarWithTitle:(NSString *)title andTarget:(id)target action:(SEL)action
{
    return [[MyBarBtnItem alloc] initWithTitle:title withTarget:target withAction:action];
}

+ (UIBarButtonItem *)createNavigationBarWithImageName:(NSString *)imgName withTitle:(NSString *)title andTarget:(id)target action:(SEL)action
{
    return [[MyBarBtnItem alloc] initWithImageName:imgName withTitle:title withTarget:target withAction:action];
}

@end