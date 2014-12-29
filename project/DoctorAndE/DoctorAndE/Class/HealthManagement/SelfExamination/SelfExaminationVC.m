//
//  SelfExaminationVC.m
//  DoctorAndE
//
//  Created by JackNehc on 14-11-21.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "SelfExaminationVC.h"
#import "Tools.h"
#import "BloodPressureVC.h"
#import "BloodSugarVC.h"
#import "BloodClottingVC.h"
#import "TrioxypurineVC.h"
#import "TotalCholesterolVC.h"
@interface SelfExaminationVC ()

@end

@implementation SelfExaminationVC

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
    self.navigationItem.leftBarButtonItem = [Tools createDefaultClickBackBtnWithTitle:@"自助体检" withViewController:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**血压 bloodPressure*/
-(void)btnBloodPressureClick:(id)sender{
    [self.navigationController pushViewController:[[BloodPressureVC alloc]init] animated:YES];
}

/**血糖 bloodSugar*/
- (IBAction)btnBloodSugarClick:(id)sender {
    [self.navigationController pushViewController:[[BloodSugarVC alloc]init] animated:YES];
}

/**血凝 bloodClotting*/
- (IBAction)btnBloodClottingClick:(id)sender {
    [self.navigationController pushViewController:[[BloodClottingVC alloc]init] animated:YES];
}

/**尿酸 trioxypurine*/
- (IBAction)btnTrioxypurineClick:(id)sender {
    [self.navigationController pushViewController:[[TrioxypurineVC alloc]init] animated:YES];
}

/**总胆固醇 totalCholesterol*/
- (IBAction)btnTotalCholesterolClick:(id)sender {
    [self.navigationController pushViewController:[[TotalCholesterolVC alloc]init] animated:YES];
}
@end
