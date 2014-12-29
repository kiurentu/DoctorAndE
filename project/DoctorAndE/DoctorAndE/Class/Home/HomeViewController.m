//
//  HomeViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "HomeViewController.h"
#import "MyCircleViewController.h"
#import "ChatViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tbView;

@end

@implementation HomeViewController

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
    _tbView.layer.cornerRadius = 3;
    _tbView.layer.borderWidth = 1;
    _tbView.layer.borderColor = RGBA(100, 100, 100, 100).CGColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect f = _tbView.frame;
    f.size.height = VIEW_GET_HEIGHT(self.view) - f.origin.y - 49 - 3;
    f.size.width = SCREEN_WIDTH - 4;
    _tbView.frame = f;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)myCircleClick:(id)sender {
	[self.navigationController pushViewController:[[MyCircleViewController alloc] init] animated:YES];
}

- (IBAction)myServiceClick:(id)sender {
	ChatViewController *chat = [[ChatViewController alloc] init];
    chat.backTitle = @"医加e客服";
	[self.navigationController pushViewController:chat animated:YES];
}

@end
