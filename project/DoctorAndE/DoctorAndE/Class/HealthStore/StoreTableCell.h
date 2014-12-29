//
//  StoreTableCell.h
//  DoctorAndE
//
//  Created by SmartGit on 14-12-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
