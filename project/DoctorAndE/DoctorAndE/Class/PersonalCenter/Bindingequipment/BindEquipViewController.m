//
//  BindEquipViewController.m
//  DoctorAndE
//
//  Created by kang on 14-11-27.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//  绑定设备
#define TAG_SEARCH_DEVICE_MANAGE_INFO @"__searchDeviceManageInfo__"
#define TAG_SEARCH_USER_INFO @"__searchUserInfo__"
#define TAG_RE_BIND_DEVICE_MANAGE_INFO @"__pcArReBindDeviceManage__"
#import "EntityUser.h"
#import "BindEquipViewController.h"
#import "EquipMode.h"
#import "STUNet.h"
#import "BindingEquipTableViewCell.h"
#import "AddEquipViewController.h"
@interface BindEquipViewController ()<UITableViewDataSource, UITableViewDelegate, STUNetDelegate>
{
    
    BOOL _isBindEq;
    UIButton *_noBindEqBtn;
    NSMutableArray *_bindEquipArray;
	NSMutableArray *_deleteBindEquipArray;
	NSArray *_data;
    NSString *reBindstr;
}
@property (strong, nonatomic) STUNet *net;
@property (strong,nonatomic)  NSString *useID;
@end

@implementation BindEquipViewController

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
    
    _bindEquipArray = [NSMutableArray array];
    _deleteBindEquipArray = [NSMutableArray array];

    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
    _isBindEq = NO;
    //导航栏
    self.tableView.backgroundColor = kGlobalBg;
   	UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
	itemButton.frame = CGRectMake(0, 0, 44, 44);
	[itemButton setTitle:@"添加" forState:UIControlStateNormal];
	[itemButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:itemButton];
    
	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"绑定设备" withViewController:self];
    
    

}

//进入页面获取数据
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _net = [[STUNet alloc] initWithDelegate:self];
    EntityUser *user =APP.getUserInfo;
    _useID = user.userId;
    NSDictionary *dic1 = @{ @"userId": _useID
                            };
    
    [_net requestTag:TAG_SEARCH_DEVICE_MANAGE_INFO andUrl: URL_SEARCH_DEVICE_MANAGE_INFO andBody:dic1 andShowDiaMsg:DEFAULT_TITLE];
    
    
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
  
	if ([tag isEqualToString:TAG_SEARCH_DEVICE_MANAGE_INFO]) {
       
		if ([dic[@"result"] intValue]==0) {

          
            _data = dic[@"list"];
            if (_data.count==0) {
                [Tools showMessage:@"无绑定设备"];
            }

            for (NSDictionary *dict in _data) {
                EquipMode *e = [[EquipMode alloc]initWithDict:dict];
                [_bindEquipArray addObject:e];
            }
            if (_bindEquipArray.count ==0) {
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            }
            [self.tableView reloadData];
		}
		else {
			[Tools showMessage:@"获取绑定设备信息失败"];
		}
	}
	
}

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {

	[Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}

#pragma mark 添加设备
- (void)add:(UIButton*)sender
{
    AddEquipViewController *addEq = [[AddEquipViewController alloc]init];
    [self.navigationController pushViewController:addEq animated:YES];
    
}


#pragma mark UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

	return _bindEquipArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"BindingEquipTableViewCell";
	BindingEquipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil]lastObject];
	}
    
    cell.equipModel = _bindEquipArray[indexPath.row];
    //解绑按钮
    cell.unbindBtn.tag = indexPath.row;
	[cell.unbindBtn addTarget:self action:@selector(unbindMothed:) forControlEvents:UIControlEventTouchUpInside];
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 200;
}
//解绑按钮的方法
- (void)unbindMothed:(UIButton *)btn
{
    [_deleteBindEquipArray addObject:[_bindEquipArray objectAtIndex:btn.tag]];
    EquipMode *eq  =[[EquipMode alloc]init];
    for (eq in _deleteBindEquipArray) {
        reBindstr = eq.serialNumberStr;
    }
    NSDictionary *dic1 = @{ @"userId": _useID,
                            @"serial": reBindstr
                        };
    if (_deleteBindEquipArray != 0) {
        [_bindEquipArray removeObjectsInArray:_deleteBindEquipArray];
    }
   
    
    [_net requestTag:TAG_RE_BIND_DEVICE_MANAGE_INFO andUrl: URL_RE_BIND_DEVICE_MANAGE_INFO andBody:dic1 andShowDiaMsg:DEFAULT_TITLE];
    UIAlertView *dia = [[UIAlertView alloc] initWithTitle:@"已成功解绑，如需再次绑定，请添加设备" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
   
    [dia show];

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
