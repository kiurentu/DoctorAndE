//
//  AccountAddAddressViewController.h
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    EditeStyleChage = 0,//修改地址
    EditeStyleAdd       //添加新地址
}EditeStyle;


@interface AccountAddAddressViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *consigneeView;
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *streetTF;
@property (weak, nonatomic) IBOutlet UITextField *consigneeTF;
@property (weak, nonatomic) IBOutlet UITextField *postalcodeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property(nonatomic,strong) NSString *ringhtItemName;//导航栏右边的名字
@property(nonatomic,copy) NSString *address;//地址
@property(nonatomic,copy) NSString *consignee;//收货人
@property(nonatomic,copy) NSString *postalcode;//邮政编码
@property(nonatomic,copy) NSString *phone;//电话
@property(nonatomic,assign)EditeStyle editeStyle;//选择方式
@property(nonatomic,copy) NSString *receiverInfoId;//地址ID

@end
