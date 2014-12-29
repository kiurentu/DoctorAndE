//
//  moresettingViewController.m
//  医+e
//
//  Created by kang on 14-11-3.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import "MoresettingViewController.h"
#import "SetAddressViewController.h"
#import "StateMentViewController.h"
#import "PullDownMenu.h"
#import "GesturePasswordController.h"
#import "AboutingViewController.h"
#import "AppDelegate.h"
#import "Tools.h"

@interface MoresettingViewController () <UIAlertViewDelegate, SetAddressViewDelegate>
{
	BOOL isSelectBtn;
}
@property (weak, nonatomic) IBOutlet UISwitch *switchGesture;

@property (nonatomic, strong) PullDownMenu *pullDownMenu;
@property (nonatomic, strong) NSArray *menuArray;

@property (nonatomic, strong)UIToolbar *tooBar;

@end

@implementation MoresettingViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = kGlobalBg;

    
	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"更多设置" withViewController:self];

	isSelectBtn = NO;
	self.GTpasswordBtn.userInteractionEnabled = isSelectBtn;
	[self.GTPSelectBtn addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
	//设置按钮
	[self setButtonView];
}

- (void)selectBtn {
	self.GTPSelectBtn.selected = !self.GTPSelectBtn.selected;
	isSelectBtn = self.GTPSelectBtn.selected;
	self.GTpasswordBtn.userInteractionEnabled = isSelectBtn;
    if (isSelectBtn && ![GesturePasswordController exist]) {
        [self.navigationController pushViewController:[[GesturePasswordController alloc] initWithType:GesturePasswordTypeReset] animated:YES];
    } else if(!isSelectBtn) { // 关闭密码
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
    _GTPSelectBtn.selected = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_USR_ON_OFF];
    self.GTpasswordBtn.userInteractionEnabled = _GTPSelectBtn.selected;
}

/**
 *  删除toobar
 *
 */
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    [self.tooBar removeFromSuperview];
}


#pragma mark hearViewDelegate
- (void)leftButtonAction {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 设置、监听按钮
- (void)setButtonView {
	[self setButtonBack:self.GTpasswordBtn AndselectorStr:@selector(pushGTpass)];
	[self setButtonBack:self.addressBtn AndselectorStr:@selector(pushadress)];
	[self setButtonBack:self.upgradeBtn AndselectorStr:@selector(pushupgrade)];
	[self setButtonBack:self.opinionBackBtn AndselectorStr:@selector(pushopinionBack)];
	[self setButtonBack:self.statementBtn AndselectorStr:@selector(pushstatement)];
	[self setButtonBack:self.aboutBtn AndselectorStr:@selector(pushabout)];
}

- (void)setButtonBack:(UIButton *)btn AndselectorStr:(SEL)sel {
	[btn setAllStateBg:@"common_card_background.png"];

	[btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)gestureChange:(UIButton *)sender {
	if (_GTPSelectBtn.selected) {
		[self.navigationController pushViewController:[[GesturePasswordController alloc] initWithType:GesturePasswordTypeReset] animated:YES];
	}
}

#pragma mark 监听方法
- (void)pushadress {
	SetAddressViewController *address = [[SetAddressViewController alloc]init];
    address.delegate = self;
	[self.navigationController pushViewController:address animated:YES];
}

//手势密码
- (void)pushGTpass {
	NSLog(@"手势密码");
	NSLog(@"%d", isSelectBtn);
    if(isSelectBtn){
        if(![GesturePasswordController exist]){
            [self.navigationController pushViewController:[[GesturePasswordController alloc] initWithType:GesturePasswordTypeReset] animated:YES];
        }
    } else { // 关闭手势密码

    }
}

- (void)pushupgrade {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您当前已经是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]; [alert show];
	NSLog(@"升级");
}

- (void)pushopinionBack {
	NSLog(@"意见反馈");
}

- (void)pushstatement {
	NSLog(@"声明");
    StateMentViewController *state = [[StateMentViewController alloc]init];
    [self.navigationController pushViewController:state animated:YES];
}

- (void)pushabout {
	AboutingViewController *about = [[AboutingViewController alloc]init];
	[self.navigationController pushViewController:about animated:YES];
	NSLog(@"关于");
}



#pragma mark - SetAddressViewDelegate
- (void)settingIsChange {
    [APP clearUsrLoginInfo];
    [AppDelegate notificationInitController:InitLoginController];
    [Tools showMessage:@"服务地址修改，请重新登录"];
}

@end
