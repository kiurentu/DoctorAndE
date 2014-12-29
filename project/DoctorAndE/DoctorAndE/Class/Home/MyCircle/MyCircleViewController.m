//
//  MyCircleViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-13.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "MyCircleViewController.h"
#import "Tools.h"

@interface MyCircleViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *leftHor;
@property (weak, nonatomic) IBOutlet UIView *rightHor;
@end

@implementation MyCircleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"我的圈子" withViewController:self];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	_rightHor.hidden = YES;
	_scrollView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	CGRect size = _scrollView.frame;
	size.size.width *= 2;
	_scrollView.contentSize = size.size;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (_scrollView.contentOffset.x) {
		_leftHor.hidden = YES;
		_rightHor.hidden = NO;
	}
	else {
		_leftHor.hidden = NO;
		_rightHor.hidden = YES;
	}
}

- (IBAction)btnClick:(id)sender {
	CGPoint p = _scrollView.contentOffset;
	p.x = [[sender titleForState:UIControlStateNormal] length] > 2 ? 0 : SCREEN_WIDTH;
	_scrollView.contentOffset = p;
	[self scrollViewDidEndDecelerating:nil];
}

@end
