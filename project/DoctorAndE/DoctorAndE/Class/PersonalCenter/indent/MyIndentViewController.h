//
//  MyIndentViewController.h
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  我的订单
 */
@interface MyIndentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

{
	IBOutlet UITableView *indentTableView;
}
@property (nonatomic, retain) UITableView *indentTableView;

- (IBAction)indentState:(id)sender;

@end
