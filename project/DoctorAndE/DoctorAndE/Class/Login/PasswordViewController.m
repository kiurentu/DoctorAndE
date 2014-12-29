//
//  passwordViewController.m
//  DoctorAndE
//
//  Created by Krt on 14/11/5.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "PasswordViewController.h"
#import "FinshiRegisterViewController.h"
#import "RegexKitLite.h"
#import "Tools.h"
#import "STUNet.h"

@interface PasswordViewController () <STUNetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfPsw;
@property (weak, nonatomic) IBOutlet UITextField *tfPswRepeat;
@property (strong, nonatomic) STUNet *net;
@end

@implementation PasswordViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"账户注册" withViewController:self];

	self.net = [[STUNet alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)exitClick:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
	[self.view endEditing:YES];

	NSString *psw = _tfPsw.text;
	NSString *pswRepeat = _tfPswRepeat.text;

	if (![psw length]) {
		[_tfPsw becomeFirstResponder];
		[Tools showMessage:@"密码不能为空"];
	}
	else if (![pswRepeat length]) {
		[_tfPswRepeat becomeFirstResponder];
		[Tools showMessage:@"密码不能为空"];
	}
	else if ([psw isMatchedByRegex:REGEX_PSW]) {
		if ([psw isEqualToString:pswRepeat]) {
			NSDictionary *dic = @{ @"phone":_phone, @"password":psw, @"nickName":_name };
			[_net requestTag:@"__register__" andUrl:URL_REGISTER andBody:dic andShowDiaMsg:DEFAULT_TITLE];
		}
		else {
			[_tfPswRepeat becomeFirstResponder];
			[Tools showMessage:@"确认密码有误"];
		}
	}
	else {
		[_tfPsw becomeFirstResponder];
		[Tools showMessage:@"密码必须为数字、下划线与字母组合且长度为6-30"];
	}
}

- (IBAction)dissmissKey:(id)sender {
	[self.view endEditing:YES];
}

- (IBAction)editDidEnd:(id)sender {
	if (sender == _tfPsw) {
		[_tfPswRepeat becomeFirstResponder];
	}
	else {
		[self next:nil];
	}
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
	switch ([dic[@"code"] intValue]) {
		case 0:
		{
			FinshiRegisterViewController *nextF = [[FinshiRegisterViewController alloc] init];
			nextF.phone = _phone;
			nextF.name = _name;
			[self.navigationController pushViewController:nextF animated:YES];
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

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
	[Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}

@end
