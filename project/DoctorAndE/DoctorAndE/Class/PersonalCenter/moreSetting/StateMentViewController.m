//
//  StateMentViewController.m
//  DoctorAndE
//
//  Created by kang on 14-12-1.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "StateMentViewController.h"

@interface StateMentViewController ()

@end

@implementation StateMentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.navigationItem.leftBarButtonItem = [Tools createNavigationBarWithImageName:@"icon返回" withTitle:@"声明" andTarget:self action:@selector(exitClick:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)exitClick:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}
@end
