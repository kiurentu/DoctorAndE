//
//  AccountAddressViewController.m
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#define TAG_GET_RECEIVER_INFO_LIST @"__getReceiverInfoList__"
#define TAG_DELETE_RECEIVER_INFO @"__deleteReceiverInfo__"

#import "AccountAddressViewController.h"
#import "AccountAddAddressViewController.h"
#import "AccountAddressCell.h"
#import "AddressModel.h"
#import "DeleteAddressView.h"
#import "STUNet.h"
#import "MJRefresh.h"

@interface AccountAddressViewController () <UITableViewDataSource, UITableViewDelegate,AccountAddressCellDelegate,DeleteAddressViewDelegate,STUNetDelegate>
{
    NSMutableArray *_data;//地址数据
    NSMutableArray *_deleteIndexPath;//要删除的cell
    STUNet *_net;
    
    int _starNum;//网络数据的第几页
    
}

@property (weak, nonatomic) IBOutlet UITableView *addressTableView;

@end

@implementation AccountAddressViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"地址管理" withViewController:self];
    
    UIBarButtonItem *addAdressBtn = [Tools createNavigationBarWithImageName:@"navbar_ic添加" withTitle:nil andTarget:self action:@selector(addAdress:)];
    [self.navigationItem addRightBtn:addAdressBtn];

    
    //注册地址更新的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenterLoadData) name:@"UsingNet" object:nil];
    
     _starNum = 1;//默认第1页
     _data = [NSMutableArray array];
     _deleteIndexPath = [NSMutableArray array];
    self.addressTableView.dataSource = self;
	self.addressTableView.delegate = self;
    
    //加载地址数据
     _net = [[STUNet alloc] initWithDelegate:self];
    NSDictionary *dic = @{@"pageSize":@10,@"pageNum":@(_starNum)};
    [_net requestTag:TAG_GET_RECEIVER_INFO_LIST andUrl:URL_GET_RECEIVER_INFO_LIST andBody:dic andShowDiaMsg:DEFAULT_TITLE];
    
    
    [self setupRefresh];// 初始化刷新控件
    
    

}

//加载数据
-(void)loadData
{
    NSDictionary *dic = @{@"pageSize":@"10",@"pageNum":@(_starNum)};
    [_net requestTag:TAG_GET_RECEIVER_INFO_LIST andUrl:URL_GET_RECEIVER_INFO_LIST andBody:dic];
}

//收到通知执行的方法
-(void)notificationCenterLoadData
{
    [_data removeAllObjects];
    _starNum = 1;
    [self loadData];

}

//初始化刷新控件
-(void)setupRefresh
{

    // 上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_addressTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

//上拉刷新执行的方法
-(void)footerRereshing
{

    _starNum++;
    [self loadData];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	AccountAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:[AccountAddressCell ID]];
   
	if (cell == nil) {
		cell = [AccountAddressCell accountAddressCell];
        cell.delegate = self;
	}
    
    cell.addressModel = _data[indexPath.row];
    
    
	return cell;
}

#pragma mark - AccountAddressCellDelegate
-(void)clickLong:(AccountAddressCell *)cell {
    
    NSIndexPath *index = [self.addressTableView indexPathForCell:cell];
    [_deleteIndexPath addObject:index];
    DeleteAddressView *deleteAddressView = [[DeleteAddressView instance] init];
    deleteAddressView.delegate = self;
    deleteAddressView.obj = cell;
    [[UIApplication sharedApplication].keyWindow addSubview:deleteAddressView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [AccountAddressCell cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AccountAddAddressViewController *addAddressVC = [[AccountAddAddressViewController alloc] init];
    addAddressVC.ringhtItemName = @"修改";
    addAddressVC.editeStyle = EditeStyleChage;
    AccountAddressCell *cell  = (AccountAddressCell *)[tableView cellForRowAtIndexPath:indexPath];
    addAddressVC.address = cell.addressModel.address;
    addAddressVC.consignee = cell.addressModel.userName;
    addAddressVC.postalcode = cell.addressModel.postalCode;
    addAddressVC.phone = cell.addressModel.phone;
    addAddressVC.receiverInfoId = cell.addressModel.receiverInfoId;
	[self.navigationController pushViewController:addAddressVC animated:YES];
}
- (void)addAdress:(UIButton*)sender {
	AccountAddAddressViewController *addAddress = [[AccountAddAddressViewController alloc] init];
    addAddress.ringhtItemName = @"添加";
    addAddress.editeStyle = EditeStyleAdd;
	[self.navigationController pushViewController:addAddress animated:YES];
}

- (void)back {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DeleteAddressViewDelegate

-(void)deletAddress:(id)anyObj
{
   
    AccountAddressCell *cell = (AccountAddressCell *)anyObj;

    NSDictionary *dic = @{@"receiverInfoId":cell.receiverInfoId};
    [_net requestTag:TAG_DELETE_RECEIVER_INFO andUrl:URL_DELETE_RECEIVER_INFO andBody:dic andShowDiaMsg:DEFAULT_TITLE];
    NSIndexPath *index = _deleteIndexPath[0];
    [_data removeObjectAtIndex:index.row];
    [_addressTableView deleteRowsAtIndexPaths:_deleteIndexPath withRowAnimation:UITableViewRowAnimationNone];
    [_deleteIndexPath removeAllObjects];
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
    
    if ([tag isEqualToString:TAG_GET_RECEIVER_INFO_LIST]) {
        if (![dic[@"result"] intValue]) {
            
            for (NSDictionary *family in [dic objectForKey:@"list"]) {
               
                AddressModel *familyModel = [AddressModel addressModelWithDict:family];
                [_data addObject:familyModel];
              
            }
            
            [_addressTableView reloadData];
            [_addressTableView footerEndRefreshing];
 
        }

    }else{
        if (![dic[@"result"] intValue]) {
            [Tools showMessage:@"删除成功"];
        }
    }
    
}
- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
	[Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}

-(void)dealloc{
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UsingNet" object:nil];
}

@end
