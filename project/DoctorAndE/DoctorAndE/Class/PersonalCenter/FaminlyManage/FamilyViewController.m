//
//  FamilyViewController.m
//  Person
//
//  Created by UI08 on 14-10-31.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#define TAG_SEARCH_RELATIVES_LIST @"__searchRelativesList__"
#define TAG_DELETE_RELATIVES @"__deleteRelatives__"
#define TAG_SET_DEFAULT_RELATIVE   @"__setDefaultRelative__"

#import "FamilyViewController.h"
#import "FamilyModel.h"
#import "AddFamilyViewController.h"
#import "TranslucentToolbar.h"
#import "FamilyMemberCell.h"
#import "DeleteFamilyView.h"
#import "MJRefresh.h"
#import "STUNet.h"

@interface FamilyViewController () <UITableViewDataSource, UITableViewDelegate,FamilyMemberCellDelegate,DeleteFamilyViewDelegate,STUNetDelegate>
{

	NSMutableArray *_data;//成员数据
    NSMutableArray *_deleteArr;//删除的cell
	BOOL _isEdit; //是否编辑
	BOOL _isSelected;//是否选中
    int _starNum;//加载网络数据的码数
    STUNet *_net;
}

@property (weak, nonatomic) IBOutlet UITableView *familTableView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic ,strong) TranslucentToolbar *tooBar;

@end

@implementation FamilyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenterLoadData) name:@"UsingNet" object:nil];
    
    _starNum = 1;
    _data = [NSMutableArray array];
    _deleteArr = [NSMutableArray array];

	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"家庭成员管理" withViewController:self];

	_familTableView.delegate = self;
	_familTableView.dataSource = self;
    
    [self setupRefresh];// 初始化刷新控件
    
    self.deleteBtn.hidden = YES;//隐藏删除按钮

    
    _net = [[STUNet alloc] initWithDelegate:self];
    
    NSDictionary *dic = @{@"pageSize":@10,@"pageNum":@(_starNum)};
    [_net requestTag:TAG_SEARCH_RELATIVES_LIST andUrl:URL_SEARCH_RELATIVES_LIST andBody:dic andShowDiaMsg:DEFAULT_TITLE];
    
//    UIBarButtonItem *saveBtn = [Tools createNavigationBarWithImageName:@"navbar_ic添加成员pressed" withTitle:@"" andTarget:self action:@selector(addFamily)];
//    [self.navigationItem addRightBtn:saveBtn];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tooBar = [[TranslucentToolbar alloc]initWithFrame:CGRectMake(200, 9.5, 80, 25)];
    self.tooBar.tintColor = [UIColor grayColor];
    
    //导航栏的按钮
    UIButton *itemButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
	itemButton1.frame = CGRectMake(0, 0, 25, 25);
	[itemButton1 setImage:IMAGE(@"add_friend_pressed.png") forState:UIControlStateNormal];
	[itemButton1 setImage:IMAGE(@"add_friend_normal.png") forState:UIControlStateSelected];
	[itemButton1 addTarget:self action:@selector(addFamily) forControlEvents:UIControlEventTouchUpInside];
    [self.tooBar addSubview:itemButton1];
    
	UIButton *itemButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
	itemButton2.frame = CGRectMake(30, 0, 40, 40);
    [itemButton2 setImageEdgeInsets:UIEdgeInsetsMake(-11, 0, 5, 0)];
	[itemButton2 setImage:IMAGE(@"delete_user_relatives_normal.png") forState:UIControlStateNormal];
	[itemButton2 setImage:IMAGE(@"delete_user_relatives_pressed.png") forState:UIControlStateSelected];
	[itemButton2 addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [self.tooBar addSubview:itemButton2];
    
    [self.navigationController.navigationBar addSubview:self.tooBar];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    //去除导航栏按钮
    [self.tooBar removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	FamilyMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:[FamilyMemberCell ID]];
	if (cell == nil) {
		cell = [FamilyMemberCell familyMemberCell];
        cell.delegate = self;
	}

	cell.isEdit = _isEdit;
	cell.familyModel = _data[indexPath.row];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (_isEdit) {
		FamilyMemberCell *cell = (FamilyMemberCell *)[_familTableView cellForRowAtIndexPath:indexPath];
        cell.familyModel.isSelected = !cell.familyModel.isSelected;
		cell.isSelected = cell.familyModel.isSelected;
     
        if (cell.familyModel.isSelected) {
            [_deleteArr addObject:_data[indexPath.row]];
        }else{
            [_deleteArr removeObject:_data[indexPath.row]];
        }

	}else{
       	AddFamilyViewController *add = [[AddFamilyViewController alloc] init];
         add.ringhtItemName = @"修改";
        add.editeStyle = EditeStyleChage;
        FamilyModel *familyModel = (FamilyModel *)_data[indexPath.row];
        add.xm = familyModel.xm;
        add.nickname = familyModel.nickname;
        add.sfzh = familyModel.sfzh;
        add.sex = familyModel.sex;
        add.mobile = familyModel.mobile;
        add.memberId = familyModel.memberId;
        add.birthday = familyModel.birthday;
        add.validateSfzh = familyModel.validateSfzh;
        add.isDefaultMembe = familyModel.isDefaultMember;

        [self.navigationController pushViewController:add animated:YES];
    }
}

#pragma mark FamilyMemberCellDelegate
-(void)clickFamilyMemberDefaultWithFailyCell:(FamilyMemberCell *)familyCell{
    
    int num;
    if (familyCell.familyModel.isDefaultMember) {
        num =0;
        familyCell.familyModel.isDefaultMember =0;
    }else{
        for (FamilyModel *model in _data) {
            model.isDefaultMember = 0;
        }
        num =1;
        familyCell.familyModel.isDefaultMember = 1;
    }

    NSDictionary *dic = @{@"id":familyCell.familyModel.memberId,@"isDefaultMember":@(num)};
    [_net requestTag:TAG_SET_DEFAULT_RELATIVE
              andUrl:URL_SET_DEFAULT_RELATIVE andBody:dic andShowDiaMsg:DEFAULT_TITLE];
  
}

//加载网络数据
- (void)loadData {

    NSDictionary *dic = @{@"pageSize":@(10),@"pageNum":@(_starNum)};
    [_net requestTag:TAG_SEARCH_RELATIVES_LIST andUrl:URL_SEARCH_RELATIVES_LIST andBody:dic];
}

//收到通知执行的方法
-(void)notificationCenterLoadData
{
    [_data removeAllObjects];
    _starNum = 1;
    [self loadData];
}



//添加家庭成员方法
- (void)addFamily {
	AddFamilyViewController *add = [[AddFamilyViewController alloc] init];
    add.ringhtItemName = @"添加";
    add.editeStyle = EditeStyleAdd;
	[self.navigationController pushViewController:add animated:YES];
}

//按钮删除方法
- (void)delete:(UIButton *)btn {
	btn.selected = !btn.selected;
    
	if (btn.selected) {
		_isEdit = YES;
        _deleteBtn.hidden = NO;
	}
	else {
		_isEdit = NO;
        _deleteBtn.hidden = YES;
	}
	for (FamilyModel *familyModel in _data) {
		familyModel.isSelected = NO;
	}
    
	[_familTableView reloadData];
}

- (IBAction)deleteCliclk:(id)sender {
    if (_deleteArr.count != 0) {
        DeleteFamilyView *deleteFamilyView = [[DeleteFamilyView instance] init];
        deleteFamilyView.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:deleteFamilyView];
    }
    
}

#pragma mark - DeleteFamilyViewDelegate
-(void)deletFamilyMember{
    
    if (_deleteArr.count != 0) {
    
        NSString *str;
        for (int i = 0; i < _deleteArr.count; i++) {
            FamilyModel *familyModel = [_deleteArr objectAtIndex:i];
            if (str != nil) {
                str = [NSString stringWithFormat:@"%@,%@",str,familyModel.memberId];
            }else {
                str = [NSString stringWithFormat:@"%@",familyModel.memberId];
            }
        }

        NSDictionary *dic = @{@"id":str};
        [_net requestTag:TAG_DELETE_RELATIVES andUrl:URL_DELETE_RELATIVES andBody:dic andShowDiaMsg:DEFAULT_TITLE];

        
    }
}
// 初始化刷新控件
-(void)setupRefresh
{
    
    //上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_familTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
//上拉调用的方法
-(void)footerRereshing
{
    _starNum++;
    [self loadData];
    
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
    
    if ([tag isEqualToString:TAG_SEARCH_RELATIVES_LIST]) {

        if (![dic[@"result"] intValue]) {
            
            for (NSDictionary *family in [dic objectForKey:@"list"]) {
                
                FamilyModel *familyModel = [FamilyModel FamilyModelWithDict:family];
                [_data addObject:familyModel];
                
            }
            [_familTableView reloadData];
            [_familTableView footerEndRefreshing];
            
        }
        
    }else if([tag isEqualToString:TAG_DELETE_RELATIVES]){
        if (![dic[@"result"] intValue]) {
            [Tools showMessage:@"删除成功"];
            [_data removeObjectsInArray:_deleteArr];
            [_deleteArr removeAllObjects];
            [_familTableView reloadData];
        }
    }else{
        if (![dic[@"result"] intValue]) {
            [Tools showMessage:@"设置成功"];
            [_familTableView reloadData];
            
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
