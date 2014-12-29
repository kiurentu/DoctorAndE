//
//  passwordFindViewController.m
//  DoctorAndE
//
//  Created by Krt on 14/11/6.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "PasswordFindViewController.h"
#import "RegexKitLite.h"
#import "Tools.h"
#import "STUNet.h"

#define TAG_AUTH_PHONE              @"__autoPhone__"                // 验证手机
#define TAG_GET_AUTH_CODE           @"__getAuthCode__"              // 获取验证码
#define KEY_USR_GET_AUTH_CODE_TIME  @"__getFindPswAuthCodeTime__"   // 最后获取验证码时间

@interface PasswordFindViewController () <STUNetDelegate>
@property (strong, nonatomic) STUNet *net;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfAuthCode;
@end

@implementation PasswordFindViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	self.net = [[STUNet alloc] initWithDelegate:self];

    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"找回密码" withViewController:self];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)getAuthCode:(id)sender {
	[self.view endEditing:YES];

	if ([_tfPhone.text isMatchedByRegex:REGEX_PHONE]) {
		double d = [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USR_GET_AUTH_CODE_TIME] doubleValue];

		if ([[NSDate date] timeIntervalSince1970] - d > 60) {
			[_net requestTag:TAG_GET_AUTH_CODE andUrl:URL_GET_FIND_PSW_AUTH_CODE andBody:@{ @"phone":_tfPhone.text } andShowDiaMsg:DEFAULT_TITLE];
		}
		else {
			[Tools showMessage:@"一分钟内只能获取验证码一次，请稍后重试......"];
		}
	}
	else {
		[_tfPhone becomeFirstResponder];
		[Tools showMessage:@"正确填写手机号，我们将向您发送一条验证短信"];
	}
}

- (IBAction)commitForgetPsw:(id)sender {
	NSString *phone = _tfPhone.text;
	NSString *code = _tfAuthCode.text;

	if (![phone length]) {
		[_tfPhone becomeFirstResponder];
		[Tools showMessage:@"请输入您的手机号码"];
	}
	else if (![code length]) {
		[_tfAuthCode becomeFirstResponder];
		[Tools showMessage:@"验证码不能为空"];
	}
	else if (([phone length] != 11) || ![phone isMatchedByRegex:REGEX_PHONE]) {
		[_tfPhone becomeFirstResponder];
		[Tools showMessage:@"手机号码错误"];
		return;
	}

	NSDictionary *dic = @{ @"phone":phone, @"randomCode":code };
	[_net requestTag:TAG_AUTH_PHONE andUrl:URL_CHECK_AUTH_CODE andBody:dic andShowDiaMsg:DEFAULT_TITLE];
}

- (void)exitClick:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)dissmissKey:(id)sender {
	[self.view endEditing:YES];
}

- (IBAction)editDidEnd:(id)sender {
	[self commitForgetPsw:nil];
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
	if ([tag isEqualToString:TAG_GET_AUTH_CODE]) {
		if ([dic[@"code"] intValue]) {
			[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]] forKey:KEY_USR_GET_AUTH_CODE_TIME];
			[Tools showMessage:[NSString stringWithFormat:@"验证码已发送到%@，请注意查收!", _tfPhone.text]];
		}
		else {
			[_tfPhone becomeFirstResponder];
			[Tools showMessage:@"该手机号码还没有注册"];
		}
	}
	else {
		switch ([dic[@"code"] intValue]) {
			case 0:
				[_tfAuthCode becomeFirstResponder];
				[Tools showMessage:@"验证码不一致"];
				break;

			case 1:
				[self.navigationController popToRootViewControllerAnimated:YES];
				[Tools showMessage:@"密码成功找回，新密码已发送到您的手机，请注意查收！"];
				break;

			case 2:
				[Tools showMessage:@"用户未注册"];
				break;

			case 3:
				[Tools showMessage:@"非主手机号操作，密码不能重置"];
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
