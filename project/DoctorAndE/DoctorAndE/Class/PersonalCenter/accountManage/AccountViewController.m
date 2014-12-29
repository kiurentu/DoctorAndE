//
//  AccountViewController.m
//  Person
//
//  Created by UI08 on 14-10-31.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountPhoneViewController.h"
#import "AccountPasswordViewController.h"
#import "AccountAddressViewController.h"
#import "CircleEdge.h"
#import "EntityUser.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[CircleEdge changView:self.mainView];

	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"帐号管理" withViewController:self];
    
    _phoneLabel.text = [APP getUserInfo].mobile;
}

- (IBAction)phoneBtn:(id)sender {
	AccountPhoneViewController *phone = [[AccountPhoneViewController alloc] init];
	[self.navigationController pushViewController:phone animated:YES];
}

- (IBAction)passwordBtn:(id)sender {
	AccountPasswordViewController *password = [[AccountPasswordViewController alloc] init];
	[self.navigationController pushViewController:password animated:YES];
}

- (IBAction)addressBtn:(id)sender {
	AccountAddressViewController *address = [[AccountAddressViewController alloc] init];
	[self.navigationController pushViewController:address animated:YES];
}

@end
