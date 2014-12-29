//
//  ChatViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-14.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatViewToolBar.h"
#import "IQKeyboardManager.h"

@interface ChatViewController () <UITextViewDelegate, UITableViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *tbView;
@property (strong, nonatomic) ChatViewToolBar *toolView;
@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.

    if(!_backTitle) {
        self.backTitle = @"";
    }
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:self.backTitle withViewController:self];
    
	self.toolView = [[ChatViewToolBar instance] init];

	int th = _toolView.frame.size.height;

	self.tbView = [[UITableView alloc] initWithFrame:(CGRect) {
	                   {0, 0 }, { SCREEN_WIDTH, SCREEN_HEIGHT - th - 64 }
				   }];
    _tbView.backgroundColor = kGlobalBg;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tbView.delegate = self;
    
    _toolView.tbView = _tbView;
    
	[self.view addSubview:_tbView];
	[self.view addSubview:_toolView];
    
    
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

#pragma mark - UITableView
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.view endEditing:YES];
	return indexPath;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self.view endEditing:YES];
}

@end
