//
//  ApplyCell.h
//  Medical
//
//  Created by iOS09 on 14-10-31.
//  Copyright (c) 2014年 iOS09. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApplyCellFrame;
@interface ApplyCell : UITableViewCell


@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSArray *applyArray;


@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *hospital;
@property (strong, nonatomic) NSString *state;

@property (strong, nonatomic) IBOutlet UILabel *applyType;
@property (strong, nonatomic) IBOutlet UILabel *applyDate;
@property (strong, nonatomic) IBOutlet UILabel *applyHospital;
@property (strong, nonatomic) IBOutlet UILabel *applyState;

@property (nonatomic, strong) ApplyCellFrame *applyCellFrame;

@end
