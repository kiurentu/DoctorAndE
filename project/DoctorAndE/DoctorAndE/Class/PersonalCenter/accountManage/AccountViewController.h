//
//  AccountViewController.h
//  Person
//
//  Created by UI08 on 14-10-31.
//  Copyright (c) 2014年 CZA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *mainView;

- (IBAction)phoneBtn:(id)sender;
- (IBAction)passwordBtn:(id)sender;
- (IBAction)addressBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@end
