//
//  AccountAddAddressViewController.m
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#define TAG_SAVE_RECEIVER_INFO @"__upDateAddress__"

#define kDropDownListTag 1000

#import "AccountAddAddressViewController.h"
#import "CircleEdge.h"
#import "LMContainsLMComboxScrollView.h"
#import "LMComBoxView.h"
#import "STUNet.h"
#import "RegexKitLite.h"

@interface AccountAddAddressViewController ()<LMComBoxViewDelegate,STUNetDelegate>
{
    LMContainsLMComboxScrollView *bgScrollView;
    NSMutableDictionary *addressDict;   //地址选择字典
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
    NSString *selectedCity;
    NSString *selectedArea;
    
    NSMutableArray *_arr;
    
    STUNet *_net;
    
}
@end

@implementation AccountAddAddressViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    //绘制UI
    [self prepareUI];
    
    //加载省市区数据
    [self loadAreaData];
    
    
    _net = [[STUNet alloc] initWithDelegate:self];


}

//绘制UI
-(void)prepareUI
{
    //导航栏
    UIBarButtonItem *saveBtn = [Tools createNavigationBarWithTitle:self.ringhtItemName andTarget:self action:@selector(comminting)];
    [self.navigationItem addRightBtn:saveBtn];
    
	self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"添加地址" withViewController:self];
    
    //圆角
	[CircleEdge changView:self.consigneeView];
	[CircleEdge changView:self.areaView];
	[CircleEdge changView:self.addressView];
	[CircleEdge changView:self.emailView];
	[CircleEdge changView:self.phoneView];
}

//加载省市区数据
-(void)loadAreaData
{
    
    //解析全国省市区信息
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    areaDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *components = [areaDic allKeys];
    
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
	NSMutableArray *provinceTmp = [NSMutableArray array];
    NSMutableArray *myProvince = [NSMutableArray array];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        NSDictionary *myDic = @{[tmp objectAtIndex:0]: index};
        [myProvince addObject:myDic];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    province = [NSArray arrayWithArray:provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [NSArray arrayWithArray:[cityDic allKeys]];

    selectedCity = [city objectAtIndex:0];
    district = [NSArray arrayWithArray:[cityDic objectForKey:selectedCity]];
    
    addressDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   province,@"province",
                   city,@"city",
                   district,@"area",nil];
    
    selectedProvince = [province objectAtIndex:0];
    selectedArea = [district objectAtIndex:0];
    
    bgScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 0, 320,  78)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    [self setUpBgScrollView];

    if (self.editeStyle == EditeStyleChage) {
   
    
    for (int i=2; i<9; i++) {
        NSString *subStr = [_address substringToIndex:i];
        for (int l=0; l<province.count;l++) {
            if ([subStr isEqualToString:province[l]]) {
                selectedProvince = subStr;
                for (int j=0; j<province.count; j++) {
                    
                    NSDictionary *dic = myProvince[j];
                    
                    if ([dic.allKeys[0]isEqualToString:subStr]) {
   
                        [self selectAtIndex:j inCombox:_arr[0]];
                        [(LMComBoxView *)_arr[0] setDefaultIndex:j];
                        [(LMComBoxView *)_arr[0] reloadData];
                        
                        NSString *index = [NSString stringWithFormat:@"%i",j];
                        NSDictionary *dic1 = [[areaDic objectForKey:index]objectForKey:subStr];
                        NSDictionary *dic3 = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:subStr]];
                        
                        NSArray *cityArrayKey = [dic3 allKeys];
                        NSMutableArray *cityArrSums = [NSMutableArray array];
                        
                        for (int i=0; i<cityArrayKey.count; i++) {
                            NSString *index = [NSString stringWithFormat:@"%i",i];
                            NSDictionary *cityDics =dic1[index];
                            NSString *myCity =[cityDics allKeys][0];
                            [cityArrSums addObject:myCity];
               
                            
                        }
                        
                        for (int k =2; k<_address.length-i; k++) {
                    
                            NSString *subStrCity = [_address substringWithRange:NSMakeRange(i, k)];
                            
                            for (int x=0; x<cityArrSums.count; x++) {
   
                                if ([subStrCity isEqualToString:cityArrSums[x]]) {
                                    selectedCity = subStrCity;
                                    
                                    [self selectAtIndex:x inCombox:_arr[1]];
                                                               [(LMComBoxView *)_arr[1] setDefaultIndex:x];
                                                                    [(LMComBoxView *)_arr[1] reloadData];
                                    NSString *index = [NSString stringWithFormat:@"%i",x];
                                    
                                    NSArray *areaArr =dic3[index][subStrCity];
                                    
                                    for (int a=2; a<_address.length-subStr.length-subStrCity.length; a++) {
                                        NSString *subStrArea = [_address substringWithRange:NSMakeRange(subStr.length+subStrCity.length, a)];
                                        for (int a=0; a<areaArr.count; a++) {
                                            if ([subStrArea isEqualToString:areaArr[a]]) {
                                                selectedArea = subStrArea;
                                               
                                                   [self selectAtIndex:a inCombox:_arr[2]];
                                                   [(LMComBoxView *)_arr[2] setDefaultIndex:a];
                                                   [(LMComBoxView *)_arr[2] reloadData];
    
                                                break;
                                                
                                            }
      
                                        }
                                        
                                    }

                                    break;
                                    
                                }

                            }
    
                        }

                        break;
                    }
                    
                }
  
                break;
            }
            
        }
    }
    }else{
        _address = [NSString stringWithFormat:@"%@%@%@",selectedProvince,selectedCity,selectedArea];
    }
    NSString *street;
    if (self.editeStyle == EditeStyleChage) {
        
        street = [_address substringFromIndex:selectedProvince.length+selectedCity.length+selectedArea.length];
    }

    self.streetTF.text = street;
    self.consigneeTF.text = self.consignee;
    self.postalcodeTF.text = self.postalcode;
    self.phoneTF.text = self.phone;
    

}
-(void)setUpBgScrollView
{
    _arr = [NSMutableArray array];
    NSArray *keys = [NSArray arrayWithObjects:@"province",@"city",@"area", nil];
    for(NSInteger i=0;i<3;i++)
    {
        LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(60+(90)*i, 38, 70, 33) withViewController:self];
        comBox.backgroundColor = [UIColor whiteColor];
        comBox.arrowImgName = @"down_dark0.png";
        NSMutableArray *itemsArray = [NSMutableArray arrayWithArray:[addressDict objectForKey:[keys objectAtIndex:i]]];
        comBox.titlesList = itemsArray;
        comBox.delegate = self;
        comBox.supView = bgScrollView;
        [comBox defaultSettings];
        comBox.tag = kDropDownListTag + i;
        [bgScrollView addSubview:comBox];
        
        [_arr addObject:comBox];

    }
}

#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    
    NSInteger tag = _combox.tag - kDropDownListTag;
    switch (tag) {
        case 0:
        {
            selectedProvince =  [[addressDict objectForKey:@"province"]objectAtIndex:index];
            //字典操作
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%d", index]]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
            NSArray *cityArray = [dic allKeys];
            NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;//递减
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;//上升
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i=0; i<[sortedArray count]; i++) {
                NSString *index = [sortedArray objectAtIndex:i];
                NSArray *temp = [[dic objectForKey: index] allKeys];
                [array addObject: [temp objectAtIndex:0]];
            }
            city = [NSArray arrayWithArray:array];
            
            NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
            district = [NSArray arrayWithArray:[cityDic objectForKey:[city objectAtIndex:0]]];
            //刷新市、区
            addressDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           province,@"province",
                           city,@"city",
                           district,@"area",nil];
            LMComBoxView *cityCombox = (LMComBoxView *)[bgScrollView viewWithTag:tag + 1 + kDropDownListTag];
            cityCombox.titlesList = [NSMutableArray arrayWithArray:[addressDict objectForKey:@"city"]];
            [cityCombox reloadData];
            LMComBoxView *areaCombox = (LMComBoxView *)[bgScrollView viewWithTag:tag + 2 + kDropDownListTag];
            areaCombox.titlesList = [NSMutableArray arrayWithArray:[addressDict objectForKey:@"area"]];
            [areaCombox reloadData];
            
            selectedCity = [city objectAtIndex:0];
            selectedArea = [district objectAtIndex:0];
            break;
        }
        case 1:
        {
            
            selectedCity = [[addressDict objectForKey:@"city"]objectAtIndex:index];
            
            NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[province indexOfObject: selectedProvince]];
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
            NSArray *dicKeyArray = [dic allKeys];
            NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: index]]];
            NSArray *cityKeyArray = [cityDic allKeys];
            district = [NSArray arrayWithArray:[cityDic objectForKey:[cityKeyArray objectAtIndex:0]]];
            
            //刷新区
            addressDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           province,@"province",
                           city,@"city",
                           district,@"area",nil];
            LMComBoxView *areaCombox = (LMComBoxView *)[bgScrollView viewWithTag:tag + 1 + kDropDownListTag];
            areaCombox.titlesList = [NSMutableArray arrayWithArray:[addressDict objectForKey:@"area"]];
            [areaCombox reloadData];
            
            selectedArea = [district objectAtIndex:0];

            break;
        }
        case 2:
        {
            selectedArea = [[addressDict objectForKey:@"area"]objectAtIndex:index];
            break;
        }
        default:
            break;
    }
    if (self.editeStyle == EditeStyleAdd) {
        _address = [NSString stringWithFormat:@"%@%@%@",selectedProvince,selectedCity,selectedArea];
    }


}

//提交
- (void)comminting {
    
    NSString *street = _streetTF.text;
    NSString *consignee = _consigneeTF.text;
    NSString *phone = _phoneTF.text;
    NSString *postalcode = _postalcodeTF.text;
    
    if (!street.length) {
        [Tools showMessage:@"街道地址不可为空"];
        return;
    }else if (!consignee.length){
        [Tools showMessage:@"收货人姓名不可为空"];
        return;
    }else if (!phone.length){
        [Tools showMessage:@"手机号码不可为空"];
        return;
    }else if (([phone length] != 11) || ![phone isMatchedByRegex:REGEX_PHONE]){
        [Tools showMessage:@"手机号码错误,请重新输入"];
        return;
    }else if ([postalcode length]&&![postalcode isMatchedByRegex:REGEX_POSTAL_CODE]){
        [Tools showMessage:@"邮编不正确"];
        return;
    }
    
    NSDictionary *dic;
    if ([self.ringhtItemName isEqualToString:@"添加"]) {

        _address = [NSString stringWithFormat:@"%@%@",_address,street];
        dic  = @{@"userName": consignee,@"address":_address,@"mobile":phone,@"postalCode":postalcode?postalcode:@""};

    }else{
        
        _address = [NSString stringWithFormat:@"%@%@%@%@",selectedProvince,selectedCity,selectedArea,street];
        dic = @{@"userName": consignee,@"address":_address,@"mobile":phone,@"postalCode":postalcode?postalcode:@"",@"receiverInfoId":self.receiverInfoId};

 
    }
        [_net requestTag:TAG_SAVE_RECEIVER_INFO andUrl:URL_SAVE_RECEIVER_INFO andBody:dic andShowDiaMsg:@"数据上传中，请稍后"];
 
}

#pragma mark - STUNetDelegate
- (void)STUNetRequestSuccessByTag:(NSString *)tag withDic:(NSDictionary *)dic {
    if ([tag isEqualToString:TAG_SAVE_RECEIVER_INFO]) {
        if (![dic[@"result"] intValue]) {
            
            [Tools showMessage:@"保存地址成功"];
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
