//
//  MyIndentViewController.m
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "MyIndentViewController.h"
#import "IndentCell.h"
#import "IndentViewController.h"

@interface MyIndentViewController ()

@end

@implementation MyIndentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
        self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"我的订单" withViewController:self];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"IndentCellIdentIfier";

	IndentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"IndentCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = RGBCOLOR(240, 240, 240);
	}
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	IndentViewController *indentView = [[IndentViewController alloc]init];
	[self.navigationController pushViewController:indentView animated:(YES)];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 185;
}

- (IBAction)indentState:(id)sender {
}

@end
