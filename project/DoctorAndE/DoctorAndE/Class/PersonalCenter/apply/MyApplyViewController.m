//
//  MyApplyViewController.m
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import "MyApplyViewController.h"
#import "ApplyMessageViewController.h"
#import "ApplyCell.h"
#import "Apply.h"
#import "DateView.h"
#import "DropMenuView.h"

@interface MyApplyViewController () <DropMenuViewDelegate>

{
	NSArray *_data;
	NSMutableArray *_applys;
}

@end

@implementation MyApplyViewController

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

    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"我的申请" withViewController:self];

	NSURL *url = [[NSBundle mainBundle]URLForResource:@"apply" withExtension:@"plist"];
	_data = [NSDictionary dictionaryWithContentsOfURL:url][@"my_apply"];
	_applys = [NSMutableArray array];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    [self.applyTableView reloadData];
//}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark 列表
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ApplyCellIdentifier";

	ApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ApplyCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = RGBCOLOR(240, 240, 240);
	}
	cell.type = [NSString stringWithFormat:@"%ld", [indexPath row]];


	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ApplyMessageViewController *applyMessage = [[ApplyMessageViewController alloc]init];
	[self.navigationController pushViewController:applyMessage animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat {
	return 120;
}

- (IBAction)chooseDate:(id)sender {
	NSLog(@"点击");
	//_applyTableView.scrollEnabled = NO;
	DateView *text = [DateView instanceDateView];
	text.frame = CGRectMake(0, 0, text.frame.size.width, text.frame.size.height);
	[self.view addSubview:text];
}

- (IBAction)chooseState:(id)sender {
}

@end
