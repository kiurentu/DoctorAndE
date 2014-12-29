//
//  ScanViewController.h
//  DoctorAndE
//
//  Created by kang on 14-12-15.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//  扫描

typedef void (^symbolDataBlock)(NSString *str);

#import <UIKit/UIKit.h>

@interface ScanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *scanCropView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (nonatomic,copy) symbolDataBlock blcok;
@end
