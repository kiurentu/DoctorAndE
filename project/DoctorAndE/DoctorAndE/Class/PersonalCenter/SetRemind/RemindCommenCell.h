//
//  RemindCommenCell.h
//  DoctorAndE
//
//  Created by UI08 on 14-12-19.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RemindCommen;

@interface RemindCommenCell : UITableViewCell

@property (nonatomic, strong) RemindCommen *remindCommen;

@property (weak, nonatomic) IBOutlet UIButton *systemSoundBtn;
@property (weak, nonatomic) IBOutlet UIButton *bellSoundBtn;
@property (weak, nonatomic) IBOutlet UIButton *shockBtn;

+ (NSString *)ID;

+ (id)remindCommenCell;

+(CGFloat)remindCommenCellHeight;





@end
