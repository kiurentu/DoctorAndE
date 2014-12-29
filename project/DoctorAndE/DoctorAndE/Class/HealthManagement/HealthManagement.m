//
//  AppCentreViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "HealthManagement.h"
#import "SelfExaminationVC.h"
#import "AlarmHistoryViewController.h"
#import "HealthFilesViewController.h"
@interface HealthManagement ()

@end

@implementation HealthManagement

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

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark 自助体检
- (IBAction)pushToSelfExamination:(id)sender {
    [self.navigationController pushViewController:[[SelfExaminationVC alloc]init] animated:YES];
}
#pragma mark 自助体检
- (IBAction)pushToAlarmHistory:(id)sender {
    [self.navigationController pushViewController:[[AlarmHistoryViewController alloc]init] animated:YES];
}
#pragma mark 自助体检
- (IBAction)pushToHealthFiles:(id)sender {
    [self.navigationController pushViewController:[[HealthFilesViewController alloc]init] animated:YES];
}
@end
