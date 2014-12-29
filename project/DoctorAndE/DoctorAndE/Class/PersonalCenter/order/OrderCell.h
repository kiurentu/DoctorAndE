//
//  OrderCell.h
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderType;
@property (weak, nonatomic) IBOutlet UILabel *orderDate;
@property (weak, nonatomic) IBOutlet UILabel *orderHospital;
@property (weak, nonatomic) IBOutlet UILabel *orderDoctor;
@property (weak, nonatomic) IBOutlet UILabel *orderState;

- (IBAction)orderDelete:(id)sender;


@end
