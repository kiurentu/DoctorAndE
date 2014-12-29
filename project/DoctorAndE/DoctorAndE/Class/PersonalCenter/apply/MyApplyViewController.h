//
//  MyApplyViewController.h
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  我的申请
 */
@interface MyApplyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UITableView *applyTableView;
}
@property (nonatomic, retain) UITableView *applyTableView;

- (IBAction)chooseDate:(id)sender;
- (IBAction)chooseState:(id)sender;


@end
