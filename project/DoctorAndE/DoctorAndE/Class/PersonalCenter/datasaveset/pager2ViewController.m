//
//  pager2ViewController.m
//  医加E
//
//  Created by 张聪 on 14-11-4.
//  Copyright (c) 2014年 Yuniko. All rights reserved.
//

#import "Pager2ViewController.h"
#import "TimePickerViewController.h"
#import "DropMenuView.h"
#import "STUNet.h"
#import "Tools.h"
#import "TranslucentToolbar.h"

@interface Pager2ViewController () <STUNetDelegate>
{
	STUNet *_net;
}
@property (nonatomic ,strong) TranslucentToolbar *tooBar;

@end

@implementation Pager2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	_net = [[STUNet alloc] initWithDelegate:self];
    
	NSArray *arr = @[@"张晓军", @"张晓娟", @"张某某"];
	DropMenuView *menuView1 = [[DropMenuView alloc] initWithFrame:CGRectMake(255, 95, 60, 25) withArray:arr withImage:@"panel_details_down_normal.png" withviewController:self];
	menuView1.menuBlock = ^(NSString *str) {
		_setpeople.text = str;
	};
	[self.view addSubview:menuView1];
    
	DropMenuView *menuView2 = [[DropMenuView alloc] initWithFrame:CGRectMake(255, 125, 60, 25) withArray:arr withImage:@"panel_details_down_normal.png" withviewController:self];
	menuView2.menuBlock = ^(NSString *str) {
		_setpeople2.text = str;
	};
	[self.view addSubview:menuView2];
    
	DropMenuView *menuView3 = [[DropMenuView alloc] initWithFrame:CGRectMake(255, 195, 60, 25) withArray:arr withImage:@"panel_details_down_normal.png" withviewController:self];
	menuView3.menuBlock = ^(NSString *str) {
		_setpeople3.text = str;
	};
	[self.view addSubview:menuView3];
    
	DropMenuView *menuView4 = [[DropMenuView alloc] initWithFrame:CGRectMake(255, 280, 60, 25) withArray:arr withImage:@"panel_details_down_normal.png" withviewController:self];
	menuView4.menuBlock = ^(NSString *str) {
		_setpeople4.text = str;
	};
	[self.view addSubview:menuView4];
    
	DropMenuView *menuView5 = [[DropMenuView alloc] initWithFrame:CGRectMake(255, 310, 60, 25) withArray:arr withImage:@"panel_details_down_normal.png" withviewController:self];
	menuView5.menuBlock = ^(NSString *str) {
		_setpeople5.text = str;
	};
	[self.view addSubview:menuView5];
    
	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"数据保存设置" withViewController:self];
    
    self.tooBar = [[TranslucentToolbar alloc]initWithFrame:CGRectMake(237, 9.5, 40, 25)];
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeCustom];
    b2.backgroundColor = [UIColor clearColor];
	b2.frame = CGRectMake(0, 0, 40, 25);
	[b2 setTitle:@"保存" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tooBar addSubview:b2];
    [self.navigationController.navigationBar addSubview:self.tooBar];
}

/**
 *  删除Toobar
 *
 */
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    [self.tooBar removeFromSuperview];
}

- (void)add:(id)sender
{
    
}

- (IBAction)time:(id)sender {
	TimePickerViewController *time = [[TimePickerViewController alloc] init];
	[self.navigationController pushViewController:time animated:YES];
}

@end
