//
//  AccountPhoneViewController.h
//  Person
//
//  Created by UI08 on 14-11-3.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountPhoneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationTF;
@property (strong, nonatomic) IBOutlet UIView *passWordViw;
@property (weak, nonatomic) IBOutlet UIView *passwordMainView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

- (IBAction)passwordClick:(id)sender;
- (IBAction)getAuthCodeClick:(id)sender;
- (IBAction)commite:(id)sender;


@end
