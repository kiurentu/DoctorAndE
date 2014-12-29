//
//  IDtestViewController.m
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#define TAG_UNLOAD_IMG   @"__imagesUpload__"
#define TAG_SAVE_OR_UPDATE_USER_AUTH_INFO @"——saveOrUpdateUserAuthInfo——"

#import "IDtestViewController.h"
#import "CircleEdge.h"
#import "PhotoView.h"
#import "BigPhotoViewController.h"
#import "TranslucentToolbar.h"
#import "STUNet.h"

@interface IDtestViewController ()<PhotoViewDelegate,STUNetDelegate>
{
    NSMutableArray *_arr;
    STUNet *_net;
}

@property (weak, nonatomic) IBOutlet UIView *IDupView;
@property (weak, nonatomic) IBOutlet UIView *IDpicView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *trueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IdLabel;

@property (nonatomic ,strong) TranslucentToolbar *tooBar;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation IDtestViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    UIBarButtonItem *saveBtn = [Tools createNavigationBarWithTitle:@"保存" andTarget:self action:@selector(comminting)];
    [self.navigationItem addRightBtn:saveBtn];

    
    _net = [[STUNet alloc] initWithDelegate:self];
    
	[self adjustView];
    
    _trueNameLabel.text = _trueName;
    _IdLabel.text = _sfzh;
    
    _arr = [NSMutableArray array];
    
    
#warning 测试图片
    UIImage *image = [UIImage imageNamed:@"account_management_pressed.png"];
    self.photoImageView.image = image;
    [_arr addObject:image];
    
    [self checkNum];

	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"身份验证" withViewController:self];

    
    self.tooBar = [[TranslucentToolbar alloc]initWithFrame:CGRectMake(237, 9.5, 40, 25)];
}

-(void)checkNum
{
    if (_arr.count) {
        self.leftBtn.hidden = NO;
        self.rightBtn.hidden = NO;
        self.cancleBtn.hidden = NO;
        self.numLabel.hidden = NO;
    }else{
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = YES;
        self.cancleBtn.hidden = YES;
        self.numLabel.hidden = YES;
    }
    if (_arr.count==1) {
        self.numLabel.text = [NSString stringWithFormat:@"%@",@"1/1"];
    }else if (_arr.count == 2){
        self.numLabel.text = [NSString stringWithFormat:@"%@",@"2/2"];
    }else if (_arr.count>2) {
        [_arr removeObjectAtIndex:0];
    }
}
- (void)adjustView {
    
	[CircleEdge changView:self.contentView];
	[CircleEdge changView:self.IDpicView];
	[CircleEdge changView:self.IDupView];
    
}

- (void)back {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)comminting {
    
#warning 目前只支持上传一张待修改

    if (_arr.count != 0 ) {
       
        [_net requestTag:TAG_UNLOAD_IMG andUnloadImage:_arr[0]];
        
        NSLog(@"提交");
    }else{
        
        [Tools showMessage:@"请选择图片后，再上传"];
    }
  
}

- (IBAction)leftClick:(id)sender {
    if (_arr.count==2&&[self.photoImageView.image isEqual:_arr[0]]) {
        self.photoImageView.image = _arr[1];
        self.numLabel.text = [NSString stringWithFormat:@"%@",@"2/2"];
    }else if(_arr.count==2&&[self.photoImageView.image isEqual:_arr[1]]){
        self.photoImageView.image = _arr[0];
        self.numLabel.text = [NSString stringWithFormat:@"%@",@"1/2"];
    }
}

- (IBAction)rightClick:(id)sender {
    if (_arr.count==2&&[self.photoImageView.image isEqual:_arr[0]]
        ) {
        self.photoImageView.image = _arr[1];
        self.numLabel.text = [NSString stringWithFormat:@"%@",@"2/2"];
    }else if(_arr.count==2&&[self.photoImageView.image isEqual:_arr[1]]){
        self.photoImageView.image = _arr[0];
        self.numLabel.text = [NSString stringWithFormat:@"%@",@"1/2"];
    }
}

- (IBAction)cancleClick:(id)sender {
    
    if (_arr.count==2) {
        if ([self.photoImageView.image isEqual:_arr[0]]) {
            self.photoImageView.image = _arr[1];
            [_arr removeObjectAtIndex:0];
        }else{
            self.photoImageView.image = _arr[0];
            [_arr removeObjectAtIndex:1];
        }
        
    }else if (_arr.count==1) {
        if ([self.photoImageView.image isEqual:_arr[0]]) {
            self.photoImageView.image = nil;
            [_arr removeObjectAtIndex:0];
        }
    }
    [self checkNum];
}

- (IBAction)bigPhotoClick:(id)sender {
    
    if (self.photoImageView.image) {
        BigPhotoViewController *bigVec = [[BigPhotoViewController alloc] init];
        bigVec.bigImage = self.photoImageView.image;
        [self.navigationController pushViewController:bigVec animated:YES];
    }

}

- (IBAction)photoClick:(id)sender {
    
    PhotoView *photoView = [[PhotoView instance] initWithViewController:self withImageArr:_arr];
    photoView.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:photoView];

}
-(void)choosePhotoImage:(UIImage *)image
{
    self.photoImageView.image = image;
    [self checkNum];
    
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
    if ([tag isEqualToString:TAG_UNLOAD_IMG]) {
        if (![dic[@"result"] intValue]) {
            NSArray *arr = dic[@"list"];//o是原图，t是缩略图
            NSString *imagePathO = arr[0][@"o_path"];
            NSDictionary *dic = @{@"sfzImgPaths":imagePathO,@"userId":self.Id,@"sfzh":self.sfzh,@"type":@(self.idType)}; 
            [_net requestTag:TAG_SAVE_OR_UPDATE_USER_AUTH_INFO andUrl:URL_SAVE_OR_UPDATE_USER_AUTH_INFO andBody:@{@"obj": dic} andShowDiaMsg:DEFAULT_TITLE];
            
        }
    }else{
        if (![dic[@"result"] intValue]) {
            [Tools showMessage:@"图片上传成功"];
            if (_delegate && [_delegate respondsToSelector:@selector(upLoadImg)]) {
                [_delegate upLoadImg];
            }
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"UsingNet" object:self];
            [self.navigationController popViewControllerAnimated:YES];
            
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
