//
//  AddFamilyViewController.h
//  Person
//
//  Created by UI08 on 14-11-1.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    EditeStyleChage = 0,//修改成员
    EditeStyleAdd       //添加成员
}EditeStyle;


@interface AddFamilyViewController : UIViewController

@property (nonatomic, copy) NSString *xm;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *sfzh;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *validateSfzh;
@property (nonatomic, assign) int isDefaultMembe;
@property (nonatomic, strong) NSString *ringhtItemName;
@property (nonatomic, assign) EditeStyle editeStyle;

@property(nonatomic,copy)void(^addFamilyBlock)(BOOL isDefault);//使用block传值

- (IBAction)IDTestClick:(id)sender;
- (IBAction)datePickerClick:(id)sender;
- (IBAction)defaultClick:(UIButton *)sender;


@end
