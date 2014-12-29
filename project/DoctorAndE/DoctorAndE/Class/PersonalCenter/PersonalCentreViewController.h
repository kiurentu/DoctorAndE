//
//  PersonalCentreViewController.h
//  DoctorAndE
//
//  Created by skytoup on 14-11-3.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  个人中心
 */
@interface PersonalCentreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UIView *pesonView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)shopCartBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
