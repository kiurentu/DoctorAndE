//
//  BloodSugarVC.m
//  DoctorAndE
//
//  Created by JackNehc on 14-11-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "BloodSugarVC.h"
#import "Tools.h"
@interface BloodSugarVC ()

@end

@implementation BloodSugarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"血糖" withViewController:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
