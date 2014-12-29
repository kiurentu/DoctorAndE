//
//  AccountPasswordViewController.h
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTFNext;

@property (weak, nonatomic) IBOutlet UIView *oldView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIView *pwdNextView;

@property (strong, nonatomic) IBOutlet UIView *successView;

- (IBAction)successClick:(id)sender;

@end
