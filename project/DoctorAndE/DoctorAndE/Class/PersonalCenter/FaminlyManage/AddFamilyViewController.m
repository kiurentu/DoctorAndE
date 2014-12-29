//
//  AddFamilyViewController.m
//  Person
//
//  Created by UI08 on 14-11-1.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#define TAG_ADD_RELATIVES   @"__addRelatives__"
#define TAG_EDIT_RELATIVES  @"__editRelatives__"
#define TAG_GET_AUTH_INFO    @"__getUserAuthInfo__"

#import "AddFamilyViewController.h"
#import "CircleEdge.h"
#import "DropMenuView.h"
#import "DatePickerView.h"
#import "IDtestViewController.h"
#import "TranslucentToolbar.h"
#import "STUNet.h"
#import "RegexKitLite.h"

@interface AddFamilyViewController () <DropMenuViewDelegate, DatePickerViewDelegate,STUNetDelegate,IDtesDelegate>
{
    STUNet *_net;
    int _defaultNume;
}
@property (nonatomic ,strong) TranslucentToolbar *tooBar;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *trueNameTF;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UIView *IdView;
@property (weak, nonatomic) IBOutlet UIView *defaultView;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UITextField *IdTF;
@property (weak, nonatomic) IBOutlet UILabel *validateSfzhLabel;
@property (weak, nonatomic) IBOutlet UIButton *IdTestBtn;

@end

@implementation AddFamilyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    //绘制UI
    [self prepareUI];
    
    //加载个人信息
    [self loadData];
    
    _net = [[STUNet alloc] initWithDelegate:self];

   

}

//绘制UI
-(void)prepareUI
{
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"添加成员" withViewController:self];
    UIBarButtonItem *saveBtn = [Tools createNavigationBarWithTitle:self.ringhtItemName andTarget:self action:@selector(commite)];
    [self.navigationItem addRightBtn:saveBtn];
    
	[CircleEdge changView:self.contentView];
    [CircleEdge changView:self.defaultView];
    [CircleEdge changView:self.IdView];
    
    //初始化性比选择
    [self initSex];
}

//加载个人信息
-(void)loadData
{
    self.trueNameTF.text = self.xm;
    self.nickNameTF.text = self.nickname;
    self.IdTF.text = self.sfzh;
    self.sexLabel.text = self.sex;
    self.phoneTF.text = self.mobile;
    self.birthdayLabel.text = self.birthday;
    self.defaultBtn.selected = self.isDefaultMembe;
    
    if (self.editeStyle == EditeStyleAdd) {
        self.validateSfzh = @"3";
    }
    
    switch ([self.validateSfzh intValue]) {
        case 0:
            self.validateSfzhLabel.text = @"审核中";
            break;
        case 1:
            self.validateSfzhLabel.text = @"审核通过";
            break;
        case 2:
            self.validateSfzhLabel.text = @"审核不通过";
            break;
        case 3:
            self.validateSfzhLabel.text = @"未验证";
            break;
            
        default:
            break;
    }
    _defaultNume = 0;//是否是默认成员，0：否 1：是
}

//初始化性比选择
- (void)initSex {
	NSArray *arr = @[@"男", @"女"];
	DropMenuView *menuView = [[DropMenuView alloc] initWithFrame:CGRectMake(68, 150, 235, 25) withArray:arr withImage:@"" withviewController:self];
	menuView.delegate = self;
	[self.view addSubview:menuView];
	UIImageView *image = [[UIImageView alloc] init];
	image.image = IMAGE(@"panel_details_down_normal.png");
	image.frame = CGRectMake(225, 10, 10, 7);
	[menuView addSubview:image];
}

//提交
- (void)commite {
    
	NSString *userName = _trueNameTF.text;
	NSString *nickName = _nickNameTF.text;
	NSString *sfzh = _IdTF.text;
	NSString *birthday = _birthdayLabel.text;
	NSString *sex = _sexLabel.text;
    NSString *mobile = _phoneTF.text;
    
	if (![userName length]) {
		[Tools showMessage:@"请输入您的姓名"];
		return;
	}else if (!mobile.length){
        [Tools showMessage:@"手机号码不可为空"];
        return;
    }else if (([mobile length] != 11) || ![mobile isMatchedByRegex:REGEX_PHONE]){
        [Tools showMessage:@"手机号码错误,请重新输入"];
        return;
    }
    
	if (![sfzh isEqualToString:@""]) {
		if (![sfzh isMatchedByRegex:REGEX_ID]) {
			[Tools showMessage:@"输入身份证号有误，请重新输入"];
			return;
		}
        
		NSString *str1 = nil;
		NSString *str2 = nil;
		BOOL isContinue = NO;
		for (int i = 0; i < 9; i++) {
			if (i == 7) {
				break;
			}
			else {
				str1 = [sfzh substringWithRange:NSMakeRange(i, 1)];
				str2 = [sfzh substringWithRange:NSMakeRange(i + 1, 1)];
				if (fabs([str2 intValue] - [str1 intValue]) == 1) {
					isContinue = true;
				}
				else {
					isContinue = NO;
                    break;
				}
			}
			if (isContinue) {
				[Tools showMessage:@"输入身份证号有误，请重新输入"];
                return;
			}
		}
		if ([sfzh length] == 15 || [sfzh length] == 18) {
			if ([sfzh isMatchedByRegex:REGEX_ID_15] || [sfzh isMatchedByRegex:REGEX_ID_18]) {
				[Tools showMessage:@"输入身份证号有误，请重新输入"];
				return;
			}
		}
	}
    
    NSDictionary *dic;
    if (self.editeStyle == EditeStyleAdd) {
        dic = @{ @"xm":userName, @"nickName":nickName?nickName:@"", @"sex":sex?sex:@"", @"birthday":birthday?birthday:@"", @"sfzh":sfzh ? sfzh : @"",@"mobile":mobile,@"isDefaultMember":@(_defaultNume)};
        [_net requestTag:TAG_ADD_RELATIVES andUrl:URL_ADD_RELATIVES andBody:dic andShowDiaMsg:DEFAULT_TITLE];
    }else{
        
        dic = @{@"id":self.memberId, @"xm":userName, @"nickName":nickName?nickName:@"", @"sex":sex?sex:@"", @"birthday":birthday?birthday:@"", @"sfzh":sfzh ? sfzh : @"",@"mobile":mobile,@"isDefaultMember":@(_defaultNume)};
        [_net requestTag:TAG_EDIT_RELATIVES andUrl:URL_EDIT_RELATIVES andBody:dic andShowDiaMsg:DEFAULT_TITLE];
    }
}

#pragma mark - DropMenuViewDelegate
- (void)clickMenu:(NSString *)str {
	self.sexLabel.text = str;
}

#pragma mark IDtesDelegate
-(void)upLoadImg
{
    [self getUserAuthInfo];
}

#pragma mark DatePickerViewDelegate
- (void)selectedDate:(NSString *)date {
	self.birthdayLabel.text = date;
}


- (IBAction)IDTestClick:(id)sender {
    
    NSString *sfzh = _IdTF.text;
    

    if (![sfzh isEqualToString:@""]) {
		if (![sfzh isMatchedByRegex:REGEX_ID]) {
			[Tools showMessage:@"输入身份证号有误，请重新输入"];
			return;
		}
        
		NSString *str1 = nil;
		NSString *str2 = nil;
		BOOL isContinue = NO;
		for (int i = 0; i < 9; i++) {
			if (i == 7) {
				break;
			}
			else {
				str1 = [sfzh substringWithRange:NSMakeRange(i, 1)];
				str2 = [sfzh substringWithRange:NSMakeRange(i + 1, 1)];
				if (fabs([str2 intValue] - [str1 intValue]) == 1) {
					isContinue = true;
				}
				else {
					isContinue = NO;
                    break;
				}
			}
			if (isContinue) {
				[Tools showMessage:@"输入身份证号有误，请重新输入"];
                return;
			}
		}
		if ([sfzh length] == 15 || [sfzh length] == 18) {
			if ([sfzh isMatchedByRegex:REGEX_ID_15] || [sfzh isMatchedByRegex:REGEX_ID_18]) {
				[Tools showMessage:@"输入身份证号有误，请重新输入"];
				return;
			}
		}
	}else{
        [Tools showMessage:@"身份证号不能为空"];
        return;
        
    }
    
    if ([self.sfzh isEqualToString:@""]||![self.sfzh isEqualToString:self.IdTF.text]) {
        [Tools showMessage:@"请先保存，再进行身份验证！"];
        return;
    }
    
    if ( [self.validateSfzhLabel.text isEqualToString:@"审核中"]) {
        [Tools showMessage:@"审核中，请等待审核结果通知"];
        return;
    }
    
    
    IDtestViewController *ID = [[IDtestViewController alloc] init];
    ID.delegate = self;
    ID.trueName = self.trueNameTF.text;
    ID.sfzh = self.IdTF.text;
    ID.Id = self.memberId;
    ID.idType = IdTypeMember;
	[self.navigationController pushViewController:ID animated:YES];
}

//选择生日
- (IBAction)datePickerClick:(id)sender {
	[self.view endEditing:YES];
	DatePickerView *datePickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) withDelegate:self];
	[[UIApplication sharedApplication].keyWindow addSubview:datePickerView];
}

- (IBAction)defaultClick:(UIButton *)sender {

    self.defaultBtn.selected = !self.defaultBtn.selected;
    if (self.defaultBtn.selected) {
        _defaultNume = 1;
        
    }else{
        _defaultNume = 0;
    }
    if (_addFamilyBlock ) {
        _addFamilyBlock(self.defaultBtn.selected);
    }
}

//获取用户或亲友身份验证信息
-(void)getUserAuthInfo
{
    NSDictionary *dic = @{@"userId":self.memberId};
    [_net requestTag:TAG_GET_AUTH_INFO andUrl:URL_GET_USER_AUTH_INFO andBody:dic];
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
    if ([tag isEqualToString:TAG_ADD_RELATIVES]) {
        if (![dic[@"result"] intValue]) {
            
            [Tools showMessage:@"添加成员成功"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"UsingNet" object:self];
            [self.navigationController popViewControllerAnimated:YES];
    
        }
    }else if([tag isEqualToString:TAG_EDIT_RELATIVES]){
        if (![dic[@"result"] intValue]) {
            [Tools showMessage:@"修改成员成功"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"UsingNet" object:self];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if (![dic[@"result"] intValue]) {
            
            NSDictionary *dic1 = dic[@"obj"];
            
            switch ([dic1[@"status"] intValue]) {
                case 0:
                    self.validateSfzhLabel.text = @"审核中";
                    break;
                case 1:
                    self.validateSfzhLabel.text = @"审核通过";
                    break;
                case 2:
                    self.validateSfzhLabel.text = @"审核不通过";
                    break;
                case 3:
                    self.validateSfzhLabel.text = @"未验证";
                    break;
                    
                default:
                    break;
            }
            
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
