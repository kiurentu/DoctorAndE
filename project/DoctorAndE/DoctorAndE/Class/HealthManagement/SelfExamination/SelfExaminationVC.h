//
//  SelfExaminationVC.h
//  DoctorAndE
//
//  Created by JackNehc on 14-11-21.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfExaminationVC : UIViewController
/**
 *  健康管理-自助体检
 */

//血压 bloodPressure
- (IBAction)btnBloodPressureClick:(id)sender;

//血糖 bloodSugar
- (IBAction)btnBloodSugarClick:(id)sender;

//血凝 bloodClotting
- (IBAction)btnBloodClottingClick:(id)sender;

//尿酸 trioxypurine
- (IBAction)btnTrioxypurineClick:(id)sender;

//总胆固醇 totalCholesterol
- (IBAction)btnTotalCholesterolClick:(id)sender;

@end
