//
//  BaseViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-5.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "TabBarViewController.h"
#import "PullDownMenu.h"

@interface BaseNavigationViewController()

@property (nonatomic ,strong) PullDownMenu *pullDownMenu;

@end

@implementation BaseNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isFirst = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if(self.viewControllers.count == 2){
        [_tabBarHiddenDelegate setTabBarHidden:NO];
    }
    //隐藏下拉列表
    [self.pullDownMenu hideChooseListView];
    
    __autoreleasing UIViewController *vc = [super popViewControllerAnimated:animated];
    return vc;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count == 2){
        [_tabBarHiddenDelegate setTabBarHidden:NO];
    }
    //隐藏下拉列表
    [self.pullDownMenu hideChooseListView];
    __autoreleasing NSArray *res = [super popToViewController:viewController animated:animated];
    return res;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    __autoreleasing NSArray *vcs = [super popToRootViewControllerAnimated:animated];
    [_tabBarHiddenDelegate setTabBarHidden:NO];
    return vcs;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(isFirst){
        isFirst = NO;
    }else{
        [_tabBarHiddenDelegate setTabBarHidden:YES];
        
        //下拉菜单
        UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
        b1.frame = CGRectMake(0, 0, 35, 35);
        [b1 setImage:IMAGE(@"navbar_icon更多.png") forState:UIControlStateNormal];
        
        [b1 addTarget:self action:@selector(pullMenuAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *itemMenu1 = [[UIBarButtonItem alloc]initWithCustomView:b1];
        viewController.navigationItem.rightBarButtonItem = itemMenu1;
    }
    [super pushViewController:viewController animated:animated];
}


/**
 *  默认下拉菜单栏
 */
- (void)pullMenuAction {
	if (self.pullDownMenu.item == 0) {
		self.pullDownMenu = [[PullDownMenu alloc] initWithNavigateContoller:self dataSource:nil delegate:nil];
        
		[self.view addSubview:self.pullDownMenu];
		[self.pullDownMenu showChooseListView];
        [self.view endEditing:YES];
	}
	else {
		[self.pullDownMenu hideChooseListView];
	}
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end