//
//  registerViewController.m
//  DoctorAndE
//
//  Created by Krt on 14/11/5.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "RegisterViewController.h"
#import "passwordViewController.h"
#import "Tools.h"
#import "STUNet.h"
#import "RegexKitLite.h"
#import "RTLabel.h"

#define TAG_AUTH_PHONE              @"__autoPhone__"        // 验证手机
#define TAG_GET_AUTH_CODE           @"__getAuthCode__"      // 获取验证码
#define KEY_USR_GET_AUTH_CODE_TIME  @"__getAuthCodeTime__"  // 最后获取验证码时间

@interface RegisterViewController () <STUNetDelegate>
{
	int subH;
}
@property (strong, nonatomic) STUNet *net;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *authCode;
@property (weak, nonatomic) IBOutlet RTLabel *lbTip;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	self.navigationItem.leftBarButtonItem = [Tools createNavigationBarWithImageName:@"icon返回" withTitle:@"账户注册" andTarget:self action:@selector(exitClick:)];

	self.net = [[STUNet alloc] initWithDelegate:self];
	_lbTip.font = [UIFont systemFontOfSize:12];
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

	NSString *name = _name.text;
	NSString *phone = _phone.text;
	NSString *authCode = _authCode.text;

	if (![name length]) {
		[_name becomeFirstResponder];
		[Tools showMessage:@"请输入您的昵称"];
		return;
	} else if([name length]>10){
        [_name becomeFirstResponder];
		[Tools showMessage:@"昵称长度超过10"];
    }
	else if (![phone length]) {
		[_phone becomeFirstResponder];
		[Tools showMessage:@"请输入您的手机号码"];
		return;
	}
	else if (![authCode length]) {
		[_authCode becomeFirstResponder];
		[Tools showMessage:@"验证码不能为空"];
		return;
	}
	else if (([phone length] != 11) || ![phone isMatchedByRegex:REGEX_PHONE]) {
		[_phone becomeFirstResponder];
		[Tools showMessage:@"手机号码错误"];
		return;
	}

	NSDictionary *dic = @{ @"phone":phone, @"randomCode":authCode };
	[_net requestTag:TAG_AUTH_PHONE andUrl:URL_CHECK_AUTH_CODE andBody:dic andShowDiaMsg:DEFAULT_TITLE];
}

- (IBAction)dissmissKey:(id)sender {
	[self.view endEditing:YES];
}

- (IBAction)getAuthCodeClick:(id)sender {
	[self.view endEditing:YES];

	if ([_phone.text isMatchedByRegex:REGEX_PHONE]) {
		double d = [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USR_GET_AUTH_CODE_TIME] doubleValue];

		if ([[NSDate date] timeIntervalSince1970] - d > 60) {
			[_net requestTag:TAG_GET_AUTH_CODE andUrl:URL_GET_AUTH_CODE andBody:@{ @"phone":_phone.text } andShowDiaMsg:DEFAULT_TITLE];
		}
		else {
			[Tools showMessage:@"一分钟内只能获取验证码一次，请稍后重试......"];
		}
	}
	else {
		[_phone becomeFirstResponder];
		[Tools showMessage:@"正确填写手机号，我们将向您发送一条验证短信"];
	}
}

- (IBAction)editDidEnd:(id)sender {
	if (sender == _name) {
		[_phone becomeFirstResponder];
	}
	else {
		[self next:nil];
	}
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
	if ([tag isEqualToString:TAG_GET_AUTH_CODE]) {
		if ([dic[@"code"] intValue]) {
			NSDate *date = [NSDate date];
			[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]] forKey:KEY_USR_GET_AUTH_CODE_TIME];
			NSDateFormatter *f = [[NSDateFormatter alloc] init];
			f.dateFormat = @"yyyy-MM-dd HH:mm";
			_lbTip.text = [NSString stringWithFormat:@"我司已于 <font color='#0000FF'>%@</font> 向你的手机 <font color='#0000FF'>%@</font> 发送短信动态口令，请及时输入，如未收到动态口令，请重新获取，咨询电话：400-855-3313", [f stringFromDate:date], _phone.text];
			[Tools showMessage:[NSString stringWithFormat:@"验证码已发送到%@，请注意查收!", _phone.text]];
		}
		else {
			[Tools showMessage:@"获取验证码失败，手机号码已被注册"];
		}
	}
	else {
		if ([dic[@"code"] intValue]) {
			PasswordViewController *nextP = [[PasswordViewController alloc]init];
			nextP.phone = _phone.text;
			nextP.name = _name.text;
			[self.navigationController pushViewController:nextP animated:YES];
		}
		else {
			[_authCode becomeFirstResponder];
			[Tools showMessage:@"验证码错误"];
		}
	}
}

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
	[Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}

- (void)applicationDidBecomeActive:(NSNotification *)ntf {
	[self.view endEditing:YES];
}

@end
