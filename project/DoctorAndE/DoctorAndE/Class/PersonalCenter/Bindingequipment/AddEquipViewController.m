//
//  AddEquipViewController.m
//  DoctorAndE
//
//  Created by kang on 14-11-28.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//
#define TAG_SEARCH_USER_INFO @"__searchUserInfo__"
#define TAG_BIND_DEVICE_MANAGE_INFO @"__pcArBindDeviceManage__"

//URL_BIND_DEVICE_MANAGE_INFO

#define  kSymbolData @"symbolData"//条形码
#import "App.h"
#import "EntityUser.h"
#import "STUNet.h"
#import "AddEquipViewController.h"
#import "CircleEdge.h"
#import "ScanViewController.h"
@interface AddEquipViewController ()< STUNetDelegate>
{
    ScanViewController *scan;
}
@property (strong, nonatomic) STUNet *net;
@property (strong,nonatomic)  NSDictionary *useDic;
@property (nonatomic,strong) NSString *numberStr;
@property (nonatomic,strong) NSString *userID;
@end

@implementation AddEquipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = kGlobalBg;
     [CircleEdge changView:self.numberVIew];
    
   //导航栏
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"绑定设备" withViewController:self];
    //修改按钮背景图片
    [self.ScanBtn setAllStateBg:@"more_button_normal.png"];
    

    _net = [[STUNet alloc] initWithDelegate:self];
  
   //保存按钮
    UIBarButtonItem *saveBtn = [Tools createNavigationBarWithTitle:@"保存" andTarget:self action:@selector(SaveClick)];
    [self.navigationItem addRightBtn:saveBtn];
    


    
    EntityUser *user =APP.getUserInfo;
    _userID = user.userId;
    
}

    //保存按钮的方法
-(void)SaveClick
{

    if ([self.numberTF.text isEqualToString:@""])
    {
        [Tools showMessage:@"设备序列号库中不存在"];
    } else{
    
        NSDictionary *dic1 = @{ @"userId": _userID,
                                @"serial":self.numberTF.text
                                };
       
        [_net requestTag:TAG_BIND_DEVICE_MANAGE_INFO andUrl:URL_BIND_DEVICE_MANAGE_INFO andBody:dic1 andShowDiaMsg:DEFAULT_TITLE];
        

        
       
    }

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}

    //离开页面则清除存储的序列号
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.numberTF.text = nil;

}


#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
    if ([tag isEqualToString:TAG_BIND_DEVICE_MANAGE_INFO]) {
        if (![dic[@"result"] intValue]) {
            
            [Tools showMessage:@"绑定设备成功"];

        }else{
            [Tools showMessage:@"设备序列号库中不存在"];
        }
    }
    
}

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
    [Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
    [Tools showMessage:@"网络访问失败"];
}

    //扫一扫按钮的方法
- (IBAction)scanButtonTapped:(id)sender {
    
    scan= [[ScanViewController alloc]init];
    
    __block AddEquipViewController *addVec = self;
    
    scan.blcok = ^(NSString *symbolData){  
        addVec.numberTF.text = symbolData;
    };
    [self.navigationController pushViewController:scan animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
