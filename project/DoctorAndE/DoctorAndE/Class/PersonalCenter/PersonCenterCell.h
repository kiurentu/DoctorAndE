//
//  personCenterCell.h
//  医+e
//
//  Created by kang on 14-10-30.
//  Copyright (c) 2014年 jinyi10. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersionCenterCellFrame;
@interface PersonCenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *textNmae;
@property (weak, nonatomic) IBOutlet UILabel *detailtext;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) NSArray *array;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@property (nonatomic, strong) PersionCenterCellFrame *personCenterCellFrame;
@end
