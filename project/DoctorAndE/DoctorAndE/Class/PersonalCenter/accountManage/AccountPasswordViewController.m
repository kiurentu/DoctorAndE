//
//  AccountPasswordViewController.m
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import "AccountPasswordViewController.h"
#import "CircleEdge.h"
#import "Tools.h"
#import "STUNet.h"
#import "RegexKitLite.h"
#import "LoginViewController.h"

@interface AccountPasswordViewController () <STUNetDelegate>

@property (strong, nonatomic) STUNet *net;

@end

@implementation AccountPasswordViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"账户密码" withViewController:self];

	[CircleEdge changView:self.oldView];
	[CircleEdge changView:self.pwdView];
	[CircleEdge changView:self.pwdNextView];
    
    //处理键盘事件
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKeyboard)];
	[self.view addGestureRecognizer:tap];
    
    UIBarButtonItem *saveBtn = [Tools createNavigationBarWithTitle:@"保存" andTarget:self action:@selector(newPwd)];
    [self.navigationItem addRightBtn:saveBtn];

	self.net = [[STUNet alloc] initWithDelegate:self];
}

- (void)newPwd {
	[self.view endEditing:YES];

	NSString *oldpwd = _oldPwdTF.text;
	NSString *pwd = _pwdTF.text;
	NSString *pwdNext = _pwdTFNext.text;

	if (![oldpwd length]) {
		[_oldPwdTF becomeFirstResponder];
		[Tools showMessage:@"密码不能为空"];
	}
	else if (![pwd length]) {
		[_pwdTF becomeFirstResponder];
		[Tools showMessage:@"密码不能为空"];
	}
	else if (![pwdNext length]) {
		[_pwdTFNext becomeFirstResponder];
		[Tools showMessage:@"密码不能为空"];
	}

	if ([oldpwd isMatchedByRegex:REGEX_PSW]) {
		if ([pwd isMatchedByRegex:REGEX_PSW]) {
			if ([pwd isEqualToString:pwdNext]) {
				NSDictionary *dic = @{ @"oldPassword": oldpwd, @"newPassword":pwd };
				[_net requestTag:@"__updatePwd__" andUrl:URL_UPDATE_PSW andBody:dic andShowDiaMsg:DEFAULT_TITLE];
			}
			else {
				[_pwdTF becomeFirstResponder];
				[Tools showMessage:@"确认密码有误"];
			}
		}
		else {
			[_pwdTF becomeFirstResponder];
			[Tools showMessage:@"密码必须为数字、下划线与字母组合且长度为6-30"];
		}
	}
	else {
		[_oldPwdTF becomeFirstResponder];
		[Tools showMessage:@"密码必须为数字、下划线与字母组合且长度为6-30"];
	}
}

- (void)backKeyboard {
	[self.view endEditing:YES];
}


- (void)back {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
	if ([dic[@"code"] intValue]) {
		[Tools showMessage:@"密码修改成功"];
		_successView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - _successView.frame.size.height);
		UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
		backgroundView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.75];
		[self.view addSubview:backgroundView];
		[CircleEdge changView:_successView];
		[self.view addSubview:_successView];
	}
	else {
		[Tools showMessage:@"原密码错误"];
	}
}

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
	[Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}

- (IBAction)successClick:(id)sender {
	LoginViewController *login = [[LoginViewController alloc] init];
	TOKEN = @"";
	[self.navigationController pushViewController:login animated:YES];
}

@end
