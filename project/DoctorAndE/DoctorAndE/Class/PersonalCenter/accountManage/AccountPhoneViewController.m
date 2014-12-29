//
//  AccountPhoneViewController.m
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#define TAG_CHANGE_USER_PWD @"__userPwd__"//密码
#define TAG_AUTH_PHONE @"__autoPhone__" // 验证手机
#define TAG_GET_AUTH_CODE @"__getAuthCode__" // 获取验证码
#define KEY_USR_GET_AUTH_CODE_TIME @"__getAuthCodeTime__" // 最后获取验证码时间

#import "AccountPhoneViewController.h"
#import "CircleEdge.h"
#import "STUNet.h"
#import "Tools.h"
#import "RegexKitLite.h"
#import "LoginViewController.h"

@interface AccountPhoneViewController () <STUNetDelegate>
{
	STUNet *_net;
}

@end

@implementation AccountPhoneViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"更换绑定手机号码" withViewController:self];

	[CircleEdge changView:self.phoneTF];
	[CircleEdge changView:self.verificationTF];

    //处理键盘事件
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKeyboard)];
	[self.view addGestureRecognizer:tap];

	_net = [[STUNet alloc] initWithDelegate:self];
}

- (void)backKeyboard {
	[self.view endEditing:YES];
}

- (IBAction)passwordClick:(id)sender {
	NSString *phone = _phoneTF.text;
	NSString *psw = _passwordTF.text;

	if (![psw length]) {
		[Tools showMessage:@"密码不能为空"];
	}
	else if ([psw isMatchedByRegex:REGEX_PSW]) {
		NSDictionary *dic = @{ @"phone":phone, @"password":psw };
		[_net requestTag:TAG_CHANGE_USER_PWD andUrl:URL_CHANGE_USER_PHONE andBody:dic andShowDiaMsg:DEFAULT_TITLE];
	}
	else {
		[_passwordTF becomeFirstResponder];
		[Tools showMessage:@"确认密码有误"];
	}
}

- (IBAction)getAuthCodeClick:(id)sender {
	[self.view endEditing:YES];

	if ([_phoneTF.text isMatchedByRegex:REGEX_PHONE]) {
		double d = [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USR_GET_AUTH_CODE_TIME] doubleValue];
		if ([[NSDate date] timeIntervalSince1970] - d > 60) {
			[_net requestTag:TAG_GET_AUTH_CODE andUrl:URL_GET_AUTH_CODE andBody:@{ @"phone":_phoneTF.text } andShowDiaMsg:DEFAULT_TITLE];
		}
		else {
			[Tools showMessage:@"一分钟内只能获取验证码一次，请稍后重试......"];
		}
	}
	else {
		[_phoneTF becomeFirstResponder];
		[Tools showMessage:@"正确填写手机号，我们将向您发送一条验证短信"];
	}
}

- (IBAction)commite:(id)sender {
	NSLog(@"提交");

	NSString *phone = _phoneTF.text;
	NSString *authCode = _verificationTF.text;

	if ([phone length] != 11 || ![phone isMatchedByRegex:REGEX_PHONE]) {
		[_phoneTF becomeFirstResponder];
		[Tools showMessage:@"手机号码错误"];
		return;
	}
	else if (![authCode length]) {
		[_verificationTF becomeFirstResponder];
		[Tools showMessage:@"验证码不能为空"];
		return;
	}
	NSDictionary *dic = @{ @"phone":phone, @"randomCode":authCode };
	[_net requestTag:TAG_AUTH_PHONE andUrl:URL_CHECK_AUTH_CODE andBody:dic andShowDiaMsg:DEFAULT_TITLE];
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
	if ([tag isEqualToString:TAG_GET_AUTH_CODE]) {
		if ([dic[@"code"] intValue]) {
			NSDate *date = [NSDate date];
			[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]] forKey:KEY_USR_GET_AUTH_CODE_TIME];
			NSDateFormatter *f = [[NSDateFormatter alloc] init];
			f.dateFormat = @"yyyy-MM-dd HH:mm";

			[Tools showMessage:[NSString stringWithFormat:@"验证码已发送到%@，请注意查收!", _phoneTF.text]];
		}
		else {
			[Tools showMessage:@"获取验证码失败，手机号码已被注册"];
		}
	}
	else if ([tag isEqualToString:TAG_AUTH_PHONE]) {
		if ([dic[@"code"] intValue]) {
			[self backKeyboard];
			[CircleEdge changView:_passwordMainView];
			[CircleEdge changView:_passwordTF];
			_passWordViw.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.55];
			[[UIApplication sharedApplication].keyWindow addSubview:_passWordViw];
			UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKeyboard)];
			[_passWordViw addGestureRecognizer:tap];
		}
		else {
			[_verificationTF becomeFirstResponder];
			[Tools showMessage:@"验证码错误"];
		}
	}
	else {
		switch ([dic[@"code"] intValue]) {
			case 0:
			{
				[_passWordViw removeFromSuperview];
				LoginViewController *login = [[LoginViewController alloc] init];
				TOKEN = @"";
				[self.navigationController pushViewController:login animated:YES];
				break;
			}

			case 1:
				[Tools showMessage:@"手机号码已存在，不能重复注册"];
				break;

			case 2:
				[Tools showMessage:@"没有获取验证码，便直接走注册步骤，注册失败"];
				break;

			case 3:
				[Tools showMessage:@"其他原因注册失败"];
				break;

			default:
				[Tools showMessage:@"未知错误"];
				break;
		}
	}
}

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
	[Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}

@end
