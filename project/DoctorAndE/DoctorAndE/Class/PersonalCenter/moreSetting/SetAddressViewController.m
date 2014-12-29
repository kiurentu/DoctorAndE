//
//  SerAddressViewController.m
//  医+e
//
//  Created by kang on 14-11-4.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import "SetAddressViewController.h"
#import "MoresettingViewController.h"
#import "Tools.h"

@interface SetAddressViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *tfHost;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *tfPort;
@end

@implementation SetAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [Tools createNavigationBarWithImageName:@"icon返回" withTitle:@"服务器地址" andTarget:self action:@selector(exitClick:)];
    
	_tfHost.text = APP.rootUrl;
	_tfPort.text = APP.port;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)saveClick:(id)sender {
	[self.view endEditing:YES];

    BOOL isChange = NO;
    
	NSString *host = _tfHost.text;
	NSString *port = _tfPort.text;

	if ([host length]) {
		APP.rootUrl = host;
	}

	if ([port length]) {
		APP.port = port;
        isChange = YES;
	}
    
	[self.navigationController popViewControllerAnimated:YES];
    
    if(isChange && _delegate) {
        [_delegate settingIsChange];
    }
}

- (IBAction)editDidEnd:(id)sender {
	if (sender == _tfHost) {
		[_tfPort becomeFirstResponder];
	}
	else {
		[self saveClick:nil];
	}
}

- (IBAction)disMissKeyborad:(id)sender {
	[self.view endEditing:YES];
}

- (void)exitClick:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
