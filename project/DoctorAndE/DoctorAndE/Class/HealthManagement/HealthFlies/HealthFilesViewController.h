//
//  HealthFilesViewController.h
//  DoctorAndE
//
//  Created by Krt on 14/11/21.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthFilesViewController : UIViewController

- (IBAction)turnTo:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *seedToWho;
- (IBAction)toDetails:(id)sender;

@end
