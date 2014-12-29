//
//  finshiRegisterViewController.m
//  DoctorAndE
//
//  Created by Krt on 14/11/6.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "FinshiRegisterViewController.h"
#import "TabBarViewController.h"
#import "Tools.h"

@interface FinshiRegisterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tfTip1;
@property (weak, nonatomic) IBOutlet UILabel *tfTip2;
@end

@implementation FinshiRegisterViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

    self.navigationItem.leftBarButtonItem = [Tools createNavigationBarWithImageName:@"icon返回" withTitle:@"账户注册" andTarget:self action:@selector(homeB:)];
    
	_tfTip1.text = [NSString stringWithFormat:@"恭喜您(%@)注册成功！", _name];
	_tfTip2.text = _phone;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)homeB:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
