//
//  moresettingViewController.h
//  医+e
//
//  Created by kang on 14-11-3.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//  更多设置主页面

#import <UIKit/UIKit.h>

@interface MoresettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *GTPasswordView;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UIButton *upgradeBtn;
@property (weak, nonatomic) IBOutlet UIButton *opinionBackBtn;
@property (weak, nonatomic) IBOutlet UIButton *statementBtn;
@property (weak, nonatomic) IBOutlet UIButton *aboutBtn;
@property (weak, nonatomic) IBOutlet UIButton *GTPSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *GTpasswordBtn;

@property (weak, nonatomic) IBOutlet UILabel *adresslabel;
@property (weak, nonatomic) IBOutlet UILabel *upgradelable;
@property (weak, nonatomic) IBOutlet UILabel *opinionBackLabel;
@property (weak, nonatomic) IBOutlet UILabel *statmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *GTPonOffLabel;

@property (weak, nonatomic) IBOutlet UIImageView *addressImg;
@property (weak, nonatomic) IBOutlet UIImageView *upgradeImg;
@property (weak, nonatomic) IBOutlet UIImageView *opinionBackImg;
@property (weak, nonatomic) IBOutlet UIImageView *statmentImg;
@property (weak, nonatomic) IBOutlet UIImageView *aboutImg;

@end
