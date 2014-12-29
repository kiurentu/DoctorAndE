//
//  SetRemindViewController.m
//  DoctorAndE
//
//  Created by kang on 14-12-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#define KEY_SYSTEM_SOUND (@"__systemSound__") //系统消息是否要声音提醒
#define KEY_BELL_SOUND (@"__bellSound__") //消息是否要声音提醒
#define KEY_SHOCK (@"__shock__") //通知时震动提醒


#define TAG_SEARCH_RELATIVES_LIST @"__searchRelativesList__"
#define TAG_UPDATE_KINSFOLK_SMS_STATUS @"__updateKinsfolkSMSStatus__"

#import "SetRemindViewController.h"
#import "RemindCommenCell.h"
#import "MsmRemindCell.h"
#import "RemindCommen.h"
#import "SetRemind.h"
#import "MJRefresh.h"
#import "STUNet.h"

@interface SetRemindViewController ()<UITableViewDataSource, UITableViewDelegate,STUNetDelegate,PassCellDelegate>
{
	NSMutableArray *_data;//网络数据
    NSMutableArray *_msmData;//存储用户短信设置
    RemindCommenCell *_remindCommenCell;//展示短信提醒的网络数据
    STUNet *_net;
    RemindCommen *_remindCommen;//保存用户操作的信息
    
    BOOL _isFirst;

    int _starNum;

}

@end

@implementation SetRemindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kGlobalBg;
    
    _data = [NSMutableArray array];
    _msmData = [NSMutableArray array];
    _remindCommen = [[RemindCommen alloc] init];
    
    self.tableView.delegate = self;
	self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBCOLOR(229, 229, 229);
    
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"提醒设置" withViewController:self];
    
    UIBarButtonItem *saveBtn = [Tools createNavigationBarWithTitle:@"保存" andTarget:self action:@selector(save)];
    [self.navigationItem addRightBtn:saveBtn];
    
    _starNum = 1;//起始页数
    _net = [[STUNet alloc] initWithDelegate:self];
    NSDictionary *dic = @{@"pageSize":@10,@"pageNum":@(_starNum)};
    [_net requestTag:TAG_SEARCH_RELATIVES_LIST andUrl:URL_SEARCH_RELATIVES_LIST andBody:dic andShowDiaMsg:DEFAULT_TITLE];
    [self setupRefresh];// 初始化刷新控件
    
    //适配IOS7
    if (IOS7) {
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, -49, 0);
    }

}

//保存用户的操作
-(void)save
{

    [[NSUserDefaults standardUserDefaults]setBool:_remindCommenCell.systemSoundBtn.selected forKey:KEY_SYSTEM_SOUND];
    [[NSUserDefaults standardUserDefaults]setBool:_remindCommenCell.bellSoundBtn.selected forKey:KEY_BELL_SOUND];
    [[NSUserDefaults standardUserDefaults]setBool:_remindCommenCell.shockBtn.selected forKey:KEY_SHOCK];
    
    if (_msmData.count != 0) {
        NSDictionary *dic = @{@"list": _msmData};
        [_net requestTag:TAG_UPDATE_KINSFOLK_SMS_STATUS andUrl:URL_UPDATE_KINSFOLK_SMS_STATUS andBody:dic andShowDiaMsg:DEFAULT_TITLE];
        
    }

    
}

//初始化刷新控件
-(void)setupRefresh
{
    //上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
-(void)footerRereshing
{
    _starNum++;
    [self loadData];
    
}

//加载数据
- (void)loadData {
    
    NSDictionary *dic = @{@"pageSize":@(10),@"pageNum":@(_starNum)};
    [_net requestTag:TAG_SEARCH_RELATIVES_LIST andUrl:URL_SEARCH_RELATIVES_LIST andBody:dic];
}

#pragma mark UITableViewDelegate and UITableViewDataSource
//设置section个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    else{
        return _data.count;
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
    
        RemindCommenCell *commenCell = [tableView dequeueReusableCellWithIdentifier:[RemindCommenCell ID]];
        if (commenCell == nil) {
            commenCell = [RemindCommenCell remindCommenCell];
            _remindCommenCell = commenCell;
            commenCell.remindCommen = _remindCommen;
           
        }
        if (!_isFirst) {
            commenCell.systemSoundBtn.selected = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_SYSTEM_SOUND];
            commenCell.bellSoundBtn.selected = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_BELL_SOUND];
            commenCell.shockBtn.selected = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_SHOCK];
            _remindCommen.isSystemSound = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_SYSTEM_SOUND];
            _remindCommen.isBellSound = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_BELL_SOUND];
            _remindCommen.isShock = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_SHOCK];
             commenCell.remindCommen = _remindCommen;
            _isFirst = YES;
        }
        
        return commenCell;
    }else{
        
        MsmRemindCell *msmCell = [tableView dequeueReusableCellWithIdentifier:[MsmRemindCell ID]];
        if (msmCell == nil) {
            msmCell = [MsmRemindCell msmRemindCell];
            msmCell.delegate = self;
        }
        msmCell.setRemid = _data[indexPath.row];
      
      
        return msmCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section ==0) {
        return [RemindCommenCell remindCommenCellHeight];
    }else{
        return [MsmRemindCell msmRemindCellHeight];
    }
}

#pragma mark - PassCellDelegate
-(void)passCell:(MsmRemindCell *)cell
{
    for (NSDictionary *dic in _msmData) {
        if ([dic[@"qyid"] isEqualToString:cell.setRemid.memberId]) {
         
            [_msmData removeObject:dic];
            break;
        }
    }

        NSDictionary *dic = @{@"qyid": cell.setRemid.memberId,@"xm":cell.setRemid.xm,@"status":cell.setRemid.isSelect?@1:@0};
        [_msmData addObject:dic];


}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
    
    if ([tag isEqualToString:TAG_SEARCH_RELATIVES_LIST]) {
        
        if (![dic[@"result"] intValue]) {
           
            for (NSDictionary *remindDic in [dic objectForKey:@"list"]) {
                
                SetRemind *remindModel = [SetRemind setRemindModelWithDict:remindDic];
                [_data addObject:remindModel];

                
            }
   
            [_tableView reloadData];
            [_tableView footerEndRefreshing];
        
        }
    }else{
        
        if (![dic[@"result"] intValue]) {
            
            [Tools showMessage:@"设置成功"];
            
        }
    }
    
}
- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
	[Tools showMessage:dic[@"reason"]];
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}



@end
