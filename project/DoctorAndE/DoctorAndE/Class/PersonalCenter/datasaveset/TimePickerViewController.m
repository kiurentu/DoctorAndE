//
//  TimePickerViewController.m
//  医加E
//
//  Created by 张聪 on 14-11-7.
//  Copyright (c) 2014年 Yuniko. All rights reserved.
//

#import "TimePickerViewController.h"
#import "Pager2ViewController.h"

@interface TimePickerViewController ()

@end

@implementation TimePickerViewController

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
}

- (IBAction)YESX:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)NOX:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
