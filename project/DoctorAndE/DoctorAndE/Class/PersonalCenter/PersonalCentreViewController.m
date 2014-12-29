//
//  PersonalCentreViewController.m
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#define TAG_SEARCH_USER_INFO @"__searchUserInfo__"
#import "PersonalCentreViewController.h"
#import "PersonCenterCell.h"
#import "PersonCenter.h"
#import "PersionCenterCellFrame.h"
#import "MoresettingViewController.h"
#import "ShoppingCartViewController.h"
#import "PersonViewController.h"
#import "AccountViewController.h"
#import "FamilyViewController.h"
#import "BindEquipViewController.h"
#import "Pager2ViewController.h"
#import "SetRemindViewController.h"
#import "MyApplyViewController.h"
#import "MyOrderViewController.h"
#import "MyIndentViewController.h"
#import "AppDelegate.h"
#import "EntityUser.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import "UIImageView+WebCache.h"

@interface PersonalCentreViewController () <UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
{
    NSArray         *_data;
    NSMutableArray  *_personCenters;
}

@end

@implementation PersonalCentreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    
    if(![[APP getUserInfo].imagePath isEqualToString:@""]){
        NSURL *url = [NSURL URLWithString:[APP getUserInfo].imagePath];
        [_iconImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"total-screen__user"]];
        
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPersonData)];
    [_iconImage addGestureRecognizer:tap];

    //个人中心主页菜单，若需要修改可在PersonCenter.plist修改
    // 加载PersonCenter.plist
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"PersonCenter" withExtension:@"plist"];
    _data = [NSDictionary dictionaryWithContentsOfURL:url][@"zh_CN"];
    _personCenters = [NSMutableArray array];

    // 赋值
    for (int i = 0; i < _data.count - 1; i++) {
        NSMutableArray *_arr = [NSMutableArray array];

        for (NSDictionary *dict in _data[i]) {
            PersonCenter            *person = [[PersonCenter alloc] initWithDict:dict];
            PersionCenterCellFrame  *frame = [[PersionCenterCellFrame alloc]init];
            frame.personCenter = person;
            [_arr addObject:frame];
        }

        [_personCenters addObject:_arr];
    }

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 设置背景
    // 当tableview的样式为Group，如果想更换背景，就必须清除条纹状的backgroundView
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kGlobalBg;

    // 缩小每小组之间的距离
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    // 添加退出按钮的tableview的最底部
    [self addBtn];
    //    self.tableView.tableHeaderView = self.pesonView;
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    EntityUser *user = APP.getUserInfo;
    self.userNameLabel.text = user.nickName;
     [self.tableView reloadData];
   
}

#pragma  mark 添加退出按钮
- (void)addBtn
{
    // 添加退出按钮的tableview的最底部
    UIButton *btnExit = [UIButton buttonWithType:UIButtonTypeCustom];

    btnExit.frame = CGRectMake(10, 5, 300, 40);
    btnExit.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnExit addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    //    设置背景
    NSString *text = [_data lastObject][0][@"name"];
    [btnExit setAllStateBg:@"common_button_red"];
    [btnExit setTitle:text forState:UIControlStateNormal];

    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, 0, 105);
    [footer addSubview:btnExit];
    self.tableView.tableFooterView = footer;
}

#pragma mark 退出
- (void)exit
{
 
    UIAlertView *dia = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    dia.title = @"退出";
    [dia show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex) {
        [APP clearUsrLoginInfo];
        [AppDelegate notificationInitController:InitLoginController];
    }
}

#pragma mark tableview UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _personCenters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = _personCenters[section];

    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"personCenterCell";
    PersonCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil]lastObject];
        cell.indexPath = indexPath;
    }

    cell.personCenterCellFrame = _personCenters[indexPath.section][indexPath.row];
    // 设置cell的背景
    cell.array = _personCenters[indexPath.section];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //修改相应的section和row，可进入相应的页面
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    id  PushView = nil;

    if (section == 0) {
        if (row == 0) {
            PersonViewController *person = [[PersonViewController alloc] init];
            PushView = person;
        }

        if (row == 1) {
            AccountViewController *account = [[AccountViewController alloc] init];
            PushView = account;
        }
    }

    if (section == 1) {
        FamilyViewController *family = [[FamilyViewController alloc] init];
        PushView = family;
    }

    if (section == 2) {
        if (row == 0) {
            BindEquipViewController *bindE = [[BindEquipViewController alloc] init];
            PushView = bindE;
        } if (row == 1) {
            SetRemindViewController *setRemind = [[SetRemindViewController alloc]init];
            PushView = setRemind;
        }

          }

    if (section == 3) {
        if (row == 0) {
            MyIndentViewController *pager1 = [[MyIndentViewController alloc] init];
            PushView = pager1;
        }

        if (row == 1) {
            MyOrderViewController *pager3 = [[MyOrderViewController alloc] init];
            PushView = pager3;
        }

        if (row == 2) {
            MyApplyViewController *pager2 = [[MyApplyViewController alloc] init];
            PushView = pager2;
        }
    }
    
    if (section == 5) {
        NSLog(@"调用短信");
        [self showMessageView];
        
    }

    if (section == 6) {
        MoresettingViewController *more = [[MoresettingViewController alloc]init];
        PushView = more;
    }

    if (PushView) {
        [self.navigationController pushViewController:PushView animated:YES];
    }
}

- (IBAction)shopCartBtnAction:(id)sender
{
    ShoppingCartViewController *shop = [[ShoppingCartViewController alloc]init];

    [self.navigationController pushViewController:shop animated:YES];
}

//发送短信
- (void)showMessageView
{
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
        
//        controller.recipients = [NSArray arrayWithObject:@"10010"];
        controller.body = @"您好,我正在使用医加e,可以自助体检、记录健康档案、免费咨询医生......http://baidu.com";
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
        
//        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
    }else{
         [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}

//MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissViewControllerAnimated:NO completion:nil];//关键的一句   不能为YES
    
    switch ( result ) {
        
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        default:
            break;
    }
}

-(void) alertWithTitle:(NSString *)title msg:(NSString *)msg{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];  
    
}
- (void)pushPersonData{

     PersonViewController *person = [[PersonViewController alloc] init];
    [self.navigationController pushViewController:person animated:YES];
}
@end