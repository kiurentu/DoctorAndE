//
//  TabBarViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "HealthStoreViewController.h"
#import "HealthManagement.h"
#import "PersonalCentreViewController.h"
#import "BaseNavigationViewController.h"
#import "LoginViewController.h"
#import "STUNet.h"

#define NTFC_SELECT_INDEX   @"ntfcSelectIndex"                  // 一个切换选项卡的通知

#define COLOR_MAIN          RGBA(20.0f, 166.0f, 116.0f, 255.0f) // 主色调
#define BTN_TAG_ADD         1234                                // btn的tag对应index的增加值
#define LABEL_TAG           1001                                // btn中的标签tag

@implementation UIButton (Select)
// 设置按钮选中
- (void)setIsSelect:(BOOL)isSelect {
	self.selected = isSelect;
	UILabel *lb = (UILabel *)[self viewWithTag:LABEL_TAG];

	if (isSelect) {
		self.backgroundColor = COLOR_MAIN;
		lb.textColor = [UIColor whiteColor];
	}
	else {
		self.backgroundColor = [UIColor whiteColor];
		lb.textColor = COLOR_MAIN;
	}
}
@end

@interface TabBarViewController () <TabBarHidden, STUNetDelegate>
{
	UIView *myTabBar;
	UITabBar *tabBar;
	UIView *contentView;
	CGRect orgFram;
	CGRect subFram;
	BOOL hiddenTabBar;        // 是否隐藏TabBar
    BOOL isBeforLogin; // 是否没有登录过
}
@property (strong, nonatomic) STUNet *net;
@end

@implementation TabBarViewController

+ (void)notificationSelectIndex:(SelectIndex)SelectIndex {
	[[NSNotificationCenter defaultCenter] postNotificationName:NTFC_SELECT_INDEX object:@(SelectIndex)];
}

- (void)setTabBarHidden:(BOOL)hidden {
	if (hiddenTabBar == hidden) {
		return;
	}

	hiddenTabBar = hidden;

	if (hidden) {
		contentView.frame = subFram;
	}

	[UIView animateWithDuration:.2f animations: ^{
	    CGRect f = myTabBar.frame;
	    f.origin.x = hidden ? -f.size.width : 0;
	    myTabBar.frame = f;
	} completion: ^(BOOL finished) {
	    if (!hidden) {
	        contentView.frame = orgFram;
		}
	}];
}

// 收到更改选项卡通知
- (void)ntfcSelectIndex:(NSNotification *)notification {
	int i = [notification.object intValue];

	[self chooseIndex:i];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

	if (self) {
		// Custom initialization
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ntfcSelectIndex:) name:NTFC_SELECT_INDEX object:nil];
		[self addTabBar];
	}

	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
    isBeforLogin = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_IS_BEFOR_LOGIN];
    
	BaseNavigationViewController *home = [self createAndInitNavigationController:[HomeViewController class]];
	BaseNavigationViewController *healthStore = [self createAndInitNavigationController:[HealthStoreViewController class]];
	BaseNavigationViewController *healthManagement = [self createAndInitNavigationController:[HealthManagement class]];
	BaseNavigationViewController *personalCentre = [self createAndInitNavigationController:[PersonalCentreViewController class]];
	contentView = self.view.subviews[0];
	orgFram = contentView.frame;
	self.tabBar.hidden = YES;
	CGRect f = [UIScreen mainScreen].bounds;
	subFram = (CGRect) {f.origin, { f.size.width, f.size.height }
	};
	contentView.frame = orgFram;
	self.viewControllers = @[home, healthStore, healthManagement, personalCentre];
    
    if(isBeforLogin) {
        _net = [[STUNet alloc] initWithDelegate:self];
        [_net requestTag:@"requeryUserInfo" andUrl:URL_SEARCH_USER_INFO andBody:@{}];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(!isBeforLogin) {
        [self chooseIndex:1];
    }
}

// 添加自定义选项卡
- (void)addTabBar {
	myTabBar = [[UIView alloc] init];
	myTabBar.frame = self.tabBar.frame;
	myTabBar.backgroundColor = [UIColor whiteColor];
	UIView *line = [[UIView alloc] init];
	line.frame = CGRectMake(0, 0, myTabBar.frame.size.width, 1);
	line.backgroundColor = COLOR_MAIN;
	[myTabBar addSubview:line];
	[self.view addSubview:myTabBar];

	NSArray *norImg = @[@"首页_normal", @"健康商城_normal", @"应用中心_normal", @"个人中心_normal"];
	NSArray *selImg = @[@"首页_pressed", @"健康商城_pressed", @"应用中心_pressed", @"个人中心_pressed"];
	NSArray *title = @[@"首页", @"健康商城", @"健康管理", @"个人中心"];

	int h = myTabBar.frame.size.height;
	int w = myTabBar.frame.size.width / 4;

	for (int i = 0; i != 4; ++i) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake(w * i, 1, w, h - 1);
		[btn setImage:IMAGE(norImg[i]) forState:UIControlStateNormal];
		[btn setImage:IMAGE(norImg[i]) forState:UIControlStateHighlighted];
		[btn setImage:IMAGE(selImg[i]) forState:UIControlStateSelected];

		btn.tag = BTN_TAG_ADD + i;
		[btn addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
		btn.imageEdgeInsets = UIEdgeInsetsMake(-13, .0f, .0f, .0f);

		UILabel *lb = [[UILabel alloc] init];
		lb.text = title[i];
		lb.textColor = COLOR_MAIN;
		lb.backgroundColor = [UIColor clearColor];
		lb.font = [UIFont systemFontOfSize:12];
		[lb sizeToFit];
		CGRect f = lb.frame;
		lb.frame = (CGRect) {
			{ (w - f.size.width) / 2, 30 }, f.size
		};
		lb.tag = LABEL_TAG;
		[btn addSubview:lb];

		if (btn.tag - BTN_TAG_ADD == 0) {
			btn.selected = YES;
			[btn setIsSelect:YES];
		}

		[myTabBar addSubview:btn];
	}
}

// 自定义Tab点击
- (void)tabClick:(UIButton *)sender {
	long tag = sender.tag - BTN_TAG_ADD;

	[self chooseIndex:(int)tag];
}

// 选择选项卡
- (void)chooseIndex:(int)index {
    
	if (index == self.selectedIndex) {
		return;
	}
    
    if(!isBeforLogin && index != 1) {
        UINavigationController *login = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        [login.navigationBar setBackgroundImage:IMAGE(@"total-screen_导航栏normal.png") forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:login animated:YES completion:nil];
        return;
    }

	for (int i = 0; i != 5; ++i) {
		[(UIButton *)[self.view viewWithTag:BTN_TAG_ADD + i] setIsSelect : NO];
	}

	[(UIButton *)[self.view viewWithTag:BTN_TAG_ADD + index] setIsSelect : YES];
	self.selectedIndex = index;
}

// 创建一个导航控制器
- (BaseNavigationViewController *)createAndInitNavigationController:(Class)class {
	__autoreleasing BaseNavigationViewController *nvc = [[BaseNavigationViewController alloc] initWithRootViewController:[[class alloc] init]];

	// nvc.navigationBarHidden = YES;
	[nvc.navigationBar setBackgroundImage:IMAGE(@"total-screen_导航栏normal.png") forBarMetrics:UIBarMetricsDefault];
	nvc.tabBarHiddenDelegate = self;
	return nvc;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NTFC_SELECT_INDEX object:nil];
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
    NSDictionary *dicUser = dic[@"obj"];
    [[NSUserDefaults standardUserDefaults] setObject:dicUser forKey:KEY_USR_INFO];
}

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_net requestTag:@"requeryUserInfo" andUrl:URL_SEARCH_USER_INFO andBody:@{}];
    });
}

@end
