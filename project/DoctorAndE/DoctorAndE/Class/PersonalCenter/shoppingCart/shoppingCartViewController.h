//
//  shoppingCartViewController.h
//  DoctorAndE
//
//  Created by kang on 14-11-10.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//  购物车主界面

#import <UIKit/UIKit.h>

@interface ShoppingCartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *AllSelectBtn;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end
