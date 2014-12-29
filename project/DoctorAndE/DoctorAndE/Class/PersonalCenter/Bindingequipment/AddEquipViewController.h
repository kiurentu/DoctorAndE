//
//  AddEquipViewController.h
//  DoctorAndE
//
//  Created by kang on 14-11-28.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//  添加设备

#import <UIKit/UIKit.h>

@interface AddEquipViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *numberVIew;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UIButton *ScanBtn;
- (IBAction)scanButtonTapped:(id)sender;

@end
