//
//  MyOrderViewController.h
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UITableView *oederTableView;
}
@property (nonatomic, retain) UITableView *orderTableView;

- (IBAction)chooseDate:(id)sender;
- (IBAction)chooseState:(id)sender;


@end
