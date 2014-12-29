//
//  HealthFilesViewController.m
//  DoctorAndE
//
//  Created by Krt on 14/11/21.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#define ITEM_BUTTON_WIDTH   7
#import "PullDownMenuProtocol.h"
#import "MyBarBtnItem.h"
#import "HealthFilesViewController.h"
#import "Tools.h"
#import "DetailViewController.h"
#import "NewFileViewController.h"
#import "HealthManagement.h"
#import "TranslucentToolbar.h"

@interface HealthFilesViewController ()

@property(nonatomic,strong)UIToolbar *healthBar;


@end

@implementation HealthFilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem=[Tools createDefaultClickBackBtnWithTitle:@"健康档案" withViewController:self];
    UIButton *spaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    spaceButton.frame = CGRectMake(0, 0, ITEM_BUTTON_WIDTH, ITEM_BUTTON_WIDTH);
    [spaceButton setBackgroundImage:IMAGE(nil) forState:UIControlStateNormal];
    [spaceButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *spaceCarItem = [[UIBarButtonItem alloc]initWithCustomView:spaceButton];
    
    UIBarButtonItem *personB = [Tools createNavigationBarWithImageName:@"navbar_ic个人中心pressed" withTitle:nil andTarget:self action:@selector(pullDownMenu)];
    UIBarButtonItem *addB = [Tools createNavigationBarWithImageName:@"navbar_ic添加" withTitle:nil andTarget:self action:@selector(addFile)];
    [self.navigationItem addRightBtnArray:@[personB,spaceCarItem,addB] ];
    // Do any additional setup after loading the view from its nib.
}
-(void)addFile{
    [self.navigationController pushViewController:[[NewFileViewController alloc]init] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 *  按钮隐藏开关
 */
- (IBAction)turnTo:(id)sender {
    if (self.seedToWho.hidden==YES) {
        self.seedToWho.hidden=NO;
    }else {
        self.seedToWho.hidden=YES;
    }
}
- (IBAction)toDetails:(id)sender {
        [self.navigationController pushViewController:[[DetailViewController alloc]init] animated:YES];
}
-(id)pullDownMenu
{
    return self;
}
@end
