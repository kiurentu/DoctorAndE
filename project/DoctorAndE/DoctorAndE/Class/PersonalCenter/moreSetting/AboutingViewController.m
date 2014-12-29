//
//  AboutingViewController.m
//  DoctorAndE
//
//  Created by kang on 14-11-14.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "AboutingViewController.h"
#import "Tools.h"
@interface AboutingViewController ()

@end

@implementation AboutingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"关于" withViewController:self];
	self.view.backgroundColor = kGlobalBg;
}

@end
