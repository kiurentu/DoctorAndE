//
//  PersonViewController.m
//  Person
//
//  Created by UI08 on 14-10-31.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#define TAG_UPDATE_USER_INFO @"__updateUserInfo__"
#define TAG_SEARCH_USER_INFO @"__searchUserInfo__"
#define TAG_GET_AUTH_INFO    @"__getUserAuthInfo__"
#define TAG_UNLOAD_IMG       @"__imagesUpload__"

#import "PersonViewController.h"
#import "IDtestViewController.h"
#import "DatePickerView.h"
#import "DropMenuView.h"
#import "CircleEdge.h"
#import "STUNet.h"
#import "RegexKitLite.h"
#import "EntityUser.h"
#import "PhotoView.h"
#import "UIImageView+WebCache.h"



@interface PersonViewController () <DatePickerViewDelegate, DropMenuViewDelegate, STUNetDelegate,IDtesDelegate,PhotoViewDelegate>
{
    
    STUNet *_net;
    int _subH;
    
    NSString *_mySfzh;//身份证号码
    BOOL isChangeImage;//是否更换头像
    NSString *_userId;//用户ID
 
}

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;//头像
@property (weak, nonatomic) IBOutlet UIView *IdView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UITextField *trunNameTF;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *IdTF;
@property (weak, nonatomic) IBOutlet UILabel *validateSfzhLabel;

@end

@implementation PersonViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    //UI
    [self prepareUI];
    
    //加载用户信息
    [self loadUserData];

	 _net = [[STUNet alloc] initWithDelegate:self];
    
    [self getUserAuthInfo];//获取审核验证信息

    //给头像添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseHeadClick)];
    [self.headImgView addGestureRecognizer:tap];
    
    
    //键盘处理
    CGRect f = _ContentView.frame;
	_subH = SCREEN_HEIGHT - f.size.height - f.origin.y - 280;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
	                                             name:UIApplicationWillResignActiveNotification object:nil];
}

//ui
-(void)prepareUI
{
    //导航栏左边按扭
    UIBarButtonItem *saveBtn = [Tools createNavigationBarWithTitle:@"保存" andTarget:self action:@selector(save)];
    [self.navigationItem addRightBtn:saveBtn];
    
    //...右边
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"个人资料" withViewController:self];
    
    //绘制View的4个圆角
    [CircleEdge changView:self.IdView];
	 [CircleEdge changView:self.ContentView];
    
    //性别选择
    [self initSex];
}

//加载用户信息
- (void)loadUserData
{
    _mySfzh = [APP getUserInfo].sfzh;
    _trunNameTF.text = [APP getUserInfo].userName;
    _nickNameTF.text = [APP getUserInfo].nickName;
    _IdTF.text =  [APP getUserInfo].sfzh;
    _sexLabel.text = [APP getUserInfo].sex;
    _birthdayLabel.text = [APP getUserInfo].birthday;
    _userId = [APP getUserInfo].userId;
    
    //判断是否有头像，有就加载
    if(![[APP getUserInfo].imagePath isEqualToString:@""]){
        NSURL *url = [NSURL URLWithString:[APP getUserInfo].imagePath];
        //        [_headImgView sd_setImageWithURL:url];
        [_headImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"total-screen__user"]];
    }
    
}

//性别选择
-(void)initSex
{
    NSArray *arr = @[@"男", @"女"];
	DropMenuView *menuView = [[DropMenuView alloc] initWithFrame:CGRectMake(68, 180, 235, 25) withArray:arr withImage:@"" withviewController:self];
	menuView.delegate = self;
	[self.view addSubview:menuView];
	UIImageView *image = [[UIImageView alloc] init];
	image.image = IMAGE(@"panel_details_down_normal.png");
	image.frame = CGRectMake(225, 10, 10, 7);
	[menuView addSubview:image];
    
}

//更新用户资料,获取用户身份验证信息
- (void)searchUserInfo {

    [_net requestTag:TAG_SEARCH_USER_INFO andUrl:URL_SEARCH_USER_INFO andBody:@{}];
}

//获取用户或亲友身份验证信息
-(void)getUserAuthInfo
{
    NSDictionary *dic = @{@"userId":[APP getUserInfo].userId};
    [_net requestTag:TAG_GET_AUTH_INFO andUrl:URL_GET_USER_AUTH_INFO andBody:dic];
}

#pragma mark DropMenuViewDelegate
- (void)clickMenu:(NSString *)str {
	self.sexLabel.text = str;
}

//保存用户资料
- (void)save {

	NSString *userName = _trunNameTF.text;
	NSString *nickName = _nickNameTF.text;
	NSString *sfzh = _IdTF.text;
	NSString *birthday = _birthdayLabel.text;
	NSString *sex = _sexLabel.text;

	if (![userName length]) {
		[_trunNameTF becomeFirstResponder];
		[Tools showMessage:@"请输入您的姓名"];
		return;
	}
	else if (![nickName length]) {
		[_nickNameTF becomeFirstResponder];
		[Tools showMessage:@"请输入您的昵称"];
		return;
	}
	else if (![birthday length]) {
		[Tools showMessage:@"请输入您的出生日期"];
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
    
    if (!isChangeImage) {//没有更换头像
  
        NSDictionary *dic = @{ @"userName":userName, @"nickName":nickName, @"sex":sex, @"birthday":birthday, @"sfzh":sfzh ? sfzh : @"", @"imagePath":@"", @"email":@"" };
        NSDictionary *dic1 = @{ @"obj" : dic };
        [_net requestTag:TAG_UPDATE_USER_INFO andUrl:URL_UPDATE_USER_INFO andBody:dic1 andShowDiaMsg:DEFAULT_TITLE];
  
    }else{//更换头像
        
        [_net requestTag:TAG_UNLOAD_IMG andUnloadImage:_headImgView.image];
    }
}

//选择生日
- (IBAction)birthday:(id)sender {
	[self.view endEditing:YES];
	DatePickerView *datePickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) withDelegate:self];
	[[UIApplication sharedApplication].keyWindow addSubview:datePickerView];
}

//身份验证的点击事件
- (IBAction)IDTest:(id)sender {
	
    if ([self.validateSfzhLabel.text isEqualToString:@"审核中"]) {
        [Tools showMessage:@"审核中，请等待审核结果通知"];
        return;

    }
    
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
    
    if ([_mySfzh isEqualToString:@""]||![_mySfzh isEqualToString:self.IdTF.text]) {
        [Tools showMessage:@"请先保存，再进行身份验证！"];
        return;
    }
    
    if ([self.validateSfzhLabel.text isEqualToString:@"审核中"]) {
        [Tools showMessage:@"审核中，请等待审核结果通知"];
        return;
    }
    
    
	IDtestViewController *ID = [[IDtestViewController alloc] init];
    ID.delegate = self;
    ID.trueName = [APP getUserInfo].userName;
    ID.sfzh = [APP getUserInfo].sfzh;
    ID.Id = [APP getUserInfo].userId;
    ID.idType = IdTypeUser;
	[self.navigationController pushViewController:ID animated:YES];
}

//头像点击触发的方法
- (void)chooseHeadClick{
    
    PhotoView *photoView = [[PhotoView instance] initWithViewController:self withImageArr:nil];
    photoView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:photoView];
    
}

#pragma mark DatePickerViewDelegate
- (void)selectedDate:(NSString *)date {
	self.birthdayLabel.text = date;
}
#pragma mark IDtesDelegate
-(void)upLoadImg{
    
    [self getUserAuthInfo];
    
}

#pragma marl PhotoViewDelegate
-(void)choosePhotoImage:(UIImage *)image
{
    isChangeImage = YES;
    _headImgView.image = image;
    
}


#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
	if ([tag isEqualToString:TAG_UPDATE_USER_INFO]) {
		if (![dic[@"result"] intValue]) {
			[Tools showMessage:@"更新用户资料成功"];
			[self.navigationController popViewControllerAnimated:YES];
            
            [self searchUserInfo];//获取用户资料
		}
	}
	else if([tag isEqualToString:TAG_SEARCH_USER_INFO]){
		if (![dic[@"result"] intValue]) {
			
            NSDictionary *dicUser = dic[@"obj"];
            [[NSUserDefaults standardUserDefaults] setObject:dicUser forKey:KEY_USR_INFO];

		}
		
	}else if([tag isEqualToString:TAG_GET_AUTH_INFO]){
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

    }else if([tag isEqualToString:TAG_UNLOAD_IMG]){
        if (![dic[@"result"] intValue]) {
       
            NSArray *arr = dic[@"list"];//o是原图，t是缩略图
            NSString *imagePathO = arr[0][@"o_path"];
            NSString *userName = _trunNameTF.text;
            NSString *nickName = _nickNameTF.text;
            NSString *sfzh = _IdTF.text;
            NSString *birthday = _birthdayLabel.text;
            NSString *sex = _sexLabel.text;
            //更换头像
           	NSDictionary *dic = @{ @"userName":userName, @"nickName":nickName, @"sex":sex, @"birthday":birthday, @"sfzh":sfzh ? sfzh : @"", @"imagePath":imagePathO ? imagePathO : @"", @"email":@"" };
            NSDictionary *dic1 = @{ @"obj" : dic };
            
            [_net requestTag:TAG_UPDATE_USER_INFO andUrl:URL_UPDATE_USER_INFO andBody:dic1 andShowDiaMsg:DEFAULT_TITLE];
            
            
        }
    }
    
        
        

}

- (void)STUNetRequestFailByTag:(NSString *)tag withDic:(NSDictionary *)dic withError:(NSError *)err withMsg:(NSString *)errMsg {
    if ([TAG_SEARCH_USER_INFO isEqualToString:tag]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self searchUserInfo];
        });
        
    }else{
        [Tools showMessage:dic[@"reason"]];
    }
	
}

- (void)STUNetRequestErrorByTag:(NSString *)tag withError:(NSError *)err {
	[Tools showMessage:@"网络访问失败"];
}

#pragma mark - Notification
- (void)keyboardWillShow:(NSNotification *)ntf {
	if (_subH < 0) {
		[UIView animateWithDuration:.3f animations: ^{
		    CGRect f = self.view.frame;
		    f.origin.y += _subH;
		    self.view.frame = f;
		}];
	}
}

- (void)keyboardWillHide:(NSNotification *)ntf {
	if (_subH < 0) {
		[UIView animateWithDuration:.3f animations: ^{
		    CGRect f = self.view.frame;
		    f.origin.y -= _subH;
		    self.view.frame = f;
		}];
	}
}

- (void)applicationDidBecomeActive:(NSNotification *)ntf {
	[self.view endEditing:YES];
}
@end
