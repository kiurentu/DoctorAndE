//
//  LoginViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "registerViewController.h"
#import "PasswordFindViewController.h"
#import "STUNet.h"
#import "Tools.h"
#import "SetAddressViewController.h"
#import "KeychainItemWrapper.h"

#define KEY_USER @"__user__" // 账号

@interface LoginViewController () <STUNetDelegate>
{
	int subH;
}
@property (weak, nonatomic) IBOutlet UIButton *btnFindPsw;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UITextField *tfUsr;
@property (weak, nonatomic) IBOutlet UITextField *tfPsw;
@property (weak, nonatomic) IBOutlet UIView *viewEdit;
@property (strong, nonatomic) STUNet *net;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

	if (self) {
		// Custom initialization
	}

	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	[_btnFindPsw setBackgroundImage:IMAGE(@"total-screen_注册pressed") forState:UIControlStateHighlighted];
	[_btnFindPsw setTitleColor:RGBCOLOR(255, 255, 255) forState:UIControlStateHighlighted];
	[_btnRegister setBackgroundImage:IMAGE(@"total-screen_注册pressed") forState:UIControlStateHighlighted];
	[_btnRegister setTitleColor:RGBCOLOR(255, 255, 255) forState:UIControlStateHighlighted];

	NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER];

	if (phone && [phone length]) {
		_tfUsr.text = phone;
	}

    self.navigationItem.leftBarButtonItem = [Tools createNavigationBarWithImageName:@"icon返回" withTitle:@"用户登录" andTarget:self action:@selector(exitClick:)];
	self.navigationItem.rightBarButtonItem = [Tools createNavigationBarWithImageName:@"nav-bar_设置" withTitle:@"" andTarget:self action:@selector(confClick:)];

	self.net = [[STUNet alloc] initWithDelegate:self];

	CGRect f = _viewEdit.frame;
	subH = SCREEN_HEIGHT - f.size.height - f.origin.y - 280;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
	                                             name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)toRegister:(id)sender {
	RegisterViewController *toRe = [[RegisterViewController alloc]init];

	[self.navigationController pushViewController:toRe animated:YES];
}

- (IBAction)findPassword:(id)sender {
	PasswordFindViewController *findPassword = [[PasswordFindViewController alloc]init];

	[self.navigationController pushViewController:findPassword animated:YES];
}

- (IBAction)dimissKey:(id)sender {
	[self.view endEditing:YES];
}

- (IBAction)loginClick:(id)sender {
	[self.view endEditing:YES];

	NSString *usr = _tfUsr.text;
	NSString *psw = _tfPsw.text;

	__weak static UITextField *t = nil;
	int uLength = [usr length];
	int pLength = [psw length];

	NSString *msg = nil;

	if (!uLength) {
		msg = @"账号不允许为空,请输入...";
		t = self.tfUsr;
	}
	else if ((uLength < 6) || (uLength > 30)) {
		msg = @"账号或密码不正确,请重新输入";
		t = self.tfUsr;
	}
	else if (!pLength) {
		msg = @"密码不允许为空,请输入...";
		t = self.tfPsw;
	}
	else if ((pLength < 6) || (pLength > 30)) {
		msg = @"账号或密码不正确,请重新输入";
		t = self.tfPsw;
	}
	else {
		[[NSUserDefaults standardUserDefaults] setObject:self.tfUsr.text forKey:KEY_USER]; // 账号正确，保存账号
		[_net requestTag:@"login" andUrl:URL_LOGIN andBody:@{ @"account":usr ? usr : @"", @"password":psw ? psw : @"" } andShowDiaMsg:@"正在登陆，请稍等..."];
	}

	if (t) {
		[t becomeFirstResponder];
		[Tools showMessage:msg];
	}
}

- (IBAction)editDidEnd:(id)sender {
	[_tfPsw resignFirstResponder];
	[self loginClick:nil];
}

- (void)exitClick:(id)sender {
	if(self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        exit(0);
    }
}

- (void)confClick:(id)sender {
	[self.navigationController pushViewController:[[SetAddressViewController alloc] init] animated:YES];
}

#pragma mark - Notification
- (void)keyboardWillShow:(NSNotification *)ntf {
	if (subH < 0) {
		[UIView animateWithDuration:.3f animations: ^{
		    CGRect f = self.view.frame;
		    f.origin.y += subH;
		    self.view.frame = f;
		}];
	}
}

- (void)keyboardWillHide:(NSNotification *)ntf {
	if (subH < 0) {
		[UIView animateWithDuration:.3f animations: ^{
		    CGRect f = self.view.frame;
		    f.origin.y = 0;
		    self.view.frame = f;
		}];
	}
}

- (void)applicationDidBecomeActive:(NSNotification *)ntf {
	[self.view endEditing:YES];
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
	switch ([dic[@"code"] intValue]) {
		case 0: // 登录成功

			if ([dic[@"token"] isEqualToString:@""]) {
				[Tools showMessage:@"登录错误"];
				return;
			}
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_IS_BEFOR_LOGIN];
			[Tools showMessage:@"登录成功"];
			break;

		case 1: // 账号不存在
			[Tools showMessage:dic[@"reason"]];
			[_tfUsr becomeFirstResponder];
			return;

		case 2: // 密码错误
			[Tools showMessage:dic[@"reason"]];
			[_tfPsw becomeFirstResponder];
			return;

		default:
			[Tools showMessage:@"未知状态"];
			return;
	}

	[[[KeychainItemWrapper alloc]initWithIdentifier:@"__DoctorAndE_Config__" accessGroup:nil] setObject:_tfPsw.text forKey:(__bridge id)kSecValueData];
	TOKEN = dic[@"token"];
	APP.jID = dic[@"userAccount"];

	[UIView animateWithDuration:.3f animations: ^{
	    CGRect f = self.view.frame;
	    f.origin.x = -f.size.width;
	    self.view.frame = f;
	    self.view.alpha = .0f;
	} completion: ^(BOOL finished) {
	    [AppDelegate notificationInitController:InitTabBarController];
	}];
}

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
	[Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

@end
