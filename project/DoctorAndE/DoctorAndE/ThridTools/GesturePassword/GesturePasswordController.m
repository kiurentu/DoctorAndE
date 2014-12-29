//
//  GesturePasswordController.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>
#import "GesturePasswordController.h"
#import "KeychainItemWrapper.h"
#import "Tools.h"
#import "AppDelegate.h"

#define KEYCHAIN_IDENTIFIER @"__DoctorAndE_Config__"
#define COLOR_MAIN ([UIColor colorWithRed:20.0f / 255 green:166.0f / 255 blue:116.0f / 255 alpha:1.0f])
#define KEY_USR_SURPLUS_COUNT @"__surplusCount__" // 验证错误剩余次数
#define KEY_USR_SURPLUS_COUNT_IS_ZERO @"__surplusCountISZeroTime__" // 验证错误次数为0的时间戳

@interface GesturePasswordController () <UIAlertViewDelegate>

@property (nonatomic, strong) GesturePasswordView *gesturePasswordView;

@end

@implementation GesturePasswordController {
    NSString    *previousString;
    NSString    *password;
}

@synthesize gesturePasswordView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
        self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"创建手势密码" withViewController:self];
    }

    return self;
}

- (id)initWithType:(GesturePasswordType)GesturePasswordType
{
    self = [super init];

    if (self) {
        self.type = GesturePasswordType;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect f = self.view.frame;
    self.view.frame = (CGRect){ {0,0}, f.size };//待删
    previousString = [NSString string];
    KeychainItemWrapper *keychin = [[KeychainItemWrapper alloc]initWithIdentifier:KEYCHAIN_IDENTIFIER accessGroup:nil];
    password = [keychin objectForKey:(__bridge id)kSecAttrAccount];
    if (self.type == GesturePasswordTypeReset) {
        [self reset];
    } else if (self.type == GesturePasswordTypeVerify) {
        [self verify];
    } else if ([password isEqualToString:@""]) {
        [self reset];
    } else {
        [self verify];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)verify
{
    gesturePasswordView = [[GesturePasswordView alloc] initWithFrame:self.view.frame andType:GesturePasswordTypeVerify];
    gesturePasswordView.gesturePasswordDelegate = self;
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:TentacleViewStyleVerify];
    gesturePasswordView.state.text = @"请绘制手势密码";
    [gesturePasswordView setGesturePasswordDelegate:self];
    [gesturePasswordView.cancleBtn setHidden:YES];
    [gesturePasswordView.goOnBtn setHidden:YES];
    [self.view addSubview:gesturePasswordView];
    [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:KEY_USR_SURPLUS_COUNT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)reset
{
    gesturePasswordView = [[GesturePasswordView alloc] initWithFrame:self.view.frame andType:GesturePasswordTypeReset];
    gesturePasswordView.gesturePasswordDelegate = self;
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:TentacleViewStyleReset];
    gesturePasswordView.state.text = @"绘制解锁图案";
    [gesturePasswordView.forgetButton setHidden:YES];
    [self.view addSubview:gesturePasswordView];
}

+ (BOOL)exist
{
    KeychainItemWrapper *keychin = [[KeychainItemWrapper alloc]initWithIdentifier:@"__DoctorAndE_Config__" accessGroup:nil];
    NSString            *password = [keychin objectForKey:(__bridge id)kSecAttrAccount];
    return [password isEqualToString:@""] ? NO : YES;
}

+ (void)clear
{
    KeychainItemWrapper *keychin = [[KeychainItemWrapper alloc]initWithIdentifier:KEYCHAIN_IDENTIFIER accessGroup:nil];
    [keychin setObject:@"" forKey:(__bridge id)kSecAttrAccount];
}

- (void)forget
{
    UIAlertView *dia = [[UIAlertView alloc] initWithTitle:@"" message:@"点击确定将清空手势密码并重新登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    dia.title = @"忘记密码";
    [dia show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [APP clearUsrLoginInfo];
        APP.gestureIsShow = NO;
        if(self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [AppDelegate notificationInitController:InitLoginController];
    }
}

- (void)leftBtn:(UIButton *)btn
{
    NSString *title = btn.titleLabel.text;
    if ([title isEqualToString:@"取消"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        previousString = @"";
        UIButton *rBtn = gesturePasswordView.goOnBtn;
        rBtn.backgroundColor = [UIColor clearColor];
        rBtn.enabled = NO;
        [btn setTitle:@"继续" forState:UIControlStateNormal];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        previousString = [NSString string];
        gesturePasswordView.state.text = @"绘制解锁图案";
        gesturePasswordView.tentacleView.userInteractionEnabled = YES;
        [gesturePasswordView.tentacleView enterArgin];
    }
}

- (void)rightBtn:(UIButton *)btn
{
    NSString *title = btn.titleLabel.text;
    if ([title isEqualToString:@"继续"]) {
        gesturePasswordView.state.text = @"请再次绘制解锁图案";
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.enabled = NO;
        [gesturePasswordView.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        gesturePasswordView.tentacleView.userInteractionEnabled = YES;
        [gesturePasswordView.tentacleView enterArgin];
    } else {
        KeychainItemWrapper *keychin = [[KeychainItemWrapper alloc]initWithIdentifier:KEYCHAIN_IDENTIFIER accessGroup:nil];
        [keychin setObject:previousString forKey:(__bridge id)kSecAttrAccount];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_USR_ON_OFF];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  验证手势密码是否正确
 *
 *  @param result 需要验证的密码
 *
 *  @return 手势密码是否正确
 */
- (BOOL)verification:(NSString *)result
{
    if ([result isEqual:@""]) {
        [gesturePasswordView.state setText:@"请绘制手势密码"];
        return NO;
    }

    int time = [[NSDate date] timeIntervalSince1970] - [[NSUserDefaults standardUserDefaults] integerForKey:KEY_USR_SURPLUS_COUNT_IS_ZERO];
    
    if (result.length < 4) {
        [Tools showMessage:@"输入长度不够，请重试"];
        return NO;
    } else if(time < 30){
        [Tools showMessage:[NSString stringWithFormat:@"密码输入错误次数过多，请%d秒后重试", 30-time]];
        return NO;
    } else if ([result isEqualToString:password]) {
        APP.gestureIsShow = NO;
        if(self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        return YES;
    }
    
    int surplusCount = [[NSUserDefaults standardUserDefaults] integerForKey:KEY_USR_SURPLUS_COUNT] - 1;
    if(surplusCount){
        [gesturePasswordView.state setTextColor:[UIColor redColor]];
        [gesturePasswordView.state setText:[NSString stringWithFormat:@"密码错误，还可以再输入%d次", surplusCount] ];
    } else {
        [[NSUserDefaults standardUserDefaults] setInteger:
         [[NSDate date] timeIntervalSince1970] forKey:KEY_USR_SURPLUS_COUNT_IS_ZERO];
        [Tools showMessage:@"密码输入错误次数过多，请30秒后重试"];
    }
    [[NSUserDefaults standardUserDefaults] setInteger:surplusCount forKey:KEY_USR_SURPLUS_COUNT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    CALayer             *lbl = [gesturePasswordView.state layer];
    CGPoint             posLbl = [lbl position];
    CGPoint             y = CGPointMake(posLbl.x - 8, posLbl.y);
    CGPoint             x = CGPointMake(posLbl.x + 8, posLbl.y);
    CABasicAnimation    *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
    return NO;
}

- (BOOL)resetPassword:(NSString *)result
{
    if ([result isEqual:@""]) {
        [gesturePasswordView.state setText:@"请绘制手势密码"];
        return NO;
    } else if([result length] < 4){
        [Tools showMessage:@"输入长度不够，请重试"];
        [gesturePasswordView.state setText:@"请绘制手势密码"];
        return NO;
    }

    if ([previousString isEqualToString:@""]) {
        previousString = result;
        [gesturePasswordView.state setTextColor:[UIColor blackColor]];
        [gesturePasswordView.state setText:@"图案已记录"];
        [gesturePasswordView.cancleBtn setTitle:@"重试" forState:UIControlStateNormal];
        gesturePasswordView.goOnBtn.enabled = YES;
        gesturePasswordView.goOnBtn.titleLabel.text = @"继续";
        gesturePasswordView.goOnBtn.backgroundColor = COLOR_MAIN;
        gesturePasswordView.tentacleView.userInteractionEnabled = NO;
        return YES;
    } else if (result.length < 4) {
        [gesturePasswordView.state setTextColor:[UIColor redColor]];
        [gesturePasswordView.state setText:@"手势密码长度最少为4"];
        return NO;
    } else {
        if ([result isEqualToString:previousString]) {
            [gesturePasswordView.state setTextColor:[UIColor blackColor]];
            [gesturePasswordView.state setText:@"确认保存新解锁图案"];
            gesturePasswordView.tentacleView.userInteractionEnabled = NO;
            gesturePasswordView.goOnBtn.backgroundColor = COLOR_MAIN;
            gesturePasswordView.goOnBtn.enabled = YES;
            return YES;
        } else {
            [gesturePasswordView.state setTextColor:[UIColor redColor]];
            [gesturePasswordView.state setText:@"与上次输入不一致，请重试"];
            return NO;
        }
    }
}

@end